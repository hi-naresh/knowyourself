import 'package:flutter/material.dart';

class ActivitiesToShiftScreen extends StatelessWidget {
  ActivitiesToShiftScreen({Key? key}) : super(key: key);

  final List<Activity> activities = [
    Activity(title: 'Go for a walk in nature', duration: '10 min', imageUrl: 'assets/walk.png'),
    Activity(title: 'Do a dance party by yourself', duration: '15 min', imageUrl: 'assets/dance.png'),
    Activity(title: 'Paint something', duration: '15 min', imageUrl: 'assets/paint.png'),
    Activity(title: 'Eat a dessert', duration: '15 min', imageUrl: 'assets/dessert.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities to shift'),
        backgroundColor: Colors.yellow, // Set the AppBar color to match the screen's theme
        leading: BackButton(),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return ActivityTile(
            activity: activities[index],
            onTap: () {
              // Handle the tap event for each activity
              print('Tapped on ${activities[index].title}');
            },
          );
        },
      ),
    );
  }
}

class Activity {
  final String title;
  final String duration;
  final String imageUrl;

  Activity({required this.title, required this.duration, required this.imageUrl});
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                child: Image.asset(
                  activity.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                activity.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(activity.duration),
            ),
          ],
        ),
      ),
    );
  }
}
