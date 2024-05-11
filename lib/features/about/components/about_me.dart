import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.1, vertical: 50.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 600,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle, // Making the box shape circular
              color: Colors.grey[200],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  spreadRadius: 5.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Expanded(
              flex: 1,
              child: ClipRect(
                child: Image.asset(
                  'assets/images/profile.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 50.0,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BigText(
                  text: 'MAKEUP STAR STUDIO',
                  size: 50.0,
                  // height: 84/50,
                  color: AppColorConstant.secondaryColor,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Questrial',
                      height: 1.75,
                      fontSize: 16.0,
                    ),
                    children: [
                      TextSpan(
                        text: "Geet",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            " is the Lead Artist of Makeup Star Studio! Geet provides bridal glam services for Bay Area's bridal beauties along with brides all over the world. Geet has been working in the beauty industry for over ",
                      ),
                      TextSpan(
                        text: "9 years ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            "as a freelance makeup artist. With lots of experience, she's skilled at makeup and styling for weddings, fashion shoots, maternity shoots, and other special occasions.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Questrial',
                      height: 1.75,
                      fontSize: 16.0,
                    ),
                    children: [
                      TextSpan(
                        text: "Geet, originally from India, spent the majority of her life in Seattle, USA. Her journey as a makeup artist began in Seattle, and four years ago, she relocated to the Bay Area. Trained by renowned artists such as  ",
                      ),
                      TextSpan(
                        text: "BlueRoseArtistry, Dress Your Face, and Pink Orchid Studio, ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            "she has transitioned into an entrepreneur and established 'Makeup Star Studio.' Together with her team, they offer a range of services including ",
                      ),
                      TextSpan(
                        text: "Makeup, Hair, Henna, and Saree Drapping ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "in the Bay Area and beyond.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Questrial',
                      height: 1.75,
                      fontSize: 16.0,
                    ),
                    children: [
                      TextSpan(
                        text: "I love uplifting women, empowering them to feel their best and I'm so passionate about helping other women be successful and live a life by design. Geet uses an extensive kit of high-end products and tools including these brands: ",
                      ),
                      TextSpan(
                        text: "Armani, Anastasia Beverly Hills, Bobbie Brown, Channel, Dior, Dolce and Gabbana, MAC, NARS, Urban Decay, YSL, Organic Henna and so on. ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "We prioritize our clients' satisfaction above all else, ensuring they are delighted with flawless makeup that enhances their confidence and beauty.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                ModifiedButton(
                  press: () {
                    // Handle navigation here
                    Navigator.pushNamed(context, WebsiteRoute.bookRoute);
                  },
                  text: 'BOOK APPOINTMENT',
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
