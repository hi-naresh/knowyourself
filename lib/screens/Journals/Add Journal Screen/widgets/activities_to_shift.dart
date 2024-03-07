import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Home/home_screen.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/button_container.dart';
import 'package:knowyourself/screens/Main%20Screen/main_screen.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/screens/widgets/custom_header.dart';
import 'package:knowyourself/screens/widgets/my_card.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class ActivitiesToShiftScreen extends StatelessWidget {
  ActivitiesToShiftScreen({Key? key}) : super(key: key);

  final List<Activity> activities = [
    Activity(title: 'Go for a walk in nature', duration: '10 min', imageUrl: 'assets/illustrations/physical.svg', color: kApp1),
    Activity(title: 'Do a dance party by yourself', duration: '15 min', imageUrl: 'assets/illustrations/physical.svg', color: kApp2),
    Activity(title: 'Paint something', duration: '15 min', imageUrl: 'assets/illustrations/physical.svg', color: kApp3),
    Activity(title: 'Eat a dessert', duration: '15 min', imageUrl: 'assets/illustrations/physical.svg', color: kApp4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            CustomHeader(title: 'Shift',
              custom: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: kApp1, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 25.r,
                    ),
                  ),
                ),
              ),
            ),
            Text("Activities to shift your mood",
            style: customTitleBold(null, 22.sp, FontWeight.w700),),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                ),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  return ActivityTile(
                    activity: activities[index],
                    onTap: () {
                      // Handle the tap event
                      print('Tapped on ${activities[index].title}');
                    },
                  );
                },
              ),
            ),
            ButtonContainer(label: "Home",
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()  ));
                }
                ),
            SizedBox(height: 10.h,)

          ],
        ),
      ),
    );
  }
}

class Activity {
  final String title;
  final String duration;
  final String imageUrl;
  final Color color ;

  Activity({
    required this.title,
    required this.duration,
    required this.imageUrl,
    required this.color,
  });
}

class ActivityTile extends StatelessWidget {
  final Activity activity;
  final VoidCallback onTap;

  const ActivityTile({
    Key? key,
    required this.activity,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(title: activity.title, color: activity.color, imageUrl: activity.imageUrl, onTap: onTap, width: 150, height: 150,);
  }
}
