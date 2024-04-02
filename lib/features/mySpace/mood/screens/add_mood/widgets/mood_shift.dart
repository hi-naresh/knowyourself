import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../../../common/styles/styles.dart';
import '../../../../../../routes.dart';
import '../../../../../../utils/constants/colors.dart';

class MoodShiftPage extends StatelessWidget {
  MoodShiftPage({super.key});

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
      appBar:const KAppBar(back: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: KStyles.containerDecoration(colors[index]),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: MoodTile(
                        mood: moods[index]['mood']!,
                        color: moods[index]['color']!,
                        onTap: ()=>Get.toNamed(KRoutes.getActivitiesRoute()),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: (){},
              child: const Text('Not Found'),
            )
          ],
        ),
      ),
    );
  }
}
class MoodTile extends StatelessWidget {
  final String mood;
  final Color color;
  final VoidCallback onTap;

  const MoodTile({
    super.key,
    required this.mood,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(15),
      title: Text(mood, style: Theme.of(context).textTheme.headlineSmall,),
      // tileColor: color,
      trailing: const Icon(Icons.arrow_forward_ios),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      onTap: onTap,
    );
  }
}
