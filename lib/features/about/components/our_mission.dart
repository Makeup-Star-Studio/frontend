// import 'package:flutter/material.dart';
// import 'package:makeupstarstudio/config/constants/color.dart';
// import 'package:makeupstarstudio/config/constants/responsive.dart';
// import 'package:makeupstarstudio/config/router/website_route.dart';
// import 'package:makeupstarstudio/core/common/text/body.dart';
// import 'package:makeupstarstudio/core/common/text/button.dart';
// import 'package:makeupstarstudio/core/common/text/heading.dart';
// import 'package:makeupstarstudio/core/common/text/sub_heading_normal.dart';
// import 'package:makeupstarstudio/src/provider/images/random_images_provider.dart';
// import 'package:provider/provider.dart';

// class AboutMissionSection extends StatefulWidget {
//   const AboutMissionSection({super.key});

//   @override
//   State<AboutMissionSection> createState() => _AboutMissionSectionState();
// }

// class _AboutMissionSectionState extends State<AboutMissionSection> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<RandomImageProvider>(context, listen: false).fetchAllImages();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     return ResponsiveWidget(
//       largeScreen: _buildLargeScreen(context),
//       mediumScreen: _buildMediumScreen(screenSize, context),
//       smallScreen: _buildSmallScreen(screenSize, context),
//     );
//   }

