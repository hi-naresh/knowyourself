import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/models/Quote/quote_model.dart';
import 'package:knowyourself/screens/Home/home_screen.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/add_journal_screen.dart';
import 'package:knowyourself/screens/Journals/Journals%20Screen/journals_screen.dart';
import 'package:knowyourself/provider/App%20State/app_state_provider.dart';

import 'package:knowyourself/screens/Rss%20Screen/article_screen.dart';
import 'package:knowyourself/screens/To%20Do%20Screen/to_do_screen.dart';
import 'package:knowyourself/utils/affirmations.dart';
import 'package:knowyourself/utils/pref.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:knowyourself/screens/Main%20Screen/widgets/Bottom%20Nav%20Bar/bottom_nar_bar.dart';
import 'package:knowyourself/screens/Main%20Screen/widgets/Bottom%20Nav%20Bar/bottom_nav_bar_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const ArticleScreen(),
    const JournalsScreen(),
    const ToDoScreen(),

    // const AccountScreen(),
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
      width: 70.h,
      height: 70.h,
      child: RawMaterialButton(
        fillColor: getFABColor(context),
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
          size: 50.sp,
          color: kCalendarPrimaryColor,
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
              value.pageState == 2 ? _buildFAB(context) : null,
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
                iconData: Icons.home,
                iconSize: 30.r,
                selectedIconColor: kHomePrimaryColor,
                title: 'Home',
              ),
              BottomNavBarWidget(
                iconData: Icons.article,
                iconSize: 30.r,
                selectedIconColor: kHomePrimaryColor,
                title: 'Articles',
              ),
              BottomNavBarWidget(
                iconData: Icons.library_books,
                iconSize: 30.r,
                selectedIconColor: kJournalPrimaryColor,
                title: 'Journal',
              ),
              BottomNavBarWidget(
                iconData: Icons.list_alt,
                iconSize: 30.r,
                selectedIconColor: kTodoPrimaryColor,
                title: 'Tasks',
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
