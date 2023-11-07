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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(height: 50.h),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).chipTheme.selectedColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
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
                                  text: 'Your Entries \nin ',
                                  style: TextStyle(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w700,
                                      height: 1.1),
                                ),
                                TextSpan(
                                  text: DateFormat.MMMM().format(value.getDate),
                                  // recognizer: TapGestureRecognizer()..onTap = () {},
                                  style: TextStyle(
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w700,
                                      color: kJournalPrimaryColor),
                                ),
                                WidgetSpan(
                                  child: Icon(Icons.arrow_drop_down,
                                      size: 20.r, color: kJournalPrimaryColor),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Consumer<UserDataProvider>(
                        builder: (BuildContext context, value, Widget? child) {
                          return CircleAvatar(
                            radius: 25.r,
                            backgroundColor: const Color(0xFFD9D9D9),
                            backgroundImage: AssetImage(
                              "assets/avatars/${value.avatar}.png",
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
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
                                return SvgDataWidget(
                                    svgPicture: SvgPicture.asset(
                                      "assets/icons/entries.svg",
                                      height: 20.h,
                                    ),
                                    value: entries,
                                    title: "Entries");
                              }
                              return SvgDataWidget(
                                  svgPicture: SvgPicture.asset(
                                    "assets/icons/entries.svg",
                                    height: 20.h,
                                  ),
                                  value: 0,
                                  title: "Entries");
                            },
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const CalendarWidget(),
            ),
          ),
          Consumer<JournalProvider>(
            builder: (BuildContext context, value, Widget? child) {
              List journals = value.journals;
              if (journals.isEmpty) {
                return SliverToBoxAdapter(
                    child: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: SvgPicture.asset(
                    "assets/illustrations/no_journals.svg",
                    height: 200.h,
                  ),
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
