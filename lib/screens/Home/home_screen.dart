import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/screens/Home/widgets/mood_widget.dart';
import 'package:knowyourself/screens/Home/widgets/progress_milestones.dart';
import 'package:knowyourself/screens/Home/widgets/recommend_widget.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/screens/widgets/custom_header.dart';
import 'package:knowyourself/screens/widgets/my_card.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/App%20State/app_state_provider.dart';
import 'package:knowyourself/screens/Home/widgets/milestones_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    // var he = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    super.build(context);
    return Scaffold(
      // backgroundColor: kBackground2,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: 40.h,
              // ),
              // header(),
              const CustomHeader(title: "Home"),
              // SizedBox(
              //   height: 15.h,
              // ),
              const MoodWidget(),
              SizedBox(
                height: 20.h,
              ),
              const TodoRadialWidget(),
              SizedBox(
                height: 20.h,
              ),
              mySelf(wi),
              SizedBox(
                height: 20.h,
              ),
              ProgressComponent(),
              SizedBox(
                height: 20.h,
              ),
              const RecommendWidget(),
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
      ),
    );
  }

  Widget checkIn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.orange), // Replace with your custom icon
          SizedBox(width: 8.0),
          Text(
            'Check-in',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Text(
            '3/7',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(width: 8.0),
          Icon(Icons.local_fire_department, color: Colors.red), // Replace with your custom icon
        ],
      ),
    );
  }

  Widget outerContainer( height, width, child){
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: kBoxLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Widget mySelf(wi){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Myself",
                style: h2,
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<AppStateProvider>(context, listen: false)
                      .updatePage(3);
                },
                child: Text(
                  "View All",
                  style: h4(kPalette4),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyCard(
                onTap: (){
                  Provider.of<AppStateProvider>(context, listen: false)
                      .updatePage(3);
                },
                left: wi*0.4 - 0.4*wi/2,
                width: 0.4*wi,
                height: 60.h,
                title: "Journal",
                color: kApp1,
                imageUrl: "assets/illustrations/journalm.svg"),
            MyCard(
                left: wi*0.4 - 0.4*wi/2,
                width: 0.4*wi,
                height: 60.h,
                title: "Review",
                color: kApp2,
                imageUrl: "assets/illustrations/review.svg"),
          ],
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
