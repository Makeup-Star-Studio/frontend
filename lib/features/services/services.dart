import 'package:flutter/material.dart';
import 'package:makeupstarstudio/core/common/navbar/menu_drawer.dart';
import 'package:makeupstarstudio/core/common/navbar/top_bar_contents.dart';
import 'package:makeupstarstudio/features/home/components/footer.dart';
import 'package:makeupstarstudio/features/home/components/info.dart';
import 'package:makeupstarstudio/features/home/components/subscribe.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/services/components/header_content_of_service.dart';
import 'package:makeupstarstudio/features/services/components/bridal_service.dart';
import 'package:makeupstarstudio/features/services/components/henna_service.dart';
import 'package:makeupstarstudio/features/services/components/non_bridal_hair_service.dart';
import 'package:makeupstarstudio/features/services/components/non_bridal_makeup_service.dart';
import 'package:makeupstarstudio/features/services/components/saree_drapping_service.dart';
import 'package:makeupstarstudio/features/services/components/service_header.dart';
import 'package:makeupstarstudio/features/services/components/service_text.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

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
          ServiceHeaderSection(),
          ServiceTextSection(),
          SizedBox(height: 40.0),
          HeaderContentSection(
            title: 'Birdal Services',
            subTitle: 'for your big day',
          ),
          SizedBox(height: 20.0),
          BridalServiceSection(),
          SizedBox(height: 40.0),
          HeaderContentSection(
            title: 'Non Bridal Makeup Services',
            subTitle: 'makeup application',
          ),
          SizedBox(height: 20.0),
          NonBridalMakeupServiceSection(),
          SizedBox(height: 40.0),
          HeaderContentSection(
            title: 'Non Bridal Hair Services',
            subTitle: 'elevate hairstyle',
          ),
          SizedBox(height: 20.0),
          NonBridalHairServiceSection(),
          SizedBox(height: 40.0),
          HeaderContentSection(
            title: 'Henna Services',
            subTitle: 'cultural elegance',
          ),
          SizedBox(height: 20.0),
          HennaServiceSection(),
          SizedBox(height: 40.0),
          HeaderContentSection(
            title: 'Saree Drapping Services',
            subTitle: 'elegant styling',
          ),
          SizedBox(height: 20.0),
          SareeDrappingServiceSection(),
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
