import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/learning/screens/core_values/widgets/value_painter.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/pagebar.dart';


class CoreValue {
  final String name;
  final Color color;
  final String definition;
  final String example;

  CoreValue({
    required this.name,
    required this.color,
    required this.definition,
    required this.example,
  });
}

final List<CoreValue> coreValues = [
  CoreValue(
    name: 'Sincerity',
    color: valueSincerity,
    definition: 'The quality of being free from pretense, deceit, or hypocrisy.',
    example: 'Always tell the truth, even when it is difficult.',
  ),
  CoreValue(
    name: 'Peace',
    color: valuePeace,
    definition: 'Freedom from disturbance; tranquility.',
    example: 'Meditation helps in achieving inner peace.',
  ),
  CoreValue(
    name: 'Equality',
    color: Colors.purple,
    definition: 'The state of being equal, especially in status, rights, or opportunities.',
    example: 'Treat everyone with equal respect.',
  ),
  CoreValue(
    name: 'Generosity',
    color: Colors.deepPurple,
    definition: 'The quality of being kind and generous.',
    example: 'Donate to those in need.',
  ),
  CoreValue(
    name: 'Goodness',
    color: Colors.pink,
    definition: 'The quality of being morally good or virtuous.',
    example: 'Do good deeds without expecting anything in return.',
  ),
  CoreValue(
    name: 'Courage',
    color: Colors.red,
    definition: 'The ability to do something that frightens one.',
    example: 'Stand up for what is right, even if you are afraid.',
  ),
  CoreValue(
    name: 'Progress',
    color: Colors.orange,
    definition: 'Forward or onward movement towards a destination.',
    example: 'Continuously improve yourself.',
  ),
  CoreValue(
    name: 'Receptivity',
    color: Colors.yellow,
    definition: 'Willingness or readiness to receive (especially impressions or ideas).',
    example: 'Be open to new ideas and experiences.',
  ),
  CoreValue(
    name: 'Aspiration',
    color: Colors.lightGreen,
    definition: 'A hope or ambition of achieving something.',
    example: 'Work hard to achieve your dreams.',
  ),
  CoreValue(
    name: 'Perseverance',
    color: Colors.green,
    definition: 'Persistence in doing something despite difficulty or delay in achieving success.',
    example: 'Never give up on your goals.',
  ),
  CoreValue(
    name: 'Gratitude',
    color: Colors.teal,
    definition: 'The quality of being thankful; readiness to show appreciation for and to return kindness.',
    example: 'Express gratitude for the good things in life.',
  ),
  CoreValue(
    name: 'Humility',
    color: Colors.lime,
    definition: 'A modest or low view of one\'s own importance; humbleness.',
    example: 'Acknowledge your limitations and seek to learn from others.',
  ),
];

class ValuesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: KPageBar(
        title: "Core Values",
        onTap: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  KSizes.defaultSpace),
        child: ListView(
            children: [
            Text(
                  "12 Core values that we will learn, practice and reflect upon in this journey. Below is a representation of the symbol.",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: KSizes.defaultSpace),
                CustomPaint(
                  size: Size.fromRadius(172),
                  painter: RPSCustomValuePainter(),
                ),
                const SizedBox(height: KSizes.defaultSpace),
                Text(
                  "Click on each value to learn more about it.",
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              SizedBox(
                height: 350,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(KSizes.defaultSpace),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  itemCount: coreValues.length,
                  itemBuilder: (context, index) {
                    final coreValue = coreValues[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(coreValue.name),
                            content: Text(
                              '${coreValue.definition}\n\nExample: ${coreValue.example}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: coreValue.color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            coreValue.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
        ),
      ),
    );
  }
}
