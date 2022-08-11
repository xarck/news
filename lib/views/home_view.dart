import 'package:flutter/material.dart';
import 'package:news/controllers/home_controller.dart';
import 'package:news/models/news_model.dart';
import 'package:news/utils/dimensions.dart';
import 'package:news/utils/time_converter.dart';
import 'package:news/views/news_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  fetchNews() async {
    HomeController hc = Provider.of<HomeController>(context, listen: false);
    await hc.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HEADLINES',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Consumer<HomeController>(
        builder: (context, data, child) {
          return data.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: data.newsCollection.totalResults,
                  itemBuilder: (context, index) {
                    Articles? article = data.newsCollection.articles?[index];
                    String? time = convertDateToString(article?.publishedAt);
                    return Container(
                      margin: EdgeInsets.all(10),
                      height: 200,
                      child: Stack(
                        children: [
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsView(
                                      article: article!,
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  article?.urlToImage ?? "",
                                  height: 200,
                                  width: getSize(context).width / 1.1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  article?.title ?? " ",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${article?.source?.name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      time,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
