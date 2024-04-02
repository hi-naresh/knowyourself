import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../model/article_model.dart';
import 'package:get/get.dart';

class ReadArticleScreen extends StatelessWidget {
  final Article article;
  const ReadArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(back: true,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20 ),
                    bottomLeft: Radius.circular(20 ),
                    topRight: Radius.circular(70 ),
                    bottomRight: Radius.circular(70 )
                ),
                child: Image.network(
                    article.urlToImage.toString(),
                    height: Get.height * 0.3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: KSizes.defaultSpace),
              Text(
                article.title.toString(),
                style : Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: KSizes.defaultSpace),
              Text(
                DateFormat.yMMMMd().format(
                  DateTime.parse(
                    article.publishedAt.toString(),
                  ),
                ),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: KSizes.defaultSpace),
              Text(
                article.content.toString(),
                maxLines: 20,
                style : Theme.of(context).textTheme.bodyMedium,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
