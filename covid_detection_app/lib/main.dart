import 'package:covid_detection_app/pages/onBoarding_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OnBoardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
