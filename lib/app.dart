import 'package:flutter/material.dart';
import 'package:makeupstarstudio/home/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Makeup Star Studio',
      home: HomePage(),
    );
  }
}