import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:webfeed_revised/webfeed_revised.dart';

class ReadArticleScreen extends StatelessWidget {
  final RssItem rssItem;
  const ReadArticleScreen({super.key, required this.rssItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: kPrimaryColor, shape: BoxShape.circle),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 40.r,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                rssItem.title.toString(),
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
              ),
              HtmlWidget(
                rssItem.content!.value.toString(),
                enableCaching: true,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
