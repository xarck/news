import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/controllers/home_controller.dart';
import 'package:news/routes/route_generator.dart';
import 'package:news/utils/util.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Proxima",
        primarySwatch: Colors.teal,
        appBarTheme: AppBarTheme(
          backgroundColor: hexToColor("222831"),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 17,
            color: hexToColor("EEEEEE"),
          ),
          titleMedium: TextStyle(
            fontSize: 14,
            color: hexToColor("EEEEEE"),
          ),
          displayLarge: TextStyle(
            fontFamily: "RoboBold",
            fontSize: 24,
            color: hexToColor("f2f2f2"),
          ),
        ),
        scaffoldBackgroundColor: hexToColor("222831"),
      ),
    );
  }
}
