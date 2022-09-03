import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/models/news_model.dart';

class SearchController extends ChangeNotifier {
  late NewsModel searchNews;
  bool loading = true;

  // Fetch News From API
  fetchSearchNews(String search) async {
    try {
      Response response = await Dio().get(
          "https://newsapi.org/v2/everything?q=$search&popularity&apiKey=${dotenv.env['API_KEY']}");
      searchNews = NewsModel.fromJson(response.data);
      loading = false;
      notifyListeners();
    } catch (err) {
      print(err.toString());
    }
  }
}
