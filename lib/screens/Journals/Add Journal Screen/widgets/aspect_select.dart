import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/progress_bar.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/screens/widgets/Placeholder.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/journal/journal_editor_provider.dart';
import 'package:knowyourself/screens/Journals/Add%20Journal%20Screen/widgets/button_container.dart';


class AspectSelectWidget extends StatefulWidget {
  const AspectSelectWidget({super.key});

  @override
  State<AspectSelectWidget> createState() => _AspectSelectWidgetState();
}

class _AspectSelectWidgetState extends State<AspectSelectWidget> {
  int _selectedOptionIndex = 0; // Index of the selected option

  List<String> options = ['Mental', 'Physical', 'Emotional', 'Spiritual'];

  @override
  Widget build(BuildContext context) {
    JournalEditorProvider journalEditorProvider =
    Provider.of<JournalEditorProvider>(context, listen: false);
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.93,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ProgressBar(progress: "2/3") ,
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
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'In which ',
                                        style: customTitleBold(kDarkText, 28.sp, FontWeight.w700)),
                                    TextSpan(
                                      text: 'Aspect?',
                                      style: customTitleBold(kApp1, 28.sp, FontWeight.w700),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
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
                              optionsAspect(context, options),
                            ]
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ButtonContainer(label: "Next", onTap: () {
                  journalEditorProvider.updateIndex(2);
                },),
              ],
            ),
          ),
        ));
  }

  Widget optionsAspect(BuildContext context, List<String> options) {
    return Column(
      children: List.generate(options.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedOptionIndex = index;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 12.0),
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: _selectedOptionIndex == index ? kApp1 : Colors.grey[200],
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: _selectedOptionIndex == index ? kApp1: Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                if (_selectedOptionIndex == index)
                  BoxShadow(
                    color: kApp1.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  options[index],
                  style: TextStyle(
                    color: _selectedOptionIndex == index ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
                if (_selectedOptionIndex == index)
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget card(BuildContext context, String title, Color color, String imageUrl) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.5), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 16,
            top: 16,
            child: Opacity(
              opacity: 0.5,
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
