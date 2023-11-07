import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/screens/Rss%20Screen/read_article_screen.dart';
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
        margin: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0.0, 4.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r)),
              child: Image.network(
                rssItem.content!.images.first.toString(),
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(),
            Padding(
              padding: EdgeInsets.all(8.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rssItem.title.toString(),
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    rssItem.description.toString(),
                    style:
                        TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w300),
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
                        style: TextStyle(fontSize: 12.sp, color: Colors.blue),
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
                              color: kPrimaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          width: 80.w,
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30.r,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
