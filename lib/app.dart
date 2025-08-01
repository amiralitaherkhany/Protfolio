import 'package:flutter/material.dart';
import 'package:my_portfolio/pages/main_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amirali\'s Portfolio',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
