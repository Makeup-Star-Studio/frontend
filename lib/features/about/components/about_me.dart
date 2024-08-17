import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/src/provider/admin/user_provider.dart';
import 'package:provider/provider.dart';

class AboutMeSection extends StatefulWidget {
  const AboutMeSection({super.key});

  @override
  State<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends State<AboutMeSection> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).fetchUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(screenSize, context),
      mediumScreen: _buildMediumScreen(screenSize, context),
      smallScreen: _buildSmallScreen(screenSize, context),
    );
  }

  // large screen
  Widget _buildLargeScreen(Size screenSize, BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      final userModel = userProvider.user;

      // Debugging: Print the user data
      // print('UserModel data: $userModel');

      if (userModel == null) {
        return const Center(child: Text("No User Found"));
      }

      final user = userModel.data.admin;
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.1, vertical: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
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
              child: ClipRect(
                child: user.imageUrl.isNotEmpty
                    ? Image.network(
                        'https://makeup-star-studio.sfo2.digitaloceanspaces.com/admin/${user.imageUrl}',
                        fit: BoxFit.cover,
                        // width: 500.0,
                        // height: 500.0,
                      )
                    : Image.asset(
                        'assets/images/profile.jpg',
                        fit: BoxFit.cover,
                        // width: 500.0,
                        // height: 500.0,
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
                    size: 45.0,
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
                          text: "10 years ",
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
                          text:
                              "Trained by renowned artists such as  ",
                        ),
                        TextSpan(
                          text:
                              "BlueRoseArtistry, Dress Your Face, and Pink Orchid Studio, ",
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
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'Questrial',
                        height: 1.75,
                        fontSize: 16.0,
                      ),
                      children: [
                        TextSpan(
                          text:
                              "I love uplifting women, empowering them to feel their best and I'm so passionate about helping other women be successful and live a life by design. Geet uses an extensive kit of high-end products and tools including these brands: ",
                        ),
                        TextSpan(
                          text:
                              "Armani, Anastasia Beverly Hills, Bobbie Brown, Channel, Dior, Dolce and Gabbana, MAC, NARS, Urban Decay, YSL, Organic Henna and so on. ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              "We prioritize our clients' satisfaction above all else, ensuring they are delighted with flawless makeup that enhances their confidence and beauty.",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ModifiedButton(
                    press: () {
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
    });
  }

  // medium screen
  Widget _buildMediumScreen(Size screenSize, BuildContext context) {
    return _buildSmallScreen(screenSize, context);
  }

  // small screen
  Widget _buildSmallScreen(Size screenSize, BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.isLoading) {
          return const CircularProgressIndicator();
        } else {
          final userModel = userProvider.user;

          // Debugging: Print the user data
          // print('UserModel data: $userModel');

          if (userModel == null) {
            return const Center(child: Text("No User Found"));
          }

          final user = userModel.data.admin;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BigText(
                  text: 'MAKEUP STAR STUDIO',
                  color: AppColorConstant.secondaryColor,
                ),
                const SizedBox(height: 20.0),
                Container(
                  width: ResponsiveWidget.isSmallScreen(context)
                      ? screenSize.width
                      : 500.0,
                  height: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
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
                  child: ClipRect(
                    child: user.imageUrl.isNotEmpty
                        ? Image.network(
                            'https://makeup-star-studio.sfo2.digitaloceanspaces.com/admin/${user.imageUrl}',
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/profile.jpg',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 20.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Questrial',
                      color: AppColorConstant.black,
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
                        text: "10 years ",
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
                      color: AppColorConstant.black,
                      height: 1.75,
                      fontSize: 16.0,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "Trained by renowned artists such as  ",
                      ),
                      TextSpan(
                        text:
                            "BlueRoseArtistry, Dress Your Face, and Pink Orchid Studio, ",
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
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: 'Questrial',
                      color: AppColorConstant.black,
                      height: 1.75,
                      fontSize: 16.0,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "I love uplifting women, empowering them to feel their best and I'm so passionate about helping other women be successful and live a life by design. Geet uses an extensive kit of high-end products and tools including these brands: ",
                      ),
                      TextSpan(
                        text:
                            "Armani, Anastasia Beverly Hills, Bobbie Brown, Channel, Dior, Dolce and Gabbana, MAC, NARS, Urban Decay, YSL, Organic Henna and so on. ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text:
                            "We prioritize our clients' satisfaction above all else, ensuring they are delighted with flawless makeup that enhances their confidence and beauty.",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                ModifiedButton(
                  press: () {
                    Navigator.pushNamed(context, WebsiteRoute.bookRoute);
                  },
                  text: 'BOOK APPOINTMENT',
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
