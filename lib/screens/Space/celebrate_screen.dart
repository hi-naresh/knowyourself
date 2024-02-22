import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/screens/Space/widgets/celebration_title_widget.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/models/To%20Do/celebration_model.dart';
import 'package:knowyourself/models/To%20Do/status_model.dart';
import 'package:knowyourself/provider/ToDo/celebration_provider.dart';
import 'package:knowyourself/provider/ToDo/status_provider.dart';

import '../../utils/ui_colors.dart';

class CelebrateYourSelfScreen extends StatelessWidget {
  const CelebrateYourSelfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 40.r,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Celebrate ',
                          style: TextStyle(
                              fontSize: 30.sp, fontWeight: FontWeight.w600)),
                      TextSpan(
                        text: 'Yourself',
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            color: kTodoPrimaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                child: Text(
                  DateFormat.yMMMMEEEEd().format(
                    DateTime.now(),
                  ),
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFB2B2B7)),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Consumer<CelebrationProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: value.celebrationModel.title,
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.w500),
                          ),
                          WidgetSpan(
                            child: SizedBox(
                              height: 70.h,
                              child: TextField(
                                maxLines: 1,
                                maxLength: 50,
                                controller:
                                value.celebrationTextEditingController,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  fillColor: Theme.of(context)
                                      .chipTheme
                                      .backgroundColor,
                                  filled: true,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: kTodoPrimaryColor),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: kTodoPrimaryColor),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              Container(
                width: double.infinity,
                margin:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "More Reasons To ",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: "Celebrate",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: kTodoPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CelebrateTitleWidget(
                      celebrationModel: CelebrationModel(
                        title: "I quit a bad habit of ",
                      ),
                    ),
                    CelebrateTitleWidget(
                      celebrationModel:
                      CelebrationModel(title: "I am thankful for "),
                    ),
                    CelebrateTitleWidget(
                      celebrationModel: CelebrationModel(
                        title: "I have continued to ",
                      ),
                    ),
                    CelebrateTitleWidget(
                      celebrationModel: CelebrationModel(
                        title: "I did an act of kindness by ",
                      ),
                    ),
                    CelebrateTitleWidget(
                      celebrationModel: CelebrationModel(
                        title: "I started a habit of ",
                      ),
                    ),
                    CelebrateTitleWidget(
                      celebrationModel: CelebrationModel(
                        title: "I did a random act of ",
                      ),
                    ),
                    CelebrateTitleWidget(
                      celebrationModel: CelebrationModel(
                        title: "I am grateful for ",
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Consumer<CelebrationProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        if (value.celebrationTextEditingController.text != "") {
                          value.saveCelebrationString();
                          int imageIndex = Random().nextInt(9);
                          StatusModel statusModel = StatusModel(
                              title: value.celebrationString,
                              image: "bg$imageIndex.jpg",
                              dateTime: DateTime.now(),
                              hasSeen: false,
                              statustype: Statustype.celebrate);
                          Provider.of<StatusProvider>(context, listen: false)
                              .addStatus(statusModel: statusModel);
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFDABF),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Text(
                            "Celebrate",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: kTodoPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}