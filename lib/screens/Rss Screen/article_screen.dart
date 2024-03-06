import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/screens/Rss%20Screen/widgets/blog_container.dart';
import 'package:webfeed_revised/domain/rss_item.dart';

import '../../provider/RSS Reader/rss_reader_provider.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen>
    with AutomaticKeepAliveClientMixin {
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'Mental', 'Physical', 'Emotional', 'Other Aspects'];

  // A method to filter blogs by category
  List<RssItem> filterBlogsByCategory(List<RssItem> blogs, String category) {
    if (category == 'All') {
      return blogs;
    } else {
      return blogs.where((blog) =>
      blog.categories!.any((element) => element.value.toLowerCase() == category.toLowerCase())).toList();
    }
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final rss = Provider.of<RSSReaderProvider>(context, listen: false);
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 50.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      backgroundColor: kBoxLight,
                      selectedColor: kApp3.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(10),
                      label: Text(categories[index]),
                      selected: selectedCategory == categories[index],
                      onSelected: (bool selected) {
                        setState(() {
                          selectedCategory = categories[index];
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),
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
