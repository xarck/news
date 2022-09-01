import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/constants/constants.dart';
import 'package:news/models/news_model.dart';

class HomeController extends ChangeNotifier {
  late NewsModel newsCollection;
  List<NewsModel> newsByCategories = [];
  bool loading = true;

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
            "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=${dotenv.env['API_KEY']}&page=1");
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
