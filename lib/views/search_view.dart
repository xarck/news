import 'package:flutter/material.dart';
import 'package:news/models/news_model.dart';
import 'package:news/views/news_container.dart';
import 'package:provider/provider.dart';

import 'package:news/controllers/search_controller.dart';

class SearchView extends StatefulWidget {
  SearchView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);
  final String searchTerm;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Consumer<SearchController>(
        builder: (context, data, child) {
          return data.loading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await data.fetchSearchNews(widget.searchTerm);
                  },
                  child: ListView.builder(
                    itemCount: data.searchNews.articles?.length,
                    itemBuilder: (context, index) {
                      Articles? article = data.searchNews.articles?[index];
                      return NewsContainer(
                        article: article,
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
