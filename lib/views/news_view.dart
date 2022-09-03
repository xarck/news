import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {
  NewsView({
    Key? key,
    required this.articleUrl,
    required this.source,
  }) : super(key: key);
  final String articleUrl;
  final String source;
  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final _key = UniqueKey();
  late dynamic _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.source),
      ),
      body: WebView(
        key: _key,
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.articleUrl,
        onWebViewCreated: (controller) {
          _controller = controller;
        },
        onPageStarted: (String url) async {},
      ),
    );
  }
}
