import 'package:flutter/material.dart';
import 'package:news/utils/util.dart';
import 'package:provider/provider.dart';

import 'package:news/constants/constants.dart';
import 'package:news/controllers/home_controller.dart';
import 'package:news/models/news_model.dart';
import 'package:news/views/news_container.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int? _activeTabIndex = 0;
  @override
  void initState() {
    super.initState();
    TabController(length: categories.length, vsync: this);
    _tabController?.addListener(_setActiveTabIndex);
    fetchNews();
  }

  void _setActiveTabIndex() {
    _activeTabIndex = _tabController?.index;
  }

  fetchNews() async {
    HomeController hc = Provider.of<HomeController>(context, listen: false);
    await hc.fetchNewsByCateogries();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'HEADLINES',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.sort,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.filter_alt_outlined),
            )
          ],
          // centerTitle: true,
          bottom: TabBar(
            labelColor: hexToColor("00ADB5"),
            controller: _tabController,
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            tabs: categories
                .map<Widget>(
                  (category) => Tab(text: capitalize(category)),
                )
                .toList(),
          ),
        ),
        body: Consumer<HomeController>(
          builder: (context, data, child) {
            return TabBarView(
              children: categories.asMap().entries.map((item) {
                return data.loading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: data.newsByCategories[_activeTabIndex!]
                            .articles?.length,
                        itemBuilder: (context, index) {
                          Articles? article =
                              data.newsByCategories[item.key].articles?[index];
                          return NewsContainer(
                            article: article,
                          );
                        },
                      );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
