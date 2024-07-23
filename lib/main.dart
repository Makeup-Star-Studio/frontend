import 'package:flutter/material.dart';
import 'package:makeupstarstudio/core/app.dart';
import 'package:makeupstarstudio/src/provider/auth/login_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/bridal_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/draping_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/henna_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/non_bridal_hair_services.dart';
import 'package:makeupstarstudio/src/provider/services_category/non_bridal_makeup_services_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BridalServicesProvider()),
        ChangeNotifierProvider(
            create: (_) => NonBridalMakeupServicesProvider()),
        ChangeNotifierProvider(create: (_) => NonBridalHairServicesProvider()),
        ChangeNotifierProvider(create: (_) => HennaServicesProvider()),
        ChangeNotifierProvider(create: (_) => DrapingServicesProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
