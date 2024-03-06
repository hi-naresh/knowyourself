import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/screens/widgets/global_styles.dart';
import 'package:knowyourself/utils/ui_colors.dart';

import 'activities_to_shift.dart';

class MoodShift extends StatelessWidget {
  MoodShift({super.key});

  final List<Map<String, dynamic>> moods = [
    {'mood': 'Cheerful', 'color': kApp1},
    {'mood': 'Calm', 'color': kApp2},
    {'mood': 'Positive', 'color': kApp3},
    {'mood': 'Sleep', 'color': kApp4},
  ];

  final List<Color> colors = [kApp1, kApp2, kApp3, kApp4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('I want to feel...'),
        leading: BackButton(),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: moods.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: Styles.containerDecoration(colors[index]),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MoodTile(
                mood: moods[index]['mood']!,
                color: moods[index]['color']!,
                onTap: () {
                  // Handle the tap event
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActivitiesToShiftScreen(),
                    ),
                  );
                  // print('Tapped on ${moods[index]['mood']}');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
class MoodTile extends StatelessWidget {
  final String mood;
  final Color color;
  final VoidCallback onTap;

  const MoodTile({
    Key? key,
    required this.mood,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(15),
      title: Text(mood, style: customTitleBold(kWhite, 16.sp, FontWeight.w600),),
      // tileColor: color,
      trailing: Icon(Icons.arrow_forward_ios),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      onTap: onTap,
    );
  }
}
