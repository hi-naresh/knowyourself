import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/screens/Home/widgets/mood_widget.dart';
import 'package:knowyourself/screens/Home/widgets/progress_milestones.dart';
import 'package:knowyourself/screens/Home/widgets/recommend_widget.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/App%20State/app_state_provider.dart';
import 'package:knowyourself/provider/Extras/user_data_provider.dart';
import 'package:knowyourself/screens/Home/widgets/to_do_radial_widget.dart';
import 'package:knowyourself/screens/Journals/Account%20Screen/account_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  get onPressed => null;

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12 && hour > 5) {
      return 'Good Morning!';
    } else if (hour < 17 && hour > 12) {
      return 'Good Afternoon!';
    }
    return 'Good Evening!';
  }

  @override
  Widget build(BuildContext context) {
    // var he = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    super.build(context);
    return Scaffold(
      // backgroundColor: kBackground2,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40.h,
              ),
              header(),
              SizedBox(
                height: 15.h,
              ),
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

  Widget header(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
            SizedBox(
              width: 10.w,
            ),
            Consumer<UserDataProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return Text(greeting(),style: customTitle(kDarkText, 16),);
              },
            ),
          ],
        ),

        IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            "assets/icons/bell.svg",
            color: Colors.black,
          ),)
      ],
    );
  }

  Widget checkIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.pink.shade100,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
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
      padding: EdgeInsets.all(18),
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
                      .updatePage(2);
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
            outerContainer( 55.h, 0.4*wi, Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset("assets/icons/journall.svg"),
                Text("Journal", style: h3Bold,),
              ],
            ) ),
            outerContainer( 55.h, 0.4*wi, Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset("assets/icons/assess.svg"),
                Text("Review", style: h3Bold,),
              ],
            ) )
          ],
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
