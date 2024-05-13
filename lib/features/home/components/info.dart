import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(screenSize),
      mediumScreen: _buildMediumScreen(screenSize),
      smallScreen: _buildSmallScreen(screenSize),
    );
  }

  // large screen
  Widget _buildLargeScreen(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRect(
                  child: Image.asset(
                    'assets/images/logo-black.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                const BodyText(
                  textAlign: TextAlign.start,
                  text:
                      'Makeup Star Studio is a team of talented beauty professionals providing luxury on-site beauty services while elevating your beauty and confidence. Serving Bay Area, San Francisco & beyond.',
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    _buildSocialMediaIcon(
                      'assets/icons/facebook.png',
                      'https://www.facebook.com/share/nKqoKmAsqthiRJSo/?mibextid=LQQJ4d',
                    ),
                    const SizedBox(width: 10.0),
                    _buildSocialMediaIcon(
                      'assets/icons/instagram.png',
                      'https://www.instagram.com/__ayusha16?igsh=eGR6aGM2aXh1amF6&utm_source=qr',
                    ),
                    const SizedBox(width: 10.0),
                    _buildSocialMediaIcon(
                      'assets/icons/whatsapp.png',
                      'https://wa.link/yoty74',
                    ),
                    const SizedBox(width: 10.0),
                    _buildSocialMediaIcon(
                      'assets/icons/youtube.png',
                      'https://www.youtube.com/channel/UC-xQSuEvPEAwgpSJKDXLQfw',
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 300, // Adjust the width as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildListTile(
                  icon: Icons.call_outlined,
                  title: 'Have Questions?',
                  subtitle: 'Call us at +1 415-696-0258',
                ),
                _buildListTile(
                  icon: Icons.location_on_outlined,
                  title: 'Location',
                  subtitle: 'San Jose, California & beyond',
                ),
                _buildListTile(
                  icon: Icons.calendar_today_outlined,
                  title: 'Business Hours',
                  subtitle: 'Open 24 Hours Daily',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // medium screen
  Widget _buildMediumScreen(Size screenSize) {
    return _buildLargeScreen(screenSize); // Just using large screen layout
  }

  // small screen
  Widget _buildSmallScreen(Size screenSize) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRect(
            child: Image.asset(
              'assets/images/logo-black.png',
              width: 100,
              height: 100,
            ),
          ),
          const BodyText(
            // textAlign: TextAlign.start,
            text:
                'Makeup Star Studio is a team of talented beauty professionals providing luxury on-site beauty services while elevating your beauty and confidence. Serving Bay Area, San Francisco & beyond.',
          ),
          const SizedBox(height: 10.0),
          Column(
            children: [
              _buildListTile(
                icon: Icons.call_outlined,
                title: 'Have Questions?',
                subtitle: 'Call us at +1 415-696-0258',
              ),
              _buildListTile(
                icon: Icons.location_on_outlined,
                title: 'Location',
                subtitle: 'San Jose, California & beyond',
              ),
              _buildListTile(
                icon: Icons.calendar_today_outlined,
                title: 'Business Hours',
                subtitle: 'Open 24 Hours Daily',
              ),
            ],
          ),
          const SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialMediaIcon(
                'assets/icons/facebook.png',
                'https://www.facebook.com/share/nKqoKmAsqthiRJSo/?mibextid=LQQJ4d',
              ),
              const SizedBox(width: 10.0),
              _buildSocialMediaIcon(
                'assets/icons/instagram.png',
                'https://www.instagram.com/__ayusha16?igsh=eGR6aGM2aXh1amF6&utm_source=qr',
              ),
              const SizedBox(width: 10.0),
              _buildSocialMediaIcon(
                'assets/icons/whatsapp.png',
                'https://wa.link/yoty74',
              ),
              const SizedBox(width: 10.0),
              _buildSocialMediaIcon(
                'assets/icons/youtube.png',
                'https://www.youtube.com/channel/UC-xQSuEvPEAwgpSJKDXLQfw',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
      {IconData? icon, required String title, required String subtitle}) {
    return ListTile(
      mouseCursor: MaterialStateMouseCursor.textable,
      hoverColor: Colors.transparent,
      leading: Icon(icon),
      title: BodyText(
        textAlign: TextAlign.start,
        text: title,
        size: 16.0,
        fontWeight: FontWeight.bold,
      ),
      subtitle: BodyText(textAlign: TextAlign.start, text: subtitle),
      onTap: () {
        // Handle onTap action here
      },
    );
  }

  Widget _buildSocialMediaIcon(String iconPath, String url) {
    return InkWell(
      onTap: () {
        _launchURL(url);
      },
      child: Image.asset(
        iconPath,
        width: 30,
        height: 30,
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      throw 'Could not launch $url';
    }
  }
}
