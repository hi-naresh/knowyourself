import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/screens/Rss%20Screen/widgets/blog_container.dart';

import '../../provider/RSS Reader/rss_reader_provider.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          Consumer<RSSReaderProvider>(
            builder: (BuildContext context, rss, Widget? child) {
              if (rss.isLoading) {
                rss.fetchBlogs();
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (rss.blogs.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("Empty"),
                  ),
                );
              } else if (rss.blogs.isNotEmpty) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: rss.blogs.length + 1, (context, index) {
                  if (index == rss.blogs.length) {
                    return SizedBox(
                      height: 80.h,
                    );
                  }
                  return BlogContainer(rssItem: rss.blogs[index]);
                }));
              }
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text("Oops! Error Occured"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
