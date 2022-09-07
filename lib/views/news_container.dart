import 'package:flutter/material.dart';

import 'package:news/models/news_model.dart';
import 'package:news/utils/dimensions.dart';
import 'package:news/utils/util.dart';
import 'package:news/utils/time_converter.dart';

class NewsContainer extends StatefulWidget {
  NewsContainer({
    Key? key,
    this.article,
  }) : super(key: key);
  final Articles? article;
  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getSize(context).width / 1.1,
      decoration: BoxDecoration(
        color: hexToColor("393E46"),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/news',
            arguments: {
              "articleUrl": widget.article!.url!,
              "source": widget.article!.source!.name!
            },
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.article?.urlToImage ?? "",
                height: 200,
                width: getSize(context).width / 1.1,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              capitalize(widget.article?.title),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                convertDateToString(widget.article?.publishedAt),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              capitalize(
                trimString(widget.article?.content),
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
