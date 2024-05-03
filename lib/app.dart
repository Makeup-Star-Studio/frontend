import 'package:flutter/material.dart';
import 'package:makeupstarstudio/home/home.dart';
import 'package:makeupstarstudio/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Makeup Star Studio',
      theme: AppTheme.getApplicationTheme(context),
      home: HomePage(),
    );
  }
}