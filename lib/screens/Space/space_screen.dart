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
import 'package:knowyourself/screens/widgets/custom_header.dart';
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
import '../widgets/CustomTitles.dart';

class MySpaceScreen extends StatefulWidget {
  @override
  _MySpaceScreenState createState() => _MySpaceScreenState();
}

class _MySpaceScreenState extends State<MySpaceScreen> with SingleTickerProviderStateMixin {
  get onPressed => null;
  late TabController _tabController;

  final _selectedColor = kApp4;
  // final _unselectedColor = Color(0xff5f6368);
  final _tabs = const [
    Tab(text: 'Journal'),
    Tab(text: 'Milestones'),
    Tab(text: 'Questions'),
    Tab(text: 'Story'),
    Tab(text: 'Celebration'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // Adjust the length for the number of tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const CustomHeader(title: "Space"),
              Container(
                clipBehavior: Clip.none,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                child: TabBar(
                  controller: _tabController,
                  dividerHeight: 0,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: _selectedColor
                  ),
                  labelColor: Colors.white,
                  isScrollable: true,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3),
                  tabAlignment: TabAlignment.center,
                  labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  // labelStyle: h3,
                  // tabAlignment: TabAlignment.center,
                  indicatorPadding: EdgeInsets.symmetric(horizontal: -20),
                  unselectedLabelColor: Colors.black,
                  tabs: _tabs,
                ),
              ),
              SizedBox(height: 10.h),
              Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children:  [
                      _journalTab(),
                      _milestonesTab(),
                      _questionsTab(),
                      Center(child: Text("Story Page"),),
                      _celebrationTab()
                    ],
                  )
              )
            ],
          ),
        )
    );
  }

  Widget _journalTab() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: kPalette6,
              borderRadius: BorderRadius.all(Radius.circular(20)),
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
                          return Text(
                            "My Journal",
                            style:customTitleBold(
                              kPalette5,
                              24,
                              FontWeight.w700,
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
    );
  }

  Widget _milestonesTab(){
    return SizedBox(
      child: Column(
        children: [
          ToDoContainerWidget()
        ],
      ),
    );
  }

  Widget _questionsTab(){
    return const Column(
      children: [
        QuestionSpace()
      ],
    );
  }

  Widget _celebrationTab(){
    return SizedBox(
      child: Column(
        children: [
          CelebrateYourselfWidget()
        ],
      ),
    );
  }
}

