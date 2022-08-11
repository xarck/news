import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/controllers/home_controller.dart';
import 'package:news/utils/util.dart';
import 'package:news/views/home_view.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ChangeNotifierProvider(
      create: (_) => HomeController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "RoboRegular",
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontFamily: "RoboBold",
            fontSize: 29,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontFamily: "RoboBold",
            fontSize: 12,
            color: hexToColor("bababa"),
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            color: hexToColor("f2f2f2"),
          ),
          displaySmall: TextStyle(
            fontSize: 14,
            color: hexToColor("bababa"),
          ),
        ),
        scaffoldBackgroundColor: hexToColor("464646"),
      ),
      home: HomeView(),
    );
  }
}
