import 'package:flutter/material.dart';
import 'package:instagram_analytics_app/view/home_screen.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Return Users',
        home: HomePage(),
        debugShowCheckedModeBanner: false); // define it once at root level.
  }
}