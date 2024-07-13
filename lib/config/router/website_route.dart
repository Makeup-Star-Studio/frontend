import 'package:makeupstarstudio/features/about/about.dart';
import 'package:makeupstarstudio/features/admin/screens/main/admin_main_page.dart';
import 'package:makeupstarstudio/features/booking/booking.dart';
import 'package:makeupstarstudio/features/bridal/bridal.dart';
import 'package:makeupstarstudio/features/contact/contact.dart';
import 'package:makeupstarstudio/features/gallery/gallery.dart';
import 'package:makeupstarstudio/features/home/home.dart';
import 'package:makeupstarstudio/features/services/services.dart';

class WebsiteRoute {
  WebsiteRoute._();

  // admin
  static const String adminRoute = '/admin';

  static const String splashRoute = '/splash';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String aboutRoute = '/about';
  static const String servicesRoute = '/services';
  static const String bridalRoute = '/bridal';
  static const String galleryRoute = '/gallery';
  static const String contactRoute = '/contact';
  static const String bookRoute = '/book';
  // static const String editProfile = '/editProfile';
  // static const String changePassword= '/changePassword';

  static getApplicationRoute() {
    return {
      adminRoute : (context) => const AdminPage(),
      // splashRoute: (context) => const SplashView(),
      homeRoute: (context) => const HomePage(),
      // loginRoute: (context) => const LoginPageView(),
      // registerRoute: (context) => const SignUpPageView(),
      // profileRoute: (context) => ProfilePageView(),
      aboutRoute: (context) => const AboutPage(),
      servicesRoute: (context) => const ServicesPage(),
      bridalRoute: (context) => const BridalPage(),
      galleryRoute: (context) => const GalleryPage(),
      contactRoute: (context) => const ContactPage(),
      bookRoute: (context) => const BookingPage(),
      // editProfile: (context) => const UpdateProfileView(),
      // changePassword: (context) => const ChangePasswordView(),
    };
  }
}
