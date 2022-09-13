import 'package:flutter/material.dart';
import 'package:quiz_app/config/my_theme.dart';
import 'package:quiz_app/pages/home_page.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      home: HomePage(),
    );
  }
}
