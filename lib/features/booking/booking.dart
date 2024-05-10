import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/navbar/menu_drawer.dart';
import 'package:makeupstarstudio/core/common/navbar/top_bar_contents.dart';
import 'package:makeupstarstudio/features/booking/components/booking_form.dart';
import 'package:makeupstarstudio/features/booking/components/booking_header.dart';
import 'package:makeupstarstudio/features/booking/components/header_content_of_booking.dart';
import 'package:makeupstarstudio/features/home/components/footer.dart';
import 'package:makeupstarstudio/features/home/components/info.dart';
import 'package:makeupstarstudio/features/home/components/subscribe.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColorConstant.backgroundColor,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              iconTheme: const IconThemeData(color: AppColorConstant.black),
              backgroundColor: AppColorConstant.backgroundColor,
              elevation: 0,
              centerTitle: true,
              title: Image.asset(
                'assets/images/contact.png',
                width: 70,
                height: 60,
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 130.0),
              child: const TopNavigationBar(),
            ),
      drawer: const MenuDrawer(),
      body: ListView(
        children: const [
          BookingHeaderSection(),
          SizedBox(height: 80.0),
          HeaderContentBookingSection(
              title: 'book your glam appointment',
              subTitle: 'fill out the form below'),
          SizedBox(height: 20.0),
          BookingFormSection(),
          SizedBox(height: 40.0),
          SubscriptionSection(),
          SizedBox(height: 10.0),
          InfoSection(),
          SizedBox(height: 40.0),
          FooterSection(),
        ],
      ),
    );
  }
}
