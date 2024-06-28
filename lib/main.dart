import 'package:flutter/material.dart';
import 'package:makeupstarstudio/core/app.dart';
import 'package:provider/provider.dart';
import 'package:makeupstarstudio/src/provider/services_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServicesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
