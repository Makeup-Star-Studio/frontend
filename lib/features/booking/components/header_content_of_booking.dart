import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
import 'package:url_launcher/url_launcher.dart';

class HeaderContentBookingSection extends StatefulWidget {
  final String title;
  final String subTitle;

  const HeaderContentBookingSection({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  State<HeaderContentBookingSection> createState() =>
      _HeaderContentBookingSectionState();
}

class _HeaderContentBookingSectionState
    extends State<HeaderContentBookingSection> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ResponsiveWidget.isSmallScreen(context)
          ? AppColorConstant.bgColor
          : AppColorConstant.backgroundColor,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(
            ResponsiveWidget.isSmallScreen(context) ? 16.0 : 0.0),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BigText(
                    text: widget.title,
                    height: 1.0,
                    size: 30.0,
                    smallSize: 22.0,
                    letterSpacing: 3.0,
                  ),
                  SubHeadingSlanted(
                    height: 1.0,
                    size: 60.0,
                    smallSize: 45.0,
                    text: widget.subTitle,
                  ),
                ],
              ),
            ),
            if (!ResponsiveWidget.isSmallScreen(context))
              Align(
                alignment: Alignment.topRight,
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovering = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovering = false;
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      launchWhatsApp();
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: ResponsiveWidget.isSmallScreen(context) ? 80 : 180,
                      height: ResponsiveWidget.isSmallScreen(context) ? 50 : 65,
                      decoration: const BoxDecoration(
                        color: AppColorConstant.successColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100.0),
                          bottomLeft: Radius.circular(100.0),
                        ),
                      ),
                      transform: _isHovering
                          ? Matrix4.diagonal3Values(1.1, 1.1, 1)
                          : Matrix4.diagonal3Values(1, 1, 1),
                      child: Image.asset(
                        'assets/icons/whatsapp.png', // Change to the actual path of WhatsApp logo
                        fit: BoxFit.contain,
                        width:
                            ResponsiveWidget.isSmallScreen(context) ? 30 : 40,
                        height:
                            ResponsiveWidget.isSmallScreen(context) ? 30 : 40,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void launchWhatsApp() async {
    const url =
        'https://wa.me/14156960258'; // Replace with your WhatsApp number
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
