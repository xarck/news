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





























// import 'package:flutter/material.dart';
// import 'package:news/models/news_model.dart';
// import 'package:news/utils/dimensions.dart';
// import 'package:news/utils/time_converter.dart';

// class NewsView extends StatefulWidget {
//   late Articles article;
//   NewsView({
//     Key? key,
//     required this.article,
//   }) : super(key: key);

//   @override
//   State<NewsView> createState() => _NewsViewState();
// }

// class _NewsViewState extends State<NewsView> {
//   @override
//   Widget build(BuildContext context) {
//     String? time = convertDateToString(widget.article.publishedAt);

//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.network(
//             "${widget.article.urlToImage}",
//             height: getSize(context).height,
//             width: getSize(context).width,
//             fit: BoxFit.cover,
//             errorBuilder: (BuildContext context, Object exception,
//                 StackTrace? stackTrace) {
//               return Container(
//                 decoration: BoxDecoration(color: Colors.grey),
//               );
//             },
//           ),
//           Container(
//             height: getSize(context).height,
//             width: getSize(context).width,
//             margin: EdgeInsets.all(10),
//             padding: EdgeInsets.symmetric(
//               horizontal: 5,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 50),
//                   child: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                     icon: Icon(
//                       Icons.arrow_back,
//                       size: 30,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 Text(
//                   widget.article.title ?? " ",
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   margin: EdgeInsets.only(top: 50),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "${widget.article.source?.name}",
//                             style: Theme.of(context).textTheme.displayMedium,
//                           ),
//                           Text(
//                             time,
//                             style: Theme.of(context).textTheme.displayMedium,
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         widget.article.description ?? " ",
//                         style: Theme.of(context).textTheme.displaySmall,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
