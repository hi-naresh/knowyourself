import 'dart:ui';

import '../../../../utils/constants/colors.dart';

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
    color: kCoreValue1_1,
  ),
  CoreValue(
    name: 'Receptivity',
    percentage: 90,
    color: kCoreValue2_1,
  ),
  CoreValue(
    name: 'Aspiration',
    percentage: 65,
    color: kCoreValue3_1,
  ),
  CoreValue(
    name: 'Perseverance',
    percentage: 40,
    color: kCoreValue4_1,
  ),
  CoreValue(
    name: 'Gratitude',
    percentage: 60,
    color: kCoreValue5_1,
  ),
  CoreValue(
    name: 'Humility',
    percentage: 55,
    color: kCoreValue6_1 ,
  ),
  CoreValue(
    name: 'Sincerity',
    percentage: 60,
    color: kCoreValue7_1,
  ),
  CoreValue(
    name: 'Peace',
    percentage: 70,
    color: kCoreValue8_1,
  ),
  CoreValue(
    name: 'Equanimity',
    percentage: 40,
    color: kCoreValue9_1,
  ),
  CoreValue(
    name: 'Generosity',
    percentage: 30,
    color: kCoreValue10_1,
  ),
  CoreValue(
    name: 'Goodness',
    percentage: 80,
    color:kCoreValue11_1,
  ),
  CoreValue(
    name: 'Courage',
    percentage: 100,
    color: kCoreValue12_1,
  ),
];