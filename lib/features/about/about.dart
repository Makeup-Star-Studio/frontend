import 'package:flutter/material.dart';
import 'package:makeupstarstudio/core/common/navbar/menu_drawer.dart';
import 'package:makeupstarstudio/core/common/navbar/top_bar_contents.dart';
import 'package:makeupstarstudio/features/about/components/about_me.dart';
import 'package:makeupstarstudio/features/about/components/little_about_me.dart';
import 'package:makeupstarstudio/features/about/components/our_mission.dart';
import 'package:makeupstarstudio/features/about/components/why_choose_us.dart';
import 'package:makeupstarstudio/features/home/components/footer.dart';
import 'package:makeupstarstudio/features/home/components/info.dart';
import 'package:makeupstarstudio/features/home/components/subscribe.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
              child: const TopNavigationBar(),
            ),
      drawer: const MenuDrawer(),
      body: ListView(
        children: const [
          AboutMeSection(),
          WhyChooseUsSection(),
          AboutMissionSection(),
          LittleAboutMeSection(),
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
