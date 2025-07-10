import 'package:flutter/material.dart';
import 'package:my_portfolio/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amirali\'s Portfolio',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
