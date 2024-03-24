import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../model/articles/article_model.dart';

class ArticleWidget extends StatelessWidget {
  final Article article;
  const ArticleWidget({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: KSizes.defaultSpace),
      decoration: BoxDecoration(
        color: kEmptyProgress,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20 ),
                bottomLeft: Radius.circular(20 ),
                topRight: Radius.circular(70 ),
                bottomRight: Radius.circular(70 )
            ),
            child: Image.network(
              article.imageUrl.toString(),
              height: Get.height * 0.18,
              width: Get.width * 0.4,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(KSizes.md ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: KSizes.sm ,
                  ),
                  Text(
                    article.description.toString(),
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: KSizes.md ,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(
                          DateTime.parse(
                            article.publishedAt.toString(),
                          ),
                        ),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //   return ReadArticleScreen(
                          //     rssItem: rssItem,
                          //   );
                          // }));
                        },
                        child: const Icon(
                          CupertinoIcons.globe,
                          color: kApp3,
                          size: KSizes.iconXl,
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
    );
  }
}
