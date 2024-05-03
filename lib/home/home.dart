import 'package:flutter/material.dart';
import 'package:makeupstarstudio/home/widget/about.dart';
import 'package:makeupstarstudio/menu_drawer.dart';
import 'package:makeupstarstudio/responsive.dart';
import 'package:makeupstarstudio/top_bar_contents.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F7),
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: const Color(0xfffaf8f7),
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
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: const Column(
            children: [
              AboutSection()
            ],
          ),
        ),
      ),
    );
  }
}
