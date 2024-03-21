import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Home/widgets/milestones_widget.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/App%20State/app_state_provider.dart';
import 'package:knowyourself/screens/Home/widgets/mood_widget.dart';
import 'package:knowyourself/screens/Home/widgets/progress_milestones.dart';
import 'package:knowyourself/screens/Home/widgets/recommend_widget.dart';
import 'package:knowyourself/screens/widgets/custom_header.dart';
import 'package:knowyourself/screens/widgets/my_card.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // super.build(context);

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [
              const CustomHeader(title: "Home"),
              const MoodWidget(),
              const SizedBox(height: 20),
              const TodoRadialWidget(),
              const SizedBox(height: 20),
              mySelfSection(screenWidth),
              const SizedBox(height: 20),
              const ProgressComponent(
                milestonesProgress: {
                  'Daily': 0.35,
                  'Monthly': 0.5,
                  'Yearly': 0.7,
                },
              ),
              const SizedBox(height: 20),
              const RecommendWidget(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget mySelfSection(double screenWidth) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Myself", style: Theme.of(context).textTheme.headline6),
              GestureDetector(
                onTap: () => Provider.of<AppStateProvider>(context, listen: false).updatePage(3),
                child: Text("View All", style: TextStyle(color: kPalette4)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            myCard(
              context: context,
              title: "Journal",
              color: kApp1,
              imageUrl: "assets/illustrations/journalm.svg",
              screenWidth: screenWidth,
            ),
            myCard(
              context: context,
              title: "Review",
              color: kApp2,
              imageUrl: "assets/illustrations/review.svg",
              screenWidth: screenWidth,
            ),
          ],
        ),
      ],
    );
  }

  Widget myCard({
    required BuildContext context,
    required String title,
    required Color color,
    required String imageUrl,
    required double screenWidth,
  }) {
    return GestureDetector(
      onTap: () => Provider.of<AppStateProvider>(context, listen: false).updatePage(3),
      child: MyCard(
        width: screenWidth * 0.4,
        height: 60.h,
        left: screenWidth * 0.2,
        title: title,
        color: color,
        imageUrl: imageUrl,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
