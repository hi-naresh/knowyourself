import 'package:flutter/material.dart';

import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../model/activity_model.dart';
import 'activity_tile.dart';

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
      appBar: const KAppBar(back: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            Text("Activities to shift your mood",
            style: Theme.of(context).textTheme.headlineMedium,
            ),
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
            ElevatedButton(
                onPressed: (){},
                child: const Text('Home')
            ),
          ],
        ),
      ),
    );
  }
}
