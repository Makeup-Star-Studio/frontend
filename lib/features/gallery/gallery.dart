import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/navbar/menu_drawer.dart';
import 'package:makeupstarstudio/core/common/navbar/top_bar_contents.dart';
import 'package:makeupstarstudio/features/gallery/components/gallery_header_content.dart';
import 'package:makeupstarstudio/features/gallery/components/henna_gallery.dart';
import 'package:makeupstarstudio/features/gallery/components/non_bridal_gallery.dart';
import 'package:makeupstarstudio/features/gallery/components/white_bride_gallery.dart';
import 'package:makeupstarstudio/features/gallery/widget/heading_gallery.dart';
import 'package:makeupstarstudio/features/home/components/footer.dart';
import 'package:makeupstarstudio/features/home/components/info.dart';
import 'package:makeupstarstudio/features/home/components/subscribe.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GalleryHeaderSection(),
            const SizedBox(height: 20.0),
            const HeadingGalleryOptions(text: 'Henna Gallery'),
            SizedBox(
                height: ResponsiveWidget.isSmallScreen(context) ? 10.0 : 20.0),
            const HennaGallery(),
            const SizedBox(height: 40.0),
            const HeadingGalleryOptions(text: 'American Traditional Bride Gallery'),
            SizedBox(
                height: ResponsiveWidget.isSmallScreen(context) ? 10.0 : 20.0),
            const WhiteBrideGallery(),
            const SizedBox(height: 40.0),
            const HeadingGalleryOptions(text: 'Non Bridal Gallery'),
            SizedBox(
                height: ResponsiveWidget.isSmallScreen(context) ? 10.0 : 20.0),
            const NonBridalGallery(),
            // GallerySlide4(),
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
