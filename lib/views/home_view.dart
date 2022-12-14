import 'package:flutter/material.dart';
import 'package:news/controllers/search_controller.dart';
import 'package:news/enums/sort_enums.dart';
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
  late HomeController hc;
  late SearchController sc;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    hc = Provider.of<HomeController>(context, listen: false);
    sc = Provider.of<SearchController>(context, listen: false);
    TabController(length: categories.length, vsync: this);
    _tabController?.addListener(_setActiveTabIndex);
    fetchNews();
  }

  void _setActiveTabIndex() {
    _activeTabIndex = _tabController?.index;
  }

  fetchNews() async {
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
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.go,
                        controller: _textEditingController,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: hexToColor("00ADB5"),
                        ),
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15, 5, 0, 5),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              color: hexToColor("00ADB5"),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: hexToColor("dddddd"),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: hexToColor("dddddd"),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                        onSubmitted: ((value) {
                          Navigator.pop(context);
                          sc.fetchSearchNews(value);
                          Navigator.pushNamed(
                            context,
                            '/search',
                            arguments: {
                              "search": value,
                            },
                          );
                        }),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sort News By",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                              height: 2,
                            ),
                            InkWell(
                              onTap: () {
                                hc.changeSortEnum(SORT_ENUM.RELEVANCY);
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Relevancy"),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.check,
                                      color: hc.sort_enum == SORT_ENUM.RELEVANCY
                                          ? Colors.green
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                hc.changeSortEnum(SORT_ENUM.POPULARITY);
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Popularity"),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.check,
                                      color:
                                          hc.sort_enum == SORT_ENUM.POPULARITY
                                              ? Colors.green
                                              : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                hc.changeSortEnum(SORT_ENUM.PUBLISHEDAT);
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Published At"),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.check,
                                      color:
                                          hc.sort_enum == SORT_ENUM.PUBLISHEDAT
                                              ? Colors.green
                                              : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.sort,
              ),
            ),
          ],
          // centerTitle: true,
          bottom: TabBar(
            labelColor: hexToColor("00ADB5"),
            controller: _tabController,
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            tabs: categories
                .map<Widget>(
                  (category) => Tab(
                    text: capitalize(category),
                  ),
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
                    : RefreshIndicator(
                        onRefresh: () async {
                          await hc.fetchNewsByCateogries();
                        },
                        child: ListView.builder(
                          itemCount: data.newsByCategories[_activeTabIndex!]
                              .articles?.length,
                          itemBuilder: (context, index) {
                            Articles? article = data
                                .newsByCategories[item.key].articles?[index];
                            return NewsContainer(
                              article: article,
                            );
                          },
                        ),
                      );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
