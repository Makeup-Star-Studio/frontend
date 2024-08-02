import 'package:flutter/material.dart';
import 'package:makeupstarstudio/features/about/about.dart';
import 'package:makeupstarstudio/features/admin/screens/login/admin_login.dart';
import 'package:makeupstarstudio/features/admin/screens/main/admin_main_page.dart';
import 'package:makeupstarstudio/features/booking/booking.dart';
import 'package:makeupstarstudio/features/bridal/bridal.dart';
import 'package:makeupstarstudio/features/contact/contact.dart';
import 'package:makeupstarstudio/features/gallery/gallery.dart';
import 'package:makeupstarstudio/features/home/home.dart';
import 'package:makeupstarstudio/features/services/services.dart';

class WebsiteRoute {
  WebsiteRoute._();

  // static const String adminRoute = '/admin';
  static const String homeRoute = '/home';
  static const String loginRoute = '/login';
  static const String aboutRoute = '/about';
  static const String servicesRoute = '/services';
  static const String bridalRoute = '/bridal';
  static const String galleryRoute = '/gallery';
  static const String contactRoute = '/contact';
  static const String bookRoute = '/book';

  static Map<String, WidgetBuilder> getApplicationRoute() {
    return {
      // adminRoute: (context) => const AdminPage(),
      homeRoute: (context) => const HomePage(),
      loginRoute: (context) => const AdminLoginScreen(),
      aboutRoute: (context) => const AboutPage(),
      servicesRoute: (context) => const ServicesPage(),
      bridalRoute: (context) => const BridalPage(),
      galleryRoute: (context) => const GalleryPage(),
      contactRoute: (context) => const ContactPage(),
      bookRoute: (context) => const BookingPage(),
    };
  }
}
