import 'dart:async';
import 'dart:math';

import 'package:balloon_puzzle_factory/src/feature/rituals/model/balloon.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/grid.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/model/holiday.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/utils/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/bloc/user_bloc.dart';
import 'package:go_router/go_router.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int boxWidth = 6;
  final int boxHeight = 6;
  final double cellSize = 60; // пиксельный размер одной ячейки

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

    // Инициализируем сетку коробки
    boxGrid = BoxGrid(width: boxWidth, height: boxHeight);

    // Случайно выбираем праздник
    selectedHoliday =
        holidayConditions[random.nextInt(holidayConditions.length)];

    // Таймер игры
    gameTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;
        if (timeLeft <= 0) {
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
    Timer.periodic(const Duration(seconds: 2), (t) {
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
    final boxPxWidth = boxWidth * cellSize;
    final boxPxHeight = boxHeight * cellSize;

    // Собираем шары, которые сейчас в коробке
    final boxBalloons = allBalloons.values.where((b) => b.isInBox).toList();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.pop(context)),
        centerTitle: true,
        title: Text("Time: $timeLeft"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Score", style: TextStyle(fontSize: 14)),
                Text(score.toString(), style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Левая часть - конвейер
          SizedBox(
            width: 120,
            child: Stack(
              clipBehavior: Clip.none,
              children: conveyorIds.map((id) {
                final b = allBalloons[id]!;
                return Positioned(
                  left: 30, // центр
                  bottom: b.conveyorY,
                  child: _buildConveyorBalloonWidget(b),
                );
              }).toList(),
            ),
          ),

          // Правая часть - коробка + кнопки
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  "Праздник: ${selectedHoliday.name}",
                  style: const TextStyle(fontSize: 20),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    selectedHoliday.description,
                    style: const TextStyle(
                        fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: boxPxWidth,
                    height: boxPxHeight,
                    color: Colors.grey.shade200,
                    child: Stack(
                      children: [
                        // Слой DragTargets (каждая клетка)
                        ..._buildBoxCellTargets(),
                        // Слой шары
                        ...boxBalloons.map((b) => _buildBoxBalloonWidget(b)),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _onSend,
                  child: const Text("Send"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Кнопка "Notes" или что-то ещё
                  },
                  child: const Text("Notes"),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
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
    final hasCollector = random.nextInt(100) < 1; // 15% - коллекционный предмет
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
        b.conveyorY -= 2; // скорость
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
      return Image.asset(
        asset,
        width: 40,
        height: 40,
        fit: BoxFit.contain,
        color: balloon.color.withOpacity(0.85),
      );
    } else {
      final size = getBalloonGridSize(balloon.shape);
      final w = size.width * cellSize;
      final h = size.height * cellSize;
      return Opacity(
        opacity: isDragging ? 0.8 : 1.0,
        child: Image.asset(
          asset,
          width: w,
          height: h,
          fit: BoxFit.contain,
          color: balloon.color.withOpacity(0.85),
        ),
      );
    }
  }

  /// Генерируем набор DragTarget для каждой клетки коробки
  List<Widget> _buildBoxCellTargets() {
    final widgets = <Widget>[];
    for (int y = 0; y < boxHeight; y++) {
      for (int x = 0; x < boxWidth; x++) {
        final cell = boxGrid.cellAt(x, y)!;
        widgets.add(
          Positioned(
            left: x * cellSize,
            top: y * cellSize,
            child: DragTarget<Balloon>(
              builder: (context, candidate, rejected) {
                return Container(
                  width: cellSize,
                  height: cellSize,
                  decoration: BoxDecoration(
                    color: cell.isBooster
                        ? Colors.lightGreenAccent.withOpacity(0.2)
                        : Colors.transparent,
                    border: Border.all(color: Colors.black12),
                  ),
                );
              },
              onWillAccept: (incoming) {
                if (incoming == null) return false;
                // Убираем шар из старых ячеек (если он там был)
                boxGrid.remove(incoming.id);

                final sz = getBalloonGridSize(incoming.shape);
                final w = sz.width.toInt();
                final h = sz.height.toInt();
                final can = boxGrid.canPlace(incoming.id, x, y, w, h);
                return can;
              },
              onAccept: (incoming) {
                final sz = getBalloonGridSize(incoming.shape);
                final w = sz.width.toInt();
                final h = sz.height.toInt();
                final placed = boxGrid.place(incoming.id, x, y, w, h);
                if (placed) {
                  incoming.boxX = x;
                  incoming.boxY = y;
                  // Удаляем шар из конвейера
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

  /// Виджет шара, который уже лежит в коробке
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
          // Убираем шар из клеток, чтобы освободить место
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
