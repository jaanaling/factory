import 'package:balloon_puzzle_factory/src/feature/rituals/model/balloon.dart';
import 'package:flutter/material.dart';

class HolidayCondition {
  final String name;
  final List<Color> allowedColors;
  final String description;

  const HolidayCondition({
    required this.name,
    required this.allowedColors,
    required this.description,
  });
}

/// 10 примеров “праздников” с разрешёнными цветами.
final List<HolidayCondition> holidayConditions = [
  HolidayCondition(
    name: "Birthday",
    allowedColors: [Colors.red, Colors.yellow, Colors.orange, Colors.pink],
    description: "Яркие, весёлые тона для дня рождения.",
  ),
  HolidayCondition(
    name: "Wedding",
    allowedColors: [Colors.white, Colors.pink, Colors.purple, gold],
    description:
        "Светлые, праздничные цвета (белый, розовый, фиолетовый, золотой).",
  ),
  HolidayCondition(
    name: "Halloween",
    allowedColors: [Colors.orange, Colors.black, Colors.purple],
    description: "Традиционные цвета Хэллоуина: оранжевый, чёрный, фиолетовый.",
  ),
  HolidayCondition(
    name: "Christmas",
    allowedColors: [Colors.red, Colors.green, Colors.white, gold],
    description:
        "Классические рождественские цвета (красный, зелёный, белый, золотой).",
  ),
  HolidayCondition(
    name: "New Year",
    allowedColors: [Colors.white, Colors.blue, silver, gold],
    description: "Холодные оттенки + серебристый и золотой.",
  ),
  HolidayCondition(
    name: "Valentine's Day",
    allowedColors: [Colors.red, Colors.pink, Colors.white],
    description: "Романтичные красно-розовые тона, символизирующие любовь.",
  ),
  HolidayCondition(
    name: "Easter",
    allowedColors: [
      Colors.yellow,
      Colors.pink,
      Colors.lightGreen,
      Colors.purple
    ],
    description:
        "Нежные пастельные оттенки, ассоциирующиеся с весной и Пасхой.",
  ),
  HolidayCondition(
    name: "Oktoberfest",
    allowedColors: [Colors.blue, Colors.white, Colors.brown],
    description: "Традиционные цвета праздника пива: синий, белый, коричневый.",
  ),
  HolidayCondition(
    name: "St. Patrick's Day",
    allowedColors: [Colors.green, Colors.orange, Colors.white],
    description: "Основной цвет - зелёный, плюс оранжевый и белый.",
  ),
  HolidayCondition(
    name: "Baby Shower",
    allowedColors: [Colors.pink, Colors.lightBlue, Colors.white],
    description:
        "Нежные «детские» оттенки для праздника перед рождением ребёнка.",
  ),
];
