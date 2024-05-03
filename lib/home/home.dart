import 'package:flutter/material.dart';
import 'package:makeupstarstudio/common/menu_drawer.dart';
import 'package:makeupstarstudio/common/top_bar_contents.dart';
import 'package:makeupstarstudio/home/widget/about.dart';
import 'package:makeupstarstudio/home/widget/footer.dart';
import 'package:makeupstarstudio/home/widget/info.dart';
import 'package:makeupstarstudio/home/widget/how_it_works.dart';
import 'package:makeupstarstudio/home/widget/mission.dart';
import 'package:makeupstarstudio/home/widget/services.dart';
import 'package:makeupstarstudio/home/widget/subscribe.dart';
import 'package:makeupstarstudio/home/widget/testimonial.dart';
import 'package:makeupstarstudio/theme/color.dart';
import 'package:makeupstarstudio/theme/responsive.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                'assets/images/logo-black.png',
                width: 70,
                height: 60,
              ),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 130.0),
              child: const TopBarContents(),
            ),
      drawer: const MenuDrawer(),
      body: ListView(
        children: const [
          AboutSection(),
          ServiceSection(),
          SizedBox(height: 20.0),
          WorkingSection(),
          SizedBox(height: 40.0),
          TestimonialSection(),
          MissionSection(),
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
