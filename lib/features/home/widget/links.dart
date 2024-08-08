import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class Links extends StatefulWidget {
  const Links({super.key});

  @override
  State<Links> createState() => _LinksState();
}

class _LinksState extends State<Links> {
  bool _isHoveringGoogle = false;
  bool _isHoveringYelp = false;
  bool _isHoveringFacebook = false;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return Row(
        children: [
          _buildLink(
            onHover: (isHovering) {
              setState(() {
                _isHoveringGoogle = isHovering;
              });
            },
            isHovering: _isHoveringGoogle,
            onTap: () => launchUrl(
                'https://www.google.com/search?q=makeup+star+studio+google+reviews&oq=makeup+star+studio+google+reviews&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORigAdIBCDY3MzFqMGo3qAIIsAIB&sourceid=chrome&ie=UTF-8#lrd=0x808fc97cb59a6a31:0xd75d72a6d64c7eb4,1,,,,'), // Replace with your google review URL
            iconPath:
                'assets/icons/review.png', // Change to the actual path of Google Review icon
            text: 'Google Reviews',
          ),
          const SizedBox(height: 10.0),
          _buildLink(
            onHover: (isHovering) {
              setState(() {
                _isHoveringYelp = isHovering;
              });
            },
            isHovering: _isHoveringYelp,
            onTap: () => launchUrl(
                'https://www.yelp.com/biz/makeupstarstudio-san-jose'), // Replace with your Yelp review URL
            iconPath:
                'assets/icons/yelp.png', // Change to the actual path of Yelp icon
            text: 'Yelp Reviews',
          ),
          const SizedBox(height: 10.0),
          _buildLink(
            onHover: (isHovering) {
              setState(() {
                _isHoveringFacebook = isHovering;
              });
            },
            isHovering: _isHoveringFacebook,
            onTap: () => launchUrl(
                'https://www.facebook.com/BayAreaHennaMehndi/reviews'), // Replace with your Facebook review URL
            iconPath:
                'assets/icons/facebook1.png', // Change to the actual path of Facebook icon
            text: 'Facebook Reviews',
          ),
        ],
      );
    }
    if (ResponsiveWidget.isSmallScreen(context)) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildLink(
                onHover: (isHovering) {
                  setState(() {
                    _isHoveringGoogle = isHovering;
                  });
                },
                isHovering: _isHoveringGoogle,
                onTap: () => launchUrl(
                    'https://www.google.com/search?q=makeup+star+studio+google+reviews&oq=makeup+star+studio+google+reviews&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORigAdIBCDY3MzFqMGo3qAIIsAIB&sourceid=chrome&ie=UTF-8#lrd=0x808fc97cb59a6a31:0xd75d72a6d64c7eb4,1,,,,'), // Replace with your google review URL
                iconPath:
                    'assets/icons/review.png', // Change to the actual path of Google Review icon
                text: 'Google Reviews',
              ),
              _buildLink(
                onHover: (isHovering) {
                  setState(() {
                    _isHoveringYelp = isHovering;
                  });
                },
                isHovering: _isHoveringYelp,
                onTap: () => launchUrl(
                    'https://www.yelp.com/biz/makeupstarstudio-san-jose'), // Replace with your Yelp review URL
                iconPath:
                    'assets/icons/yelp.png', // Change to the actual path of Yelp icon
                text: 'Yelp Reviews',
              ),
            ],
          ),
          _buildLink(
            onHover: (isHovering) {
              setState(() {
                _isHoveringFacebook = isHovering;
              });
            },
            isHovering: _isHoveringFacebook,
            onTap: () => launchUrl(
                'https://www.facebook.com/BayAreaHennaMehndi/reviews'), // Replace with your Facebook review URL
            iconPath:
                'assets/icons/facebook1.png', // Change to the actual path of Facebook icon
            text: 'Facebook Reviews',
          ),
        ],
      );
    }
    // Add a default return statement
    return Container();
  }

  Widget _buildLink({
    required void Function(bool) onHover,
    required bool isHovering,
    required VoidCallback onTap,
    required String iconPath,
    required String text,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                iconPath,
                fit: BoxFit.contain,
                color: AppColorConstant.black,
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 10.0),
              Text(
                text,
                style: TextStyle(
                  color: isHovering
                      ? AppColorConstant.errorColor
                      : AppColorConstant.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  decoration: isHovering
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
