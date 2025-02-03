import 'dart:ui';

import 'package:balloon_puzzle_factory/src/core/utils/icon_provider.dart';
import 'package:flutter/material.dart';

class Balloon {
  final String id;
  final Color color;
  final BalloonShape shape;
  final int? hasCollectorItem;

  // Положение на конвейере (bottom:Y). Двигаем вверх.
  double conveyorY;

  // Координаты в коробке (верх.левый угол), если шар в коробке
  int? boxX;
  int? boxY;

  bool get isInBox => boxX != null && boxY != null;

  Balloon({
    required this.id,
    required this.color,
    required this.shape,
    required this.hasCollectorItem,
    required this.conveyorY,
  });
}

enum BalloonShape {
  classic,
  ovalVert,
  ovalHorz,
  mini,
  giant,
  cube,
  donut,
}

/// Путь к изображению (ассету) для конкретной формы шара.
String getBalloonAsset(BalloonShape shape) {
  switch (shape) {
    case BalloonShape.classic:
      return IconProvider.b2.buildImageUrl();
    case BalloonShape.ovalVert:
      return IconProvider.b3.buildImageUrl();
    case BalloonShape.ovalHorz:
      return IconProvider.b7.buildImageUrl();
    case BalloonShape.mini:
      return IconProvider.b1.buildImageUrl();
    case BalloonShape.giant:
      return IconProvider.b4.buildImageUrl();
    case BalloonShape.cube:
      return IconProvider.b5.buildImageUrl();
    case BalloonShape.donut:
      return IconProvider.b6.buildImageUrl();
  }
}

/// Размер шара в клетках (width x height)
Size getBalloonGridSize(BalloonShape shape) {
  switch (shape) {
    case BalloonShape.classic:
      return const Size(1, 2);
    case BalloonShape.ovalVert:
      return const Size(1, 3);
    case BalloonShape.ovalHorz:
      return const Size(3, 1);
    case BalloonShape.mini:
      return const Size(1, 1);
    case BalloonShape.giant:
      return const Size(3, 3);
    case BalloonShape.cube:
      return const Size(2, 2);
    case BalloonShape.donut:
      return const Size(3, 2);
  }
}

const Color gold = Color(0xFFFFD700);
const Color silver = Color(0xFFC0C0C0);

/// Расширенный список “базовых” цветов, из которых мы будем
/// случайным образом генерировать цвета шаров на конвейере.
/// Добавили white, black, gold, silver, lightGreen, lightBlue, brown и т.д.
final List<Color> allColors = [
  Colors.red,
  Colors.yellow,
  Colors.orange,
  Colors.blue,
  Colors.green,
  Colors.purple,
  Color(0xFFF16FC7),
  Colors.cyan,
  Color(0xFFFAEFC8),
  Color(0xFF041A2E),
  gold,
  silver,
  Colors.brown,
  Colors.lightGreen,
  Colors.lightBlue,
];
