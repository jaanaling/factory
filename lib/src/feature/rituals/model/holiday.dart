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
    description: "Bright, cheerful colors for a birthday party.",
  ),
  HolidayCondition(
    name: "Wedding",
    allowedColors: [Colors.white, Colors.pink, Colors.purple, gold],
    description: "Light, festive colors (white, pink, purple, gold).",
  ),
  HolidayCondition(
    name: "Halloween",
    allowedColors: [Colors.orange, Color(0xFF00101E), Colors.purple],
    description: "Traditional Halloween colors: orange, black, purple.",
  ),
  HolidayCondition(
    name: "Christmas",
    allowedColors: [Colors.red, Colors.green, Colors.white, gold],
    description: "Classic Christmas colors (red, green, white, gold).",
  ),
  HolidayCondition(
    name: "New Year",
    allowedColors: [Colors.white, Colors.blue, silver, gold],
    description: "Cold shades + silver and gold.",
  ),
  HolidayCondition(
    name: "Valentine's Day",
    allowedColors: [Colors.red, Colors.pink, Colors.white],
    description: "Romantic red and pink tones to symbolize love.",
  ),
  HolidayCondition(
    name: "Easter",
    allowedColors: [
      Colors.yellow,
      Colors.pink,
      Colors.lightGreen,
      Colors.purple
    ],
    description: "Delicate pastel shades associated with spring and Easter.",
  ),
  HolidayCondition(
    name: "Oktoberfest",
    allowedColors: [Colors.blue, Colors.white, Colors.brown],
    description: "Traditional beer holiday colors: blue, white, brown.",
  ),
  HolidayCondition(
    name: "St. Patrick's Day",
    allowedColors: [Colors.green, Colors.orange, Colors.white],
    description: "The primary color is green, plus orange and white.",
  ),
  HolidayCondition(
    name: "Baby Shower",
    allowedColors: [Colors.pink, Colors.lightBlue, Colors.white],
    description: "Gentle “baby” shades for a pre-baby shower.",
  ),
];
