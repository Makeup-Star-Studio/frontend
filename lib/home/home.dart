import 'package:flutter/material.dart';
import 'package:makeupstarstudio/theme/color.dart';
import 'package:makeupstarstudio/home/widget/about.dart';
import 'package:makeupstarstudio/home/widget/menu_drawer.dart';
import 'package:makeupstarstudio/home/widget/top_bar_contents.dart';
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.15, vertical: 50.0),
          child: Column(
            children: [AboutSection()],
          ),
        ),
      ),
    );
  }
}
