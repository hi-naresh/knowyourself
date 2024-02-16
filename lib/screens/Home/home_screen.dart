import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Home/widgets/mood_widget.dart';
import 'package:knowyourself/screens/Home/widgets/recommend_widget.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/App%20State/app_state_provider.dart';
import 'package:knowyourself/provider/Extras/user_data_provider.dart';
import 'package:knowyourself/screens/Home/widgets/journal_entry_text_widget.dart';
import 'package:knowyourself/screens/Home/widgets/quote_widget.dart';
import 'package:knowyourself/screens/Home/widgets/to_do_radial_widget.dart';
import 'package:knowyourself/screens/Journals/Account%20Screen/account_screen.dart';

import '../widgets/Placeholder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12 && hour > 5) {
      return 'Good Morning';
    } else if (hour < 17 && hour > 12) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: kBackground1,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Consumer<UserDataProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                        return Text.rich(
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${greeting()},\n',
                                style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2),
                              ),
                              TextSpan(
                                text: value.userName,
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 1.2),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext context) {
                      return const AccountScreen();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Consumer<UserDataProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                        return CircleAvatar(
                          radius: 22.r,
                          backgroundColor: const Color(0xFFD9D9D9),
                          backgroundImage: AssetImage(
                            "assets/avatars/${value.avatar}.png",
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            //check-in & check-out widget, arrow button to show both rows of widgets
            Column(
              children: [
                //label
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Check-in & Check-out",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: kPalette5,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          //hide and show check-in & check-out widgets
                        },
                        child: Text(
                          ">",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: kPalette5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomPlaceHolder("check-in",40, double.infinity),
                SizedBox(
                  height: 10.h,
                ),
                CustomPlaceHolder("check-out",40,double.infinity),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                    height: 210,
                    width: double.infinity,
                    child: MoodWidget())
            ),
            SizedBox(
              height: 10.h,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TodoRadialWidget(),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomPlaceHolder("Chart",200,double.infinity),
            SizedBox(
              height: 20.h,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: RecommendWidget(),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomPlaceHolder("Asses Yourself", 60,double.infinity),
            SizedBox(
              height: 80.h,
            ),
        
            // GestureDetector(
            //   onTap: () {
            //     // Navigator.of(context)
            //     //     .push(MaterialPageRoute(builder: (BuildContext context) {
            //     //   return const ChatbotScreen();
            //     // }));
            //     Provider.of<AppStateProvider>(context, listen: false)
            //         .updatePage(2);
            //   },
            //   child: const JournalEntryTextWidget(),
            // ),
        
            // Consumer<JournalProvider>(
            //   builder: (BuildContext context, value, Widget? child) {
            //     List<JournalModel> journals = value.journals;
            //     if (journals.isEmpty) {
            //       return const Text("data");
            //     } else {
            //       return JournalWidget(journalModel: journals.last);
            //     }
            //   },
            // )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
