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
    allowedColors: [Colors.red, Colors.yellow, Colors.orange, Color(0xFFF16FC7)],
    description: "Bright, cheerful colors for a birthday party.",
  ),
  HolidayCondition(
    name: "Wedding",
    allowedColors: [Color(0xFFFAEFC8), Color(0xFFF16FC7), Colors.purple, gold],
    description: "Light, festive colors (white, pink, purple, gold).",
  ),
  HolidayCondition(
    name: "Halloween",
    allowedColors: [Colors.orange, Color(0xFF041A2E), Colors.purple],
    description: "Traditional Halloween colors: orange, black, purple.",
  ),
  HolidayCondition(
    name: "Christmas",
    allowedColors: [Colors.red, Colors.green, Color(0xFFFAEFC8), gold],
    description: "Classic Christmas colors (red, green, white, gold).",
  ),
  HolidayCondition(
    name: "New Year",
    allowedColors: [Color(0xFFFAEFC8), Colors.blue, silver, gold],
    description: "Cold shades + silver and gold.",
  ),
  HolidayCondition(
    name: "Valentine's Day",
    allowedColors: [Colors.red, Color(0xFFF16FC7), Color(0xFFFAEFC8)],
    description: "Romantic red and pink tones to symbolize love.",
  ),
  HolidayCondition(
    name: "Easter",
    allowedColors: [
      Colors.yellow,
      Color(0xFFF16FC7),
      Colors.lightGreen,
      Colors.purple
    ],
    description: "Delicate pastel shades associated with spring and Easter.",
  ),
  HolidayCondition(
    name: "Oktoberfest",
    allowedColors: [Colors.blue, Color(0xFFFAEFC8), Colors.brown],
    description: "Traditional beer holiday colors: blue, white, brown.",
  ),
  HolidayCondition(
    name: "St. Patrick's Day",
    allowedColors: [Colors.green, Colors.orange, Color(0xFFFAEFC8)],
    description: "The primary color is green, plus orange and white.",
  ),
  HolidayCondition(
    name: "Baby Shower",
    allowedColors: [Color(0xFFF16FC7), Colors.lightBlue, Color(0xFFFAEFC8)],
    description: "Gentle “baby” shades for a pre-baby shower.",
  ),
];
