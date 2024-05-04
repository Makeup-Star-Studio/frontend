import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';

class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({super.key});

  @override
  _TopNavigationBarState createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black54,
            width: 1.0,
          ),
        ),
      ),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NavBarItem(title: 'About', index: 0),
            const NavBarItem(title: 'Services', index: 1),
            const NavBarItem(title: 'Bridal', index: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                hoverColor: Colors.transparent,
                onTap: () {
                  // Handle navigation here
                  Navigator.pushNamed(context, WebsiteRoute.homeRoute);
                },
                child: ClipRect(
                  child: Image.asset(
                    'assets/images/logo2.png',
                    width: 125,
                    height: 75,
                  ),
                ),
              ),
            ),
            const NavBarItem(title: 'Gallery', index: 3),
            const NavBarItem(title: 'Contact', index: 4),
            const NavBarItem(title: 'Book Now', index: 5),
          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final String title;
  final int index;
  const NavBarItem({
    super.key,
    required this.title,
    required this.index,
  });

  @override
  State<NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onHover: (value) {
          setState(() {
            _isHovering = value;
          });
        },
        onPressed: () {
          // Handle navigation here
        },
        child: BodyText(
          text: widget.title,
          letterSpacing: 2.0,
          size: 16.0,
          color: _isHovering ? AppColorConstant.secondaryColor : Colors.black,
          fontWeight: _isHovering ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}