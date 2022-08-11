import 'package:flutter/material.dart';
import 'package:news/models/news_model.dart';
import 'package:news/utils/dimensions.dart';
import 'package:news/utils/time_converter.dart';

class NewsView extends StatefulWidget {
  late Articles article;
  NewsView({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    String? time = convertDateToString(widget.article.publishedAt);

    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "${widget.article.urlToImage}",
            height: getSize(context).height,
            width: getSize(context).width,
            fit: BoxFit.cover,
          ),
          Container(
            height: getSize(context).height,
            width: getSize(context).width,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  widget.article.title ?? " ",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${widget.article.source?.name}",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    widget.article.description ?? " ",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
