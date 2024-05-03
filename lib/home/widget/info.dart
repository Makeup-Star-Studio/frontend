import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:makeupstarstudio/common/button.dart';
import 'package:makeupstarstudio/common/text/body.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
                      'Makeup Star Studio is a team of talented beauty professionals providing luxury on site beauty services while elevating your beauty and confidence. Serving Bay Area, San Francisco & beyond.',
                ),
                const SizedBox(height: 10.0),
                ModifiedButton(
                  press: () {
                    // Add your book online URL here
                  },
                  text: 'Book Online',
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BodyText(text: 'Social Media', size: 20.0),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  _buildSocialMediaIcon(
                    'assets/icons/facebook.png',
                    'https://www.facebook.com/your_profile',
                  ),
                  const SizedBox(width: 10.0),
                  _buildSocialMediaIcon(
                    'assets/icons/instagram.png',
                    'https://www.instagram.com/__ayusha16/',
                  ),
                  const SizedBox(width: 10.0),
                  _buildSocialMediaIcon(
                    'assets/icons/whatsapp.png',
                    'https://wa.me/your_phone_number',
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
        ],
      ),
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
