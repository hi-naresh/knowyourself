import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/screens/Learn/learn_screen.dart';
import 'package:knowyourself/screens/Space/space_screen.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/models/Quote/quote_model.dart';
import 'package:knowyourself/screens/Home/home_screen.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/add_journal_screen.dart';
import 'package:knowyourself/provider/App%20State/app_state_provider.dart';

import 'package:knowyourself/utils/affirmations.dart';
import 'package:knowyourself/utils/pref.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:knowyourself/screens/Main%20Screen/widgets/Bottom%20Nav%20Bar/bottom_nar_bar.dart';
import 'package:knowyourself/screens/Main%20Screen/widgets/Bottom%20Nav%20Bar/bottom_nav_bar_widget.dart';

import '../Analysis/analysis_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    // const ArticleScreen(),
    const AnalysisScreen(),
    // const JournalsScreen(),
    const LearnScreen(),
    MySpaceScreen(),
    // const ToDoScreen(),
  ];

  void saveQuote() {
    if (SharedPreferencesHelper.getQuote() == null) {
      String quote = affirmations[Random().nextInt(affirmations.length)];
      int imageIndex = Random().nextInt(16);
      QuoteModel quoteModel =
          QuoteModel(title: quote, image: "quote$imageIndex");
      SharedPreferencesHelper.saveQuote(quoteModel: quoteModel);
    }
  }

  @override
  void initState() {
    super.initState();
    saveQuote();
  }

  Widget _buildFAB(BuildContext context) {
    return SizedBox(
      width: 60.h,
      height: 60.h,
      child: RawMaterialButton(
        fillColor: kApp3,
        shape: const CircleBorder(),
        elevation: 0.0,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return const AddJournalPageWidget();
          }));
        },
        child: Icon(
          Icons.add,
          size: 40.sp,
          color: kBackground1,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<AppStateProvider>(context, listen: false)
        .pageController
        .dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton:
              value.pageState == 3 ? _buildFAB(context) : null,
          extendBody: true,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: value.pageController,
            children: _screens,
          ),
          bottomNavigationBar: BottomRoundedNavBar(
            height: 70,
            items: [
              BottomNavBarWidget(
                icon :"assets/icons/home.svg",
                iconSize: 30.r,
                selectedIconColor: kApp1,
                // title: 'Home',
              ),
              BottomNavBarWidget(
                icon : "assets/icons/analysis.svg",
                iconSize: 30.r,
                selectedIconColor: kApp2,
                // title: 'Articles',
              ),
              BottomNavBarWidget(
                icon : "assets/icons/learn.svg",
                iconSize: 30.r,
                selectedIconColor: kApp3,
                // title: 'Journal',
              ),
              BottomNavBarWidget(
                icon : "assets/icons/myspace.svg",
                iconSize: 30.r,
                selectedIconColor: kApp4,
                // title: 'Tasks',
              ),
            ],
            currentIndex: value.pageState,
            onChanged: (int index) {
              value.updatePage(index);
            },
          ),
        );
      },
    );
  }
}
