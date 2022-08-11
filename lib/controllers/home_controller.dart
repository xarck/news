import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/models/news_model.dart';

class HomeController extends ChangeNotifier {
  late NewsModel newsCollection;
  bool loading = true;

  // Fetch News From API
  fetchNews() async {
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
}
