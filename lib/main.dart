import 'package:flutter/material.dart';
import 'package:space_pod/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Space Pod',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade900,
        primaryColor: Colors.pink.shade400,
        useMaterial3: true,
        fontFamily: 'SixtyFour'
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

