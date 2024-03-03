import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knowyourself/screens/Journals/Journals%20Screen/journals_screen.dart';
import 'package:knowyourself/screens/Space/widgets/celebrate_yourself_widget.dart';
import 'package:knowyourself/screens/Space/widgets/question_space.dart';
import 'package:knowyourself/screens/Space/widgets/to_do_widget.dart';
import 'package:knowyourself/screens/widgets/Placeholder.dart';
import 'package:provider/provider.dart';

import '../../hive boxes/journal_box.dart';
import '../../models/Questions.dart';
import '../../provider/Extras/user_data_provider.dart';
import '../../provider/MySpace/question_provider.dart';
import '../../provider/journal/journal_provider.dart';
import '../../utils/ui_colors.dart';
import '../Journals/Account Screen/account_screen.dart';
import '../Journals/Journals Screen/widgets/calendar_widget.dart';
import '../Journals/Journals Screen/widgets/data_widget.dart';
import '../Journals/Journals Screen/widgets/journal_widget.dart';

class MySpaceScreen extends StatefulWidget {
  @override
  _MySpaceScreenState createState() => _MySpaceScreenState();
}

class _MySpaceScreenState extends State<MySpaceScreen> {
  get onPressed => null;


  // void _resetSavedData() {
  //   if (SharedPreferencesHelper.getDate() !=
  //       DateFormat('dd-MM-yyyy').format(DateTime.now())) {
  //     SharedPreferencesHelper.deleteStatus();
  //     SharedPreferencesHelper.saveDate(DateTime.now());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    // _resetSavedData();
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: Column(
                children: [
                  // Stack(
                  //   children: [
                  //     Center(
                  //       child: Text(
                  //         "Space",
                  //         style: TextStyle(
                  //           fontSize: 90.sp,
                  //           fontWeight: FontWeight.w900,
                  //           letterSpacing: 5.5,
                  //           color: kPalette5.withOpacity(0.2),
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  //       child: header(),
                  //     ),
                  //   ],
                  // ),

                  SizedBox(
                    height: 240.h,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            decoration: BoxDecoration(
                              color: kPalette6,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Consumer<JournalProvider>(
                                        builder: (BuildContext context, value, Widget? child) {
                                          return Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'My Journal',
                                                  style: TextStyle(
                                                      fontSize: 30.sp,
                                                      color: kPalette5,
                                                      fontWeight: FontWeight.w900,
                                                      height: 1.1),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      Consumer<JournalProvider>(
                                        builder: (BuildContext context, value, Widget? child) {
                                          return FutureBuilder(
                                            future: JournalHiveBox.getMonthNumofEntries(
                                              dateTime: value.getDate,
                                            ),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<dynamic> snapshot) {
                                              if (snapshot.hasData) {
                                                int entries = snapshot.data as int;
                                                return Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/icons/entries.svg",
                                                      height: 20.h,
                                                      color: kPalette5,
                                                    ),
                                                    SizedBox(width: 5.w,),
                                                    Text (entries.toString(),
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: kPalette5,
                                                        fontWeight: FontWeight.w900,
                                                      ),),
                                                    SizedBox(width: 5.w,),
                                                    Text("Entries",
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        color: kPalette5,
                                                        fontWeight: FontWeight.w900,
                                                      ),),

                                                  ],
                                                );
                                              }
                                              return SvgDataWidget(
                                                svgPicture: SvgPicture.asset(
                                                  "assets/icons/entries.svg",
                                                  height: 20.h,
                                                ),
                                                value: 0,
                                                title: "Entries",
                                              );
                                            },
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  CalendarWidget(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Consumer<JournalProvider>(
                          builder: (BuildContext context, value, Widget? child) {
                            List journals = value.journals;
                            if (journals.isEmpty) {
                              return SliverToBoxAdapter(
                                  child: Padding(
                                      padding: EdgeInsets.all(10.r),
                                      child: Center(
                                        child: Text(
                                          "No Journals Entries!",
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            color: kPalette5,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      )
                                  ));
                            }
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: journals.length,
                                    (context, index) {
                                  return JournalWidget(journalModel: journals[index]);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const ToDoContainerWidget(),
                  SizedBox(
                    height: 10.h,
                  ),
                  const CelebrateYourselfWidget(),
                  SizedBox(
                    height: 340,
                    child:QuestionSpace(),
                  ),

                  SizedBox(height: 20.h),
                  CustomPlaceHolder("My MileStones", 130, double.infinity),
                  SizedBox(height: 20.h),
                  // JournalsScreen(),
                  CustomPlaceHolder("Gratitude", 130, double.infinity),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
          header()
        ],
      ),
    );
  }

  Widget header(){
    return Padding(
      padding: const EdgeInsets.only(top:58.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            children: [
              SizedBox(height: 50.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) {
                        return const AccountScreen();
                      }));
                    },
                    child: Consumer<UserDataProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                        return CircleAvatar(
                          radius: 18.r,
                          backgroundColor: const Color(0xFFD9D9D9),
                          backgroundImage: AssetImage(
                            "assets/avatars/${value.avatar}.png",
                          ),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: onPressed,
                    icon: SvgPicture.asset(
                      "assets/icons/bell.svg",
                      color: Colors.black,
                    ),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

