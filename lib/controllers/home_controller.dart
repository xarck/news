import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/constants/constants.dart';
import 'package:news/constants/sort_constant.dart';
import 'package:news/enums/sort_enums.dart';
import 'package:news/models/news_model.dart';

class HomeController extends ChangeNotifier {
  late NewsModel newsCollection;
  List<NewsModel> newsByCategories = [];
  bool loading = true;
  SORT_ENUM sort_enum = SORT_ENUM.PUBLISHEDAT;

  void changeSortEnum(SORT_ENUM se) {
    sort_enum = se;
    loading = true;
    notifyListeners();
    fetchNewsByCateogries();
  }

  // Fetch News From API
  searchNews(String serach, dynamic filters) async {
    try {
      Response response = await Dio().get(
          "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=${dotenv.env['API_KEY']}");
      newsCollection = NewsModel.fromJson(response.data);
      loading = false;
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }

  // Fetch News By Categories
  fetchNewsByCateogries() async {
    try {
      for (final category in categories) {
        Response response = await Dio().get(
            "https://newsapi.org/v2/top-headlines?country=us&category=$category&sortBy=${sortEnumMap[sort_enum]}&apiKey=${dotenv.env['API_KEY']}&page=1");
        NewsModel catNews = NewsModel.fromJson(response.data);
        newsByCategories.add(catNews);
      }
      loading = false;
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }
}
