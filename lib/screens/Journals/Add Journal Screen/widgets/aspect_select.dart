import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/widgets/Placeholder.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/journal/journal_editor_provider.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/button_container.dart';
import 'package:knowyourself/utils/linear_percent_indicator.dart';

class AspectSelectWidget extends StatelessWidget {
  const AspectSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    JournalEditorProvider journalEditorProvider =
    Provider.of<JournalEditorProvider>(context, listen: false);
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Consumer<JournalEditorProvider>(
                          builder: (context, value, child) {
                            return LinearPercentIndicator(
                              alignment: MainAxisAlignment.spaceBetween,
                              leading: GestureDetector(
                                onTap: () {
                                  Provider.of<JournalEditorProvider>(context,
                                      listen: false)
                                      .updateIndex(0);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 30.r,
                                ),
                              ),
                              barRadius: const Radius.circular(20),
                              lineHeight: 10.h,
                              width: 200.w,
                              percent: 0.6,
                              backgroundColor: const Color(0xFFD9D9D9),
                              progressColor: const Color(0xFF5349DB),
                              trailing: Text(
                                "2/3",
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Consumer<JournalEditorProvider>(
                          builder: (BuildContext context, value, Widget? child) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "In Which Aspect of Life?",
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children:[
                              CustomPlaceHolder("Mentally", 60, double.infinity),
                              SizedBox(height: 20.h,),
                              CustomPlaceHolder("Physically", 60, double.infinity),
                              SizedBox(height: 20.h,),
                              CustomPlaceHolder("Emotionally", 60, double.infinity),
                              SizedBox(height: 20.h,),
                              CustomPlaceHolder("Spiritually", 60, double.infinity),

                            ]
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    journalEditorProvider.updateIndex(2);
                  },
                  child: const ButtonContainer(label: "Next"),
                ),
              ],
            ),
          ),
        ));
  }
}
