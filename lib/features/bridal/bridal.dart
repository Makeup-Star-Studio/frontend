import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/navbar/menu_drawer.dart';
import 'package:makeupstarstudio/core/common/navbar/top_bar_contents.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/features/bridal/components/bridal_gallery.dart';
import 'package:makeupstarstudio/features/bridal/components/bridal_header_content.dart';
import 'package:makeupstarstudio/features/bridal/components/bridal_text.dart';
import 'package:makeupstarstudio/features/home/components/footer.dart';
import 'package:makeupstarstudio/features/home/components/info.dart';
import 'package:makeupstarstudio/features/home/components/subscribe.dart';

class BridalPage extends StatelessWidget {
  const BridalPage({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            BridalHeaderSection(),
            const BridalTextSection(),
            const SizedBox(height: 20.0),
            const Center(
              child: BodyText(
                text: '"Click on the images to view full size"',
                color: AppColorConstant.errorColor,
                size: 22.0,
                smallSize: 20.0,
                mediumSize: 20.0,
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [BridalGallery()],
            ),
            const SizedBox(height: 20.0),
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
