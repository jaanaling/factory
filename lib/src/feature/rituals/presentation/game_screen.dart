import 'dart:async';
import 'dart:math';

import 'package:balloon_puzzle_factory/src/core/utils/app_icon.dart';
import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:balloon_puzzle_factory/src/core/utils/size_utils.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/balloon.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/collection.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/grid.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/holiday.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/utils/logic.dart';
import 'package:balloon_puzzle_factory/ui_kit/animated_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/app_button.dart';
import 'package:balloon_puzzle_factory/ui_kit/sound_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/bloc/user_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class GameScreen extends StatefulWidget {
  final int difficalty;

  const GameScreen({super.key, required this.difficalty});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int gridWidth = 4;
  final int gridHeight = 6;
  final Set<int> collection = {};

  late double cellSize; // пиксельный размер одной ячейки

  late BoxGrid boxGrid;

  final Map<String, Balloon> allBalloons = {};
  final List<String> conveyorIds = [];

  int score = 0;
  int timeLeft = 60;
  late Timer gameTimer;
  late Timer conveyorTimer;

  late HolidayCondition selectedHoliday;

  final Random random = Random();

  int boxesSent = 0;
  int boosterUsesTotal = 0;
  int giantPlacedCount = 0;
  Set<String> usedHolidays = {};
  int timeForLastBox = 0;
  int currentScore = 0;

  @override
  void initState() {
    super.initState();

    playMusic();
    // Инициализируем сетку коробки
    boxGrid = BoxGrid(width: gridWidth, height: gridHeight);

    // Случайно выбираем праздник
    selectedHoliday =
        holidayConditions[random.nextInt(holidayConditions.length)];

    // Таймер игры
    gameTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;
        if (timeLeft <= 0) {
          final oldUser = (context.read<UserBloc>().state as UserLoaded).user;
          final newUser = oldUser.copyWith(
              record: max(oldUser.record, score),
              coins: oldUser.coins + (score > 0 ? score ~/ 100 : 0));
          context.read<UserBloc>().add(UserPuzzleSolved(user: newUser));
          t.cancel();
          _endGame();
        }
      });
    });

    // Таймер движения конвейера
    conveyorTimer = Timer.periodic(const Duration(milliseconds: 50), (t) {
      _moveConveyor();
    });

    // Периодически добавляем шары на конвейер (каждые 2 секунды)
    Timer.periodic(Duration(microseconds: 500000 ~/ 3 * widget.difficalty),
        (t) {
      if (timeLeft <= 0) {
        t.cancel();
      } else {
        _addConveyorBalloon();
      }
    });

    // Периодический спавн бустеров
    _spawnBoosters();
  }

  @override
  void dispose() {
    gameTimer.cancel();
    conveyorTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cellSize = getWidth(context, percent: 0.1);
    final boxPxWidth = gridWidth * cellSize * 3;
    final boxPxHeight = gridHeight * cellSize * (1 / 3);
    final gridPxWidth = gridWidth * cellSize;
    final gridPxHeight = gridHeight * cellSize;

    // Собираем шары, которые сейчас в коробке
    final boxBalloons = allBalloons.values.where((b) => b.isInBox).toList();

    return Stack(
      children: [
        Row(
          children: [
            // Левая часть - конвейер
            SizedBox(
              width: 70,
              height: double.infinity,
              child: Stack(
                children: [
                  ConveyorBelt(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: conveyorIds.map((id) {
                      final b = allBalloons[id]!;
                      return Positioned(
                        left: 15, // центр
                        bottom: b.conveyorY,
                        child: _buildConveyorBalloonWidget(b),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Правая часть - коробка + кнопки
            Expanded(
              child: SafeArea(
                left: false,
                right: false,
                bottom: false,
                child: Column(
                  children: [
                    SizedBox(
                        height: getHeight(
                      context,
                      baseSize: 240,
                    )),
                    Expanded(
                      child: Container(
                        width: boxPxWidth,
                        height: boxPxHeight,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AppIcon(asset: IconProvider.box.buildImageUrl()),
                            // Слой DragTargets (каждая клетка)
                            Padding(
                              padding: EdgeInsets.only(
                                  left: cellSize / 1.7, top: cellSize / 4),
                              child: SizedBox(
                                width: gridPxWidth,
                                height: gridPxHeight,
                                child: Stack(
                                  children: [..._buildBoxCellTargets()],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: cellSize / 1.7, top: cellSize / 4),
                              child: SizedBox(
                                width: gridPxWidth,
                                height: gridPxHeight,
                                child: Stack(
                                  children: [
                                    ...boxBalloons
                                        .map((b) => _buildBoxBalloonWidget(b))
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                AppIcon(
                                  asset: IconProvider.papper.buildImageUrl(),
                                  height: getHeight(context, percent: 0.12),
                                ),
                                Text(
                                  selectedHoliday.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Shadows Into Light",
                                      color: Colors.black),
                                ),
                              ]),
                            ),
                            // Слой шары
                          ],
                        ),
                      ),
                    ),
                    Gap(10),
                    AppButton(
                      onPressed: () {
                        _onSend();
                      },
                      title: 'SEND',
                    ),
                    Gap(getHeight(
                      context,
                      baseSize: 320,
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: AppIcon(
            asset: IconProvider.notice.buildImageUrl(),
            width: getWidth(
              context,
              baseSize: 300,
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: AppIcon(
                    asset: IconProvider.back.buildImageUrl(),
                    width: getWidth(
                      context,
                      baseSize: 103,
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AppIcon(
                      asset: IconProvider.buttonA.buildImageUrl(),
                      width: getWidth(
                        context,
                        baseSize: 240,
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      width: getWidth(
                            context,
                            baseSize: 240,
                          ) -
                          getWidth(
                            context,
                            baseSize: 83,
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(timeLeft.toString()),
                          AppIcon(
                            asset: IconProvider.timer.buildImageUrl(),
                            width: getWidth(
                              context,
                              baseSize: 44,
                            ),
                            fit: BoxFit.fitWidth,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AppIcon(
                      asset: IconProvider.buttonA.buildImageUrl(),
                      width: getWidth(
                        context,
                        baseSize: 240,
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                    SizedBox(
                      width: getWidth(
                            context,
                            baseSize: 240,
                          ) -
                          getWidth(
                            context,
                            baseSize: 83,
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(score.toString()),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _endGame() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Время вышло"),
        content: Text("Игра завершена!\nВаш счёт: $score"),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(); // Закрываем диалог
              context.pop(); // Закрываем экран игры
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  /// Генерируем новый шар
  void _addConveyorBalloon() {
    final shape =
        BalloonShape.values[random.nextInt(BalloonShape.values.length)];
    final color = allColors[random.nextInt(allColors.length)];
    final hasCollector =
        random.nextDouble() < 0.005; // 15% - коллекционный предмет
    // Начальная координата Y - за нижней границей
    final startY = 600.0;

    final balloon = Balloon(
      id: UniqueKey().toString(),
      color: color,
      shape: shape,
      hasCollectorItem: hasCollector,
      conveyorY: startY,
    );
    allBalloons[balloon.id] = balloon;

    setState(() {
      conveyorIds.add(balloon.id);
    });
  }

  /// Двигаем шары вверх
  void _moveConveyor() {
    setState(() {
      final toRemove = <String>[];
      for (final id in conveyorIds) {
        final b = allBalloons[id]!;
        b.conveyorY -= 3.5 * widget.difficalty; // скорость
        if (b.conveyorY < -100) {
          toRemove.add(id);
        }
      }
      conveyorIds.removeWhere(toRemove.contains);
    });
  }

  /// Появление бустеров: раз в 5..8 сек, активны 3 секунды
  void _spawnBoosters() {
    void spawnOne() {
      final idx = random.nextInt(boxGrid.cells.length);
      boxGrid.cells[idx].isBooster = true;
      setState(() {});
      Timer(const Duration(seconds: 3), () {
        if (idx < boxGrid.cells.length) {
          boxGrid.cells[idx].isBooster = false;
        }
        setState(() {});
      });
    }

    void scheduleNext() {
      final delay = 5 + random.nextInt(4); // 5..8
      Timer(Duration(seconds: delay), () {
        if (timeLeft <= 0) return;
        spawnOne();
        scheduleNext();
      });
    }

    scheduleNext();
  }

  /// Кнопка "Send" - подсчёт очков
  void _onSend() {
    final filled = boxGrid.filledCellsCount;
    final total = boxGrid.totalCells;
    int boxScore = 100;

    if (filled < total) {
      boxScore -= (total - filled) * 2; // штраф за пустые ячейки
    }

    // Собираем все ID шаров в коробке
    final placedIds = <String>{};
    for (final c in boxGrid.cells) {
      if (c.balloonId != null) {
        placedIds.add(c.balloonId!);
      }
    }

    // Штраф/бонус за цвет и бустер
    for (final cell in boxGrid.cells) {
      if (cell.balloonId != null) {
        final balloon = allBalloons[cell.balloonId!];
        if (balloon != null) {
          // Проверяем цвет: если шар не входит в allowedColors => штраф
          if (!selectedHoliday.allowedColors.contains(balloon.color)) {
            boxScore -= 5;
          }
          // Бустер
          if (cell.isBooster) {
            boxScore += 5;
          }
        }
      }
    }

    // Бонус за коллекционный предмет
    for (final id in placedIds) {
      final b = allBalloons[id];
      if (b != null && b.hasCollectorItem) {
        boxScore += 10;
      }
    }

    setState(() {
      score += boxScore;
      selectedHoliday =
          holidayConditions[random.nextInt(holidayConditions.length)];
    });

    boxesSent++; // увеличиваем счётчик отправленных коробок
    final placedBalloonIds = placedIds.toList();

    // Пример вычисления:
    final bool containsCollector =
        placedBalloonIds.any((id) => allBalloons[id]!.hasCollectorItem);
    final bool isBoxFull = (boxGrid.filledCellsCount == boxGrid.totalCells);

    if (containsCollector) {
      collection.add(collections[random.nextInt(collections.length)].id);
    }

    usedHolidays.add(selectedHoliday.name);
    giantPlacedCount++;
    currentScore += boxScore;

    checkAchievements(
      achievementsData:
          (context.read<UserBloc>().state as UserLoaded).achievements,
      user: (context.read<UserBloc>().state as UserLoaded).user,
      boxesSent: boxesSent,
      timeForLastBox: timeForLastBox,
      containsCollector: containsCollector,
      noColorPenalty: true,
      boosterUsesTotal: boosterUsesTotal,
      timeLeft: timeLeft,
      isBoxFull: isBoxFull,
      distinctHolidaysUsed: usedHolidays.length,
      giantPlacedCount: giantPlacedCount,
      currentScore: currentScore,
      context: context,
    );

    // Очищаем коробку (убираем шары)
    for (final id in placedIds) {
      boxGrid.remove(id);
      allBalloons.remove(id);
    }
  }

  /// Виджет шара на конвейере
  Widget _buildConveyorBalloonWidget(Balloon balloon) {
    return Draggable<Balloon>(
      data: balloon,
      feedback: _buildBalloonImage(balloon, isDragging: true),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildBalloonImage(balloon, forConveyor: true),
      ),
      onDragCompleted: () {
        // Если шар принялся коробкой, убираем его с конвейера
        // (это сделаем в onAccept). Если не приняли, onDraggableCanceled
        // оставит шар на месте.
      },
      onDraggableCanceled: (_, __) {
        // Не приняли - шар остался
      },
      child: _buildBalloonImage(balloon, forConveyor: true),
    );
  }

  /// Единая функция для отрисовки шара
  /// - forConveyor: если true, рисуем маленькую версию (например, 40x40)
  /// - иначе (в коробке) рисуем полный размер (исходя из кол-ва клеток)
  Widget _buildBalloonImage(Balloon balloon,
      {bool forConveyor = false, bool isDragging = false}) {
    final asset = getBalloonAsset(balloon.shape);
    if (forConveyor) {
      return AppIcon(
        asset: asset,
        width: 40,
        height: 40,
        color: balloon.color,
      );
    } else {
      final size = getBalloonGridSize(balloon.shape);
      final w = size.width * cellSize;
      final h = size.height * cellSize;
      return Opacity(
        opacity: isDragging ? 0.8 : 1.0,
        child: AppIcon(
          asset: asset,
          width: w,
          height: h,
          color: balloon.color,
        ),
      );
    }
  }

  /// Генерируем набор DragTarget для каждой клетки коробки
  List<Widget> _buildBoxCellTargets() {
    final widgets = <Widget>[];

    for (int y = 0; y < gridHeight; y++) {
      for (int x = 0; x < gridWidth; x++) {
        final cell = boxGrid.cellAt(x, y)!;
        widgets.add(
          Positioned(
            left: x * cellSize,
            top: y * cellSize,
            child: DragTarget<Balloon>(
              builder: (context, candidate, rejected) {
                bool isValidPlacement = false;
                Color highlightColor = Colors.transparent;

                if (candidate.isNotEmpty) {
                  final incoming = candidate.first;

                  if (incoming != null) {
                    // Получаем размер шара
                    final sz = getBalloonGridSize(incoming.shape);
                    final w = sz.width.toInt();
                    final h = sz.height.toInt();

                    // Подсвечиваем все клетки, которые будут заняты шаром
                    isValidPlacement = _canPlaceBalloon(incoming, x, y, w, h);
                    // Если клетка занята или выходит за пределы, подсвечиваем её красным
                    highlightColor = isValidPlacement
                        ? Colors.green.withOpacity(0.3)
                        : Colors.red.withOpacity(0.5);
                  }
                }

                return Container(
                  width: cellSize,
                  height: cellSize,
                  decoration: BoxDecoration(
                    color: highlightColor,
                    border:
                        Border.all(color: const Color.fromARGB(108, 0, 0, 0)),
                  ),
                );
              },
              onWillAccept: (incoming) {
                if (incoming == null) return false;

                final sz = getBalloonGridSize(incoming.shape);
                final w = sz.width.toInt();
                final h = sz.height.toInt();
                // Подсвечиваем область, которую будет занимать шар
                return _canPlaceBalloon(incoming, x, y, w, h);
              },
              onAccept: (incoming) {
                final sz = getBalloonGridSize(incoming.shape);
                final w = sz.width.toInt();
                final h = sz.height.toInt();
                final placed = boxGrid.place(incoming.id, x, y, w, h);
                if (placed) {
                  incoming.boxX = x;
                  incoming.boxY = y;
                  conveyorIds.remove(incoming.id);
                  setState(() {});
                }
              },
            ),
          ),
        );
      }
    }
    return widgets;
  }

// Проверка, можно ли установить шар в указанных клетках (с учетом размера)
  bool _canPlaceBalloon(
      Balloon balloon, int startX, int startY, int width, int height) {
    // Проверка всех клеток, которые будет занимать шар
    for (int y = startY; y < startY + height; y++) {
      for (int x = startX; x < startX + width; x++) {
        // Проверка на выход за границы поля и занятость клетки
        if (x >= gridWidth ||
            y >= gridHeight ||
            boxGrid.cellAt(x, y)!.balloonId != null) {
          return false; // Если выходим за пределы поля или клетка уже занята, нельзя установить
        }
      }
    }
    return true;
  }

  Widget _buildBoxBalloonWidget(Balloon balloon) {
    final bx = balloon.boxX ?? 0;
    final by = balloon.boxY ?? 0;
    final sz = getBalloonGridSize(balloon.shape);
    final w = sz.width * cellSize;
    final h = sz.height * cellSize;

    return Positioned(
      left: bx * cellSize,
      top: by * cellSize,
      child: Draggable<Balloon>(
        data: balloon,
        feedback: _buildBalloonImage(balloon, isDragging: true),
        childWhenDragging: Container(
          width: w,
          height: h,
          color: Colors.transparent,
        ),
        onDragStarted: () {
          // Запоминаем клетку, из которой был схвачен шар
          boxGrid.remove(balloon.id);
          setState(() {});
        },
        onDragCompleted: () {
          // Если шар приняли в другом месте, всё ок
        },
        onDraggableCanceled: (velocity, offset) {
          // Если не приняли, возвращаем шар на прежнее место
          boxGrid.place(
              balloon.id, bx, by, sz.width.toInt(), sz.height.toInt());
          setState(() {});
        },
        child: _buildBalloonImage(balloon),
      ),
    );
  }
}

class ConveyorBelt extends StatefulWidget {
  @override
  _ConveyorBeltState createState() => _ConveyorBeltState();
}

class _ConveyorBeltState extends State<ConveyorBelt>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final double textureHeight = 50; // Высота текстуры

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Скорость движения
    )..repeat();

    _animation =
        Tween<double>(begin: 0, end: textureHeight).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: _animation.value - textureHeight,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      IconProvider.roll.buildImageUrl(), // Текстура конвейера
                      repeat: ImageRepeat.repeatY,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: _animation.value,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      IconProvider.roll.buildImageUrl(), // Копия текстуры
                      repeat: ImageRepeat.repeatY,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

void showADialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      int curIndex = 0;
      List<List<HolidayCondition>> holidayCondition = [
        [
          holidayConditions[0],
          holidayConditions[1],
          holidayConditions[2],
        ],
        [
          holidayConditions[3],
          holidayConditions[4],
          holidayConditions[5],
        ],
        [
          holidayConditions[6],
          holidayConditions[7],
          holidayConditions[8],
        ],
        [
          holidayConditions[9],
        ],
      ];

      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Stack(
          alignment: Alignment.center,
          children: [
            AppIcon(
              asset: IconProvider.list.buildImageUrl(),
              width: getWidth(context, baseSize: 887),
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: AnimatedButton(
                child: AppIcon(
                  asset: IconProvider.close.buildImageUrl(),
                  width: getWidth(context, baseSize: 163),
                  fit: BoxFit.fitWidth,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            Column(
                children: List.generate(holidayCondition.length, (index) {
              return Column(
                children:
                    List.generate(holidayCondition[index].length, (index2) {
                  return AppButton(
                    onPressed: () {},
                    title: holidayCondition[index][index2].name,
                  );
                }),
              );
            }))
          ],
        ),
      );
    },
  );
}
