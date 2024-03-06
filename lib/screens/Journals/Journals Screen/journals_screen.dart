import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/hive%20boxes/journal_box.dart';
import 'package:knowyourself/provider/Extras/user_data_provider.dart';
import 'package:knowyourself/provider/journal/journal_provider.dart';
import 'package:knowyourself/screens/Journals/Journals%20Screen/widgets/data_widget.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:knowyourself/screens/Journals/Journals%20Screen/widgets/calendar_widget.dart';
import 'package:knowyourself/screens/Journals/Journals%20Screen/widgets/journal_widget.dart';

class JournalsScreen extends StatefulWidget {
  const JournalsScreen({super.key});

  @override
  State<JournalsScreen> createState() => _JournalsScreenState();
}

class _JournalsScreenState extends State<JournalsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      // backgroundColor: kBackground1,
      body: CustomScrollView(
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
                    SizedBox(height: 70.h),
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
                    heightFactor: 10.h,
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
          SliverToBoxAdapter(
            child: SizedBox(height: 80.h),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
