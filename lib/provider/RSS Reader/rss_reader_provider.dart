import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:webfeed_revised/webfeed_revised.dart';

class RSSReaderProvider extends ChangeNotifier {
  List<RssItem> _blogs = [];
  List<RssItem> get blogs => _blogs;
  final bool _hasError = false;
  bool get hasError => _hasError;
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  void fetchBlogs() async {
    final client = IOClient(
      HttpClient()..badCertificateCallback = ((cert, host, port) => true),
    );
    try {
      var response = await client.get(
        Uri.parse(
          'https://www.mentcura.com/blog/blog-feed.xml',
        ),
      );

      _isLoading = false;

      notifyListeners();

      final rssFeed = RssFeed.parse(response.body);
      if (rssFeed.items != null) {
        _blogs = rssFeed.items!;
      }

      client.close();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
