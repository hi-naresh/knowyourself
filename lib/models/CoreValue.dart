import 'dart:ui';

class CoreValue {
  String name;
  double percentage;
  Color color;

  CoreValue({
    required this.name,
    required this.percentage,
    required this.color,
  });
}

List<CoreValue> coreValues = [
  CoreValue(
    name: 'Progress',
    percentage: 100,
    color: const Color(0xFFEF7C00),
  ),
  CoreValue(
    name: 'Receptivity',
    percentage: 90,
    color: const Color(0xFFEFB500),
  ),
  CoreValue(
    name: 'Aspiration',
    percentage: 65,
    color: const Color(0xFFF8D600),
  ),
  CoreValue(
    name: 'Perseverance',
    percentage: 40,
    color: const Color(0xFFB9D900),
  ),
  CoreValue(
    name: 'Gratitude',
    percentage: 60,
    color: const Color(0xFF00AE1B),
  ),
  CoreValue(
    name: 'Humility',
    percentage: 55,
    color: const Color(0xFF007530),
  ),
  CoreValue(
    name: 'Sincerity',
    percentage: 60,
    color: const Color(0xFF005CA5),
  ),
  CoreValue(
    name: 'Peace',
    percentage: 70,
    color: const Color(0xFF1C3385),
  ),
  CoreValue(
    name: 'Equanimity',
    percentage: 40,
    color: const Color(0xFF692A81),
  ),
  CoreValue(
    name: 'Generosity',
    percentage: 30,
    color: const Color(0xFFBC037B),
  ),
  CoreValue(
    name: 'Goodness',
    percentage: 80,
    color: const Color(0xFFF0025E),
  ),
  CoreValue(
    name: 'Courage',
    percentage: 100,
    color: const Color(0xFFEC0012),
  ),
];