import 'package:flutter/material.dart';
import 'package:knowyourself/screens/widgets/CustomContaincer.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:provider/provider.dart';

import '../../../provider/Extras/user_data_provider.dart';
import '../../Journals/Add Journal Screen/add_journal_screen.dart';

// import '../../MoodScreens/MoodScreen.dart';

class MoodWidget extends StatelessWidget {
  const MoodWidget({super.key});

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12 && hour > 5) {
      return 'Good Morning, ';
    } else if (hour < 17 && hour > 12) {
      return 'Good Afternoon, ';
    }
    return 'Good Evening, ';
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      color: kNewP1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //consumer to provide the user's name
          const SizedBox(height: 10),
          Consumer<UserDataProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return Text(
                greeting()+value.userName,
                style: customTitleBold(kDarkText, 20, FontWeight.w800),
                textAlign: TextAlign.left,
              );
            },
          ),

          Text(
            "How do you feel?",
            style: customTitleBold(kDarkText, 21, FontWeight.w800),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: const Color(0x4DF5F5F5),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Express Your Mood & Reflect:\nLog emotions and thoughts.",
                  style: customTitleBold(kDarkText, 12, FontWeight.w400),
                  textAlign: TextAlign.left,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff393939), // Change the color as needed
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddJournalPageWidget(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
