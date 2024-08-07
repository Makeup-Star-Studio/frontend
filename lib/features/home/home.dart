import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/navbar/home_top_bar_contents.dart';
import 'package:makeupstarstudio/core/common/navbar/menu_drawer.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/features/home/components/about.dart';
import 'package:makeupstarstudio/features/home/components/footer.dart';
import 'package:makeupstarstudio/features/home/components/how_it_works.dart';
import 'package:makeupstarstudio/features/home/components/info.dart';
import 'package:makeupstarstudio/features/home/components/mission.dart';
import 'package:makeupstarstudio/features/home/components/services.dart';
import 'package:makeupstarstudio/features/home/components/subscribe.dart';
import 'package:makeupstarstudio/features/home/components/testimonial.dart';

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
              child: const HomeTopBarContents(),
            ),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AboutSection(),
            const ServiceSection(),
            const SizedBox(height: 20.0),
            const WorkingSection(),
            const SizedBox(height: 40.0),
            BigText(
              text: '"Real Stories, Real Glam: Hear From Our Happy Clients"',
              size: 28.0,
              mediumSize: 25.0,
              smallSize: 22.0,
              height: ResponsiveWidget.isSmallScreen(context) ? 1.2 : 1.75,
            ),
            const TestimonialSection(),
            const MissionSection(),
            const SizedBox(height: 40.0),
            const SubscriptionSection(),
            const SizedBox(height: 10.0),
            const InfoSection(),
            const SizedBox(height: 40.0),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
