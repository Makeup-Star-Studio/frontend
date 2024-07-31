import 'package:makeupstarstudio/src/provider/auth/login_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/bridal_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/draping_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/henna_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services_category/non_bridal_hair_services.dart';
import 'package:makeupstarstudio/src/provider/services_category/non_bridal_makeup_services_provider.dart';
import 'package:makeupstarstudio/src/provider/testimonial/testimonial_provider.dart';
import 'package:provider/provider.dart';

class AppProvider {
  static final loginProvider = LoginProvider();
  static final bridalServiceProvider = BridalServicesProvider();
  static final nonBridalMakeupServiceProvider =
      NonBridalMakeupServicesProvider();
  static final nonBridalHairServiceProvider = NonBridalHairServicesProvider();
  static final hennaServiceProvider = HennaServicesProvider();
  static final drapingServiceProvider = DrapingServicesProvider();
  static final testimonialProvider = TestimonialProvider();

  static final List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<LoginProvider>(create: (context) => loginProvider),
    ChangeNotifierProvider<BridalServicesProvider>(
      create: (context) => bridalServiceProvider,
    ),
    ChangeNotifierProvider<NonBridalMakeupServicesProvider>(
      create: (context) => nonBridalMakeupServiceProvider,
    ),
    ChangeNotifierProvider<NonBridalHairServicesProvider>(
      create: (context) => nonBridalHairServiceProvider,
    ),
    ChangeNotifierProvider<HennaServicesProvider>(
      create: (context) => hennaServiceProvider,
    ),
    ChangeNotifierProvider<DrapingServicesProvider>(
      create: (context) => drapingServiceProvider,
    ),
    ChangeNotifierProvider<TestimonialProvider>(
      create: (context) => testimonialProvider,
    ),
  ];

  static void dispose() {
    loginProvider.dispose();
    bridalServiceProvider.dispose();
    nonBridalMakeupServiceProvider.dispose();
    nonBridalHairServiceProvider.dispose();
    hennaServiceProvider.dispose();
    drapingServiceProvider.dispose();
    testimonialProvider.dispose();
  }

  /// Singleton factory
  static final AppProvider _instance = AppProvider._internal();

  factory AppProvider() {
    return _instance;
  }

  AppProvider._internal();
}
