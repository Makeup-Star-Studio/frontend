import 'package:flutter/material.dart';
import 'package:makeupstarstudio/core/app.dart';
import 'package:makeupstarstudio/src/provider/auth/login_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/bridal_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/draping_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/henna_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/non_bridal_hair_services.dart';
import 'package:makeupstarstudio/src/provider/services_category/non_bridal_makeup_services_provider.dart';
import 'package:makeupstarstudio/src/provider/testimonial/testimonial_provider.dart';
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
        ChangeNotifierProvider(create: (_) => TestimonialProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


// import 'package:flutter/material.dart';
// import 'package:makeupstarstudio/core/app.dart';
// import 'package:makeupstarstudio/src/provider/auth/login_provider.dart';
// import 'package:makeupstarstudio/src/provider/services_category/bridal_services_provider.dart';
// import 'package:makeupstarstudio/src/provider/services_category/draping_services_provider.dart';
// import 'package:makeupstarstudio/src/provider/services_category/henna_services_provider.dart';
// import 'package:makeupstarstudio/src/provider/services_category/non_bridal_hair_services.dart';
// import 'package:makeupstarstudio/src/provider/services_category/non_bridal_makeup_services_provider.dart';
// import 'package:makeupstarstudio/src/provider/testimonial/testimonial_provider.dart';
// import 'package:makeupstarstudio/src/services/shared_pref.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final SharedPreferencesService sharedPrefs = SharedPreferencesService();
//   await sharedPrefs.init(); // Initialize SharedPreferences once

//   // Fetching and casting values
//   bool logged = await sharedPrefs.getBoolPref('logged') as bool;
//   String? userData = await sharedPrefs.getStringPref('userData') as String?;

//   // Debugging: print values to check
//   print('Logged: $logged');
//   print('User Data: $userData');

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => LoginProvider()),
//             ChangeNotifierProvider(create: (_) => BridalServicesProvider()),
//         ChangeNotifierProvider(
//             create: (_) => NonBridalMakeupServicesProvider()),
//         ChangeNotifierProvider(create: (_) => NonBridalHairServicesProvider()),
//         ChangeNotifierProvider(create: (_) => HennaServicesProvider()),
//         ChangeNotifierProvider(create: (_) => DrapingServicesProvider()),
//         ChangeNotifierProvider(create: (_) => TestimonialProvider()),
//         // Add other providers here
//       ],
//       child: MyApp(logged: logged, userData: userData),
//     ),
//   );
// }

