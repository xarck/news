import 'package:flutter/material.dart';
import 'package:news/views/home_view.dart';
import 'package:news/views/news_view.dart';
import 'package:news/views/search_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/search':
        Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => SearchView(
            searchTerm: args['search'],
          ),
        );
      case '/news':
        Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => NewsView(
            articleUrl: args['articleUrl'],
            source: args['source'],
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
