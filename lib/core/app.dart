import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/config/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Makeup Star Studio',
      theme: AppTheme.getApplicationTheme(context),
      initialRoute: WebsiteRoute.homeRoute,
      routes: WebsiteRoute.getApplicationRoute(),
    );
  }
}
