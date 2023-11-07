
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/provider/Extras/user_data_provider.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:story/story.dart';

import '../../../models/To Do/status_model.dart';

class StoryScreen extends StatelessWidget {
  final List<StatusModel> status;
  final UserDataProvider user;
  const StoryScreen({super.key, required this.status, required this.user});

  @override
  Widget build(BuildContext context) {
    /// Minimum example to explain the usage.
    return Scaffold(
      body: StoryPageView(
        indicatorHeight: 3.h,
        indicatorVisitedColor: kTodoPrimaryColor,
        indicatorUnvisitedColor: Colors.white,
        itemBuilder: (context, pageIndex, storyIndex) {
          return Stack(
            children: [
              Positioned.fill(
                  child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "assets/status/${status[storyIndex].image}"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            if (status[storyIndex].statustype ==
                                Statustype.todo)
                              Text(
                                "Task Accomplished",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            if (status[storyIndex].statustype ==
                                Statustype.celebrate)
                              Text(
                                "Celebrating",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Text(
                              '"${status[storyIndex].title}"',
                              style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ]),
              )),
              Padding(
                padding: const EdgeInsets.only(top: 44, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage:
                          AssetImage("assets/avatars/${user.avatar}.png"),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      user.userName,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        storyLength: (pageIndex) {
          return status.length;
        },
        onPageLimitReached: () {
          Navigator.pop(context);
        },
        pageLength: 1,
      ),
    );
  }
}
