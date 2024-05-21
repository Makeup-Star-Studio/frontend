import 'package:flutter/material.dart';
import 'package:makeupstarstudio/core/app.dart';
import 'package:makeupstarstudio/features/admin/controllers/menu_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Provider for the admin menu controller
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
        // Add other providers here if needed
      ],
      child: const MyApp(),
    ),
  );
}
