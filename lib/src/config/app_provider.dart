import 'package:makeupstarstudio/src/provider/admin/user_provider.dart';
import 'package:makeupstarstudio/src/provider/auth/check_login_provider.dart';
import 'package:makeupstarstudio/src/provider/auth/login_provider.dart';
import 'package:makeupstarstudio/src/provider/booking/booking_provider.dart';
import 'package:makeupstarstudio/src/provider/images/random_images_provider.dart';
import 'package:makeupstarstudio/src/provider/portfolio/bridal_portfolio.dart';
import 'package:makeupstarstudio/src/provider/portfolio/henna_provider.dart';
import 'package:makeupstarstudio/src/provider/portfolio/non_bridal_gallery.dart';
import 'package:makeupstarstudio/src/provider/portfolio/portfolio_provider.dart';
import 'package:makeupstarstudio/src/provider/portfolio/white_bride_provider.dart';
import 'package:makeupstarstudio/src/provider/services/bridal_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services/draping_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services/henna_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services/non_bridal_hair_services.dart';
import 'package:makeupstarstudio/src/provider/services/non_bridal_makeup_services_provider.dart';
import 'package:makeupstarstudio/src/provider/services/services_provider.dart';
import 'package:makeupstarstudio/src/provider/testimonial/testimonial_provider.dart';
import 'package:provider/provider.dart';

class AppProvider {
  static final loginProvider = LoginProvider();
  static final serviceProvider = ServicesProvider();
  static final bridalServiceProvider = BridalServicesProvider();
  static final nonBridalMakeupServiceProvider =
      NonBridalMakeupServicesProvider();
  static final nonBridalHairServiceProvider = NonBridalHairServicesProvider();
  static final hennaServiceProvider = HennaServicesProvider();
  static final drapingServiceProvider = DrapingServicesProvider();
  static final testimonialProvider = TestimonialProvider();
  static final bridalPortfolioProvider = BridalPortfolioProvider();
  static final hennaGalleryProvider = HennaGalleryProvider();
  static final nonBridalGalleryProvider = NonBridalGalleryProvider();
  static final whiteBridalGalleryProvider = WhiteBridalProvider();
  static final portfolioProvider = PortfolioProvider();
  static final bookingProvider = BookingProvider();
  static final checkLoginProvider = CheckLoginProvider();
  static final userProvider = UserProvider();
  static final imagesProvider = RandomImageProvider();

  static final List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<LoginProvider>(create: (context) => loginProvider),
    ChangeNotifierProvider<ServicesProvider>(
      create: (context) => serviceProvider,
    ),
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
    ChangeNotifierProvider<BridalPortfolioProvider>(
      create: (context) => bridalPortfolioProvider,
    ),
    ChangeNotifierProvider<HennaGalleryProvider>(
      create: (context) => hennaGalleryProvider,
    ),
    ChangeNotifierProvider<NonBridalGalleryProvider>(
      create: (context) => nonBridalGalleryProvider,
    ),
    ChangeNotifierProvider<WhiteBridalProvider>(
      create: (context) => whiteBridalGalleryProvider,
    ),
    ChangeNotifierProvider<PortfolioProvider>(
      create: (context) => portfolioProvider,
    ),
    ChangeNotifierProvider<BookingProvider>(
      create: (context) => bookingProvider,
    ),
    ChangeNotifierProvider<CheckLoginProvider>(
      create: (context) => checkLoginProvider,
    ),  
    ChangeNotifierProvider<RandomImageProvider>(
      create: (context) => imagesProvider,
    ),
    ChangeNotifierProvider<UserProvider>(create: (context) => userProvider),
  ];

  static void dispose() {
    loginProvider.dispose();
    serviceProvider.dispose();
    bridalServiceProvider.dispose();
    nonBridalMakeupServiceProvider.dispose();
    nonBridalHairServiceProvider.dispose();
    hennaServiceProvider.dispose();
    drapingServiceProvider.dispose();
    testimonialProvider.dispose();
    bridalPortfolioProvider.dispose();
    hennaGalleryProvider.dispose();
    nonBridalGalleryProvider.dispose();
    whiteBridalGalleryProvider.dispose();
    portfolioProvider.dispose();
    bookingProvider.dispose();
    imagesProvider.dispose();
  }

  /// Singleton factory
  static final AppProvider _instance = AppProvider._internal();

  factory AppProvider() {
    return _instance;
  }

  AppProvider._internal();
}
