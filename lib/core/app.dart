// import 'package:flutter/material.dart';
// import 'package:makeupstarstudio/config/router/website_route.dart';
// import 'package:makeupstarstudio/config/themes/app_theme.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Makeup Star Studio',
//       theme: AppTheme.getApplicationTheme(context),
//       initialRoute: WebsiteRoute.homeRoute,
//       routes: WebsiteRoute.getApplicationRoute(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/config/themes/app_theme.dart';
import 'package:makeupstarstudio/features/admin/screens/login/admin_login.dart';
import 'package:makeupstarstudio/features/admin/screens/main/admin_main_page.dart';
import 'package:makeupstarstudio/navigator_key.dart';
import 'package:makeupstarstudio/src/provider/auth/check_login_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckLoginProvider()..checkLoginStatus(),
      child: Consumer<CheckLoginProvider>(
        builder: (context, loginProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            title: 'Makeup Star Studio',
            theme: AppTheme.getApplicationTheme(context),
            home: loginProvider.isLoggedIn
                ? const AdminPage(selectedIndex: 0)
                : const AdminLoginScreen(),
            initialRoute: WebsiteRoute.homeRoute,
            routes: WebsiteRoute.getApplicationRoute(),
          );
        },
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:makeupstarstudio/config/router/website_route.dart';
// import 'package:makeupstarstudio/config/themes/app_theme.dart';

// class MyApp extends StatelessWidget {
//   final bool logged;
//   final String? userData;

//   const MyApp({Key? key, required this.logged, this.userData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Makeup Star Studio',
//       theme: AppTheme.getApplicationTheme(context),
//       initialRoute: logged ? WebsiteRoute.adminRoute : WebsiteRoute.loginRoute,
//       routes: WebsiteRoute.getApplicationRoute(),
//     );
//   }
// }
