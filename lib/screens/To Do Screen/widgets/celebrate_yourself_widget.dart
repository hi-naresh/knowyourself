import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/ToDo/celebration_provider.dart';
import 'package:knowyourself/screens/To%20Do%20Screen/celebrate_yourself_screen.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class CelebrateYourselfWidget extends StatelessWidget {
  const CelebrateYourselfWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0.0, 4), //(x,y)
            blurRadius: 38.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: 'Celebrate ',
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w600)),
                TextSpan(
                  text: 'Yourself',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: kTodoPrimaryColor),
                ),
              ],
            ),
          ),
          Text(
            "Give yourself credit for your strengths and accomplishments.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
          ),
          Consumer<CelebrationProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return GestureDetector(
                onTap: () {
                  if (value.celebrationString == "") {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const CelebrateYourSelfScreen();
                    }));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).chipTheme.secondarySelectedColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (value.celebrationString != "")
                        Flexible(
                          child: Text(
                            value.celebrationString,
                            maxLines: 3,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w400),
                          ),
                        ),
                      if (value.celebrationString == "")
                        Text(
                          "I did a random act of __________.",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),
                      if (value.celebrationString == "")
                        const Icon(
                          Icons.arrow_forward,
                          color: kTodoPrimaryColor,
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
