import 'package:makeupstarstudio/features/about/about.dart';
import 'package:makeupstarstudio/features/home/home.dart';
import 'package:makeupstarstudio/features/services/services.dart';

class WebsiteRoute {
  WebsiteRoute._();

  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String aboutRoute = '/about';
  static const String servicesRoute = '/services';
  static const String galleryRoute = '/gallery';
  static const String contactRoute = '/contact';
  static const String bookRoute = '/book';
  // static const String editProfile = '/editProfile';
  // static const String changePassword= '/changePassword';

  static getApplicationRoute() {
    return {
      // splashRoute: (context) => const SplashView(),
      homeRoute: (context) => const HomePage(),
      // loginRoute: (context) => const LoginPageView(),
      // registerRoute: (context) => const SignUpPageView(),
      // profileRoute: (context) => ProfilePageView(),
      aboutRoute: (context) => const AboutPage(),
      servicesRoute: (context) => const ServicesPage(),
      // galleryRoute: (context) => const GalleryPage(),
      // contactRoute: (context) => const ContactPage(),
      // bookRoute: (context) => const BookingPage(),
      // editProfile: (context) => const UpdateProfileView(),
      // changePassword: (context) => const ChangePasswordView(),
    };
  }
}