//   // large screen
//   Widget _buildLargeScreen(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Consumer<RandomImageProvider>(
//       builder: (context, imageProvider, child) {
//         if (imageProvider.isLoading) {
//           return const CircularProgressIndicator();
//         } else if (imageProvider.images.isEmpty) {
//           return const Text('No Data');
//         } else {
//           // Ensure you are accessing a valid index
//           const imageIndex = 6; // Index you want to access
//           if (imageProvider.images.length > imageIndex) {
//             final image = imageProvider.images;
//             return Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: screenSize.width * 0.1, vertical: 50.0),
//               child: Row(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     height: 300,
//                     decoration: BoxDecoration(
//                       shape:
//                           BoxShape.rectangle, // Making the box shape circular
//                       color: Colors.grey[200],
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 5.0,
//                           spreadRadius: 5.0,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: ClipRect(
//                       child: image.isNotEmpty
//                           ? Image.network(
//                               image[1].url,
//                               fit: BoxFit.cover,
//                             )
//                           : Image.asset(
//                               'assets/images/testimonial.webp',
//                               fit: BoxFit.cover,
//                             ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 50.0,
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const BigText(
//                           text: 'OUR MISSION',
//                           size: 50.0,
//                           height: 1.0,
//                           color: AppColorConstant.secondaryColor,
//                         ),
//                         const SubHeading(
//                           text: 'serving Bay Area & beyond',
//                           // height: 84/50,
//                           color: AppColorConstant.black,
//                         ),
//                         const BodyText(
//                           text:
//                               "Our goal is to empower individuals by enhancing their natural beauty through our expertise in makeup artistry, hair styling, henna art, and saree draping. We strive to create a memorable and transformative experience for each client, leaving them feeling confident, beautiful, and radiant on every occasion. With our collaborative efforts, we aim to make every client look and feel their absolute best, celebrating their unique beauty and style.\n We wanted to offer something that was convenient for the girl on the go, while giving you the luxury of having your own personal glam team. The best part? All of our services are delivered to you, exclusively on site only.",
//                           // size: 16.0,
//                         ),
//                         const SizedBox(height: 20.0),
//                         ModifiedButton(
//                           press: () {
//                             // Handle navigation here
//                             Navigator.pushNamed(
//                                 context, WebsiteRoute.bookRoute);
//                           },
//                           text: 'GET IN TOUCH',
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Text('Not enough images available');
//           }
//         }
//       },
//     );
//   }

//   // medium screen
//   Widget _buildMediumScreen(Size screenSize, BuildContext context) {
//     return _buildSmallScreen(
//         screenSize, context); // Just using large screen layout
//   }

//   // small screen
//   Widget _buildSmallScreen(Size screenSize, BuildContext context) {
//     return Consumer<RandomImageProvider>(
//       builder: (context, imageProvider, child) {
//         if (imageProvider.isLoading) {
//           return const CircularProgressIndicator();
//         } else if (imageProvider.images.isEmpty) {
//           return const Text('No Data');
//         } else {
//           // Ensure you are accessing a valid index
//           const imageIndex = 6; // Index you want to access
//           if (imageProvider.images.length > imageIndex) {
//             final image = imageProvider.images;
//             return Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const BigText(
//                     text: 'OUR MISSION',
//                     smallSize: 40.0,
//                     // size: 50.0,
//                     height: 1.0,
//                     color: AppColorConstant.secondaryColor,
//                   ),
//                   const SubHeading(
//                     text: 'serving Bay Area & beyond',
//                     // height: 84/50,
//                     height: 1.0,
//                     color: AppColorConstant.black,
//                   ),
//                   ClipRect(
//                     child: image.isNotEmpty
//                         ? Image.network(
//                             image[1].url,
//                             width: screenSize.width,
//                             height: ResponsiveWidget.isSmallScreen(context)
//                                 ? 300.0
//                                 : 500.0,
//                           )
//                         : Image.asset(
//                             'assets/images/testimonial.webp',
//                             width: screenSize.width,
//                             height: ResponsiveWidget.isSmallScreen(context)
//                                 ? 300.0
//                                 : 500.0,
//                           ),
//                   ),
//                   ResponsiveWidget.isSmallScreen(context)
//                       ? const SizedBox(height: 0.0)
//                       : const SizedBox(height: 20.0),
//                   const BodyText(
//                     text:
//                         "Our goal is to empower individuals by enhancing their natural beauty through our expertise in makeup artistry, hair styling, henna art, and saree draping. We strive to create a memorable and transformative experience for each client, leaving them feeling confident, beautiful, and radiant on every occasion. With our collaborative efforts, we aim to make every client look and feel their absolute best, celebrating their unique beauty and style.\n We wanted to offer something that was convenient for the girl on the go, while giving you the luxury of having your own personal glam team. The best part? All of our services are delivered to you, exclusively on site only.",
//                     // size: 16.0,
//                   ),
//                   const SizedBox(height: 20.0),
//                   ModifiedButton(
//                     press: () {
//                       // Handle navigation here
//                       Navigator.pushNamed(context, WebsiteRoute.bookRoute);
//                     },
//                     text: 'GET IN TOUCH',
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Text('Not enough images available');
//           }
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/config/router/website_route.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_normal.dart';

class AboutMissionSection extends StatelessWidget {
  const AboutMissionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(context),
      mediumScreen: _buildMediumScreen(screenSize, context),
      smallScreen: _buildSmallScreen(screenSize, context),
    );
  }

  // large screen
  Widget _buildLargeScreen(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.1, vertical: 50.0),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 300,
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
            child: ClipRect(
              child: Image.asset(
                'assets/images/about2.webp',
                fit: BoxFit.cover,
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
                  text: 'OUR MISSION',
                  size: 50.0,
                  height: 1.0,
                  color: AppColorConstant.secondaryColor,
                ),
                const SubHeading(
                  text: 'serving Bay Area & beyond',
                  // height: 84/50,
                  color: AppColorConstant.black,
                ),
                const BodyText(
                  text:
                      "Our goal is to empower individuals by enhancing their natural beauty through our expertise in makeup artistry, hair styling, henna art, and saree draping. We strive to create a memorable and transformative experience for each client, leaving them feeling confident, beautiful, and radiant on every occasion. With our collaborative efforts, we aim to make every client look and feel their absolute best, celebrating their unique beauty and style.\n We wanted to offer something that was convenient for the girl on the go, while giving you the luxury of having your own personal glam team. The best part? All of our services are delivered to you, exclusively on site only.",
                  // size: 16.0,
                ),
                const SizedBox(height: 20.0),
                ModifiedButton(
                  press: () {
                    // Handle navigation here
                    Navigator.pushNamed(context, WebsiteRoute.bookRoute);
                  },
                  text: 'GET IN TOUCH',
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // medium screen
  Widget _buildMediumScreen(Size screenSize, BuildContext context) {
    return _buildSmallScreen(
        screenSize, context); // Just using large screen layout
  }

  // small screen
  Widget _buildSmallScreen(Size screenSize, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BigText(
            text: 'OUR MISSION',
            smallSize: 40.0,
            // size: 50.0,
            height: 1.0,
            color: AppColorConstant.secondaryColor,
          ),
          const SubHeading(
            text: 'serving Bay Area & beyond',
            // height: 84/50,
            height: 1.0,
            color: AppColorConstant.black,
          ),
          ClipRect(
            child: Image.asset(
              'assets/images/about2.webp',
              width: screenSize.width,
              height: ResponsiveWidget.isSmallScreen(context) ? 300.0 : 500.0,
            ),
          ),
          ResponsiveWidget.isSmallScreen(context)
              ? const SizedBox(height: 0.0)
              : const SizedBox(height: 20.0),
          const BodyText(
            text:
                "Our goal is to empower individuals by enhancing their natural beauty through our expertise in makeup artistry, hair styling, henna art, and saree draping. We strive to create a memorable and transformative experience for each client, leaving them feeling confident, beautiful, and radiant on every occasion. With our collaborative efforts, we aim to make every client look and feel their absolute best, celebrating their unique beauty and style.\n We wanted to offer something that was convenient for the girl on the go, while giving you the luxury of having your own personal glam team. The best part? All of our services are delivered to you, exclusively on site only.",
            // size: 16.0,
          ),
          const SizedBox(height: 20.0),
          ModifiedButton(
            press: () {
              // Handle navigation here
              Navigator.pushNamed(context, WebsiteRoute.bookRoute);
            },
            text: 'GET IN TOUCH',
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }
}
