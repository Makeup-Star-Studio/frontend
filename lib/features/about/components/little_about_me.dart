import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/src/provider/admin/user_provider.dart';
import 'package:provider/provider.dart';

class LittleAboutMeSection extends StatefulWidget {
  const LittleAboutMeSection({super.key});

  @override
  State<LittleAboutMeSection> createState() => _LittleAboutMeSectionState();
}

class _LittleAboutMeSectionState extends State<LittleAboutMeSection> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserInfo();
    });
  }

  Future<void> _fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(context),
      mediumScreen: _buildMediumScreen(screenSize, context),
      smallScreen: _buildSmallScreen(screenSize, context),
    );
  }

  // Large Screen
  Widget _buildLargeScreen(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        if (userProvider.isLoading) {
          return const CircularProgressIndicator();
        } else {
          final userProvider = Provider.of<UserProvider>(context);
          final userModel = userProvider.user;

          // Debugging: Print the user data
          // print('UserModel data: $userModel');

          if (userModel == null) {
            return const Center(child: Text("No User Found"));
          }

          final user = userModel.data.admin;
          return Container(
            color: AppColorConstant.bgColor,
            padding: const EdgeInsets.only(left: 50),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const BigText(
                        textAlign: TextAlign.start,
                        text: 'Little More About Geet',
                        // height: 84 / 50,
                      ),
                      // ListTile(
                      //   leading: Icon(Icons.star_border_outlined,
                      //       color: AppColorConstant.secondaryColor),
                      //   title: BodyText(
                      //     textAlign: TextAlign.start,
                      //     text:
                      //         "Apart from being a certified makeup artist, hair stylist & heena artist, Geet is also a technical recruiter.",
                      //     // size: 16.0,
                      //   ),
                      // ),
                      ListTile(
                        leading: const Icon(Icons.star_border_outlined,
                            color: AppColorConstant.secondaryColor),
                        title: BodyText(
                          textAlign: TextAlign.start,
                          text: user.bio!.isNotEmpty
                              ? user.bio!
                              : "When she is not serving clients, Geet can be found exercising and walking around Santa Cruz beach. \n She enjoys a good read in her local library and also loves to binge watch Netflix series.",
                          // size: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20.0),
                ClipRect(
                  child: user.imageUrl!.isNotEmpty
                      ? Image.network(
                          'https://makeup-star-studio.sfo2.digitaloceanspaces.com/admin/${user.imageUrl}',
                          width: 700.0,
                          height: 500.0,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/profile.jpg',
                          width: 700.0,
                          height: 500.0,
                          fit: BoxFit.cover,
                        ),
                ),
              ],
            ),
          );
        }
      },
    );
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
          final userProvider = Provider.of<UserProvider>(context);
          final userModel = userProvider.user;

          // Debugging: Print the user data
          // print('UserModel data: $userModel');

          if (userModel == null) {
            return const Center(child: Text("No User Found"));
          }

          final user = userModel.data.admin;
          return Container(
            color: AppColorConstant.bgColor,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const BigText(
                  // textAlign: TextAlign.start,
                  text: 'Little More About Geet',
                  // height: 84 / 50,
                ),
                const SizedBox(height: 20.0),
                ClipRect(
                  child: user.imageUrl!.isNotEmpty
                      ? Image.network(
                          'https://makeup-star-studio.sfo2.digitaloceanspaces.com/admin/${user.imageUrl}',
                          width: screenSize.width,
                          height: screenSize.height,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/profile.jpg',
                          width: screenSize.width,
                          height: screenSize.height,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  leading: const Icon(Icons.star_border_outlined,
                      color: AppColorConstant.secondaryColor),
                  title: BodyText(
                    textAlign: TextAlign.start,
                    text: user.bio!.isNotEmpty
                        ? user.bio!
                        : "Apart from being a certified makeup artist, hair stylist & heena artist, Geet is also a technical recruiter.",
                    // size: 16.0,
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
          );
        }
      },
    );
  }
}
