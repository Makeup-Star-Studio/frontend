// import 'package:flutter/material.dart';
// import 'package:makeupstarstudio/config/router/website_route.dart';
// import 'package:makeupstarstudio/config/themes/app_theme.dart';
// import 'package:makeupstarstudio/core/app.dart';
// import 'package:makeupstarstudio/src/provider/auth/login_provider.dart';
// import 'package:makeupstarstudio/src/provider/services_category/bridal_services_provider.dart';
// import 'package:makeupstarstudio/src/provider/services_category/draping_services_provider.dart';
// import 'package:makeupstarstudio/src/provider/services_category/henna_services_provider.dart';
// import 'package:makeupstarstudio/src/provider/services_category/non_bridal_hair_services.dart';
// import 'package:makeupstarstudio/src/provider/services_category/non_bridal_makeup_services_provider.dart';
// import 'package:makeupstarstudio/src/provider/testimonial/testimonial_provider.dart';
// import 'package:provider/provider.dart';

// class MainApp extends StatelessWidget {
//   final bool logged;
//   final String? userData;

//   const MainApp({Key? key, required this.logged, this.userData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => LoginProvider()),
//          ChangeNotifierProvider(create: (_) => BridalServicesProvider()),
//         ChangeNotifierProvider(
//             create: (_) => NonBridalMakeupServicesProvider()),
//         ChangeNotifierProvider(create: (_) => NonBridalHairServicesProvider()),
//         ChangeNotifierProvider(create: (_) => HennaServicesProvider()),
//         ChangeNotifierProvider(create: (_) => DrapingServicesProvider()),
//         ChangeNotifierProvider(create: (_) => TestimonialProvider()),
//         // Add other providers here
//       ],
//       child: MyApp(logged: logged, userData: userData),
//     );
//   }
// }
