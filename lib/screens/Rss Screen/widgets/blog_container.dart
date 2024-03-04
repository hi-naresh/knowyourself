import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/screens/Rss%20Screen/read_article_screen.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/utils/ui_colors.dart';

import 'package:webfeed_revised/webfeed_revised.dart';

class BlogContainer extends StatelessWidget {
  final RssItem rssItem;
  const BlogContainer({
    super.key,
    required this.rssItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ReadArticleScreen(
            rssItem: rssItem,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kBoxLight,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  bottomLeft: Radius.circular(10.r),
                  topRight: Radius.circular(50.r),
                  bottomRight: Radius.circular(50.r)
              ),
              child: Image.network(
                rssItem.content!.images.first.toString(),
                height: 110.h,
                width: 100.h,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rssItem.title.toString(),
                      maxLines: 1,
                      style:customTitleBold(kDarkText, 16, FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      rssItem.description.toString(),
                      maxLines: 3,
                      style:customTitleBold(kDarkText, 10, FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.yMMMMd().format(
                            DateTime.parse(
                              rssItem.pubDate.toString(),
                            ),
                          ),
                          style: customTitleBold(kApp3, 12, FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return ReadArticleScreen(
                                rssItem: rssItem,
                              );
                            }));
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                color: kApp3,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20.r,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
