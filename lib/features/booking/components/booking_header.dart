// import 'package:flutter/material.dart';
// import 'package:makeupstarstudio/config/constants/color.dart';
// import 'package:makeupstarstudio/config/constants/responsive.dart';
// import 'package:makeupstarstudio/config/router/website_route.dart';
// import 'package:makeupstarstudio/core/common/text/body.dart';
// import 'package:makeupstarstudio/core/common/text/button_card.dart';
// import 'package:makeupstarstudio/core/common/text/heading.dart';
// import 'package:makeupstarstudio/src/provider/images/random_images_provider.dart';
// import 'package:provider/provider.dart';

// class BookingHeaderSection extends StatefulWidget {
//   const BookingHeaderSection({super.key});

//   @override
//   State<BookingHeaderSection> createState() => _BookingHeaderSectionState();
// }

// class _BookingHeaderSectionState extends State<BookingHeaderSection> {
// @override
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
//       largeScreen: _buildLargeScreen(screenSize, context),
//       mediumScreen: _buildMediumScreen(screenSize, context),
//       smallScreen: _buildSmallScreen(screenSize, context),
//     );
//   }

//   // Large Screen
//   Widget _buildLargeScreen(Size screenSize, BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//       return Consumer<RandomImageProvider>(
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
//             return Container(
//       width: double.infinity,
//       height: screenSize.height,
//       color: AppColorConstant.backgroundColor,
//       // padding: const EdgeInsets.only(left: 50),
//       child: Row(
//         children: [
//           Expanded(
//             child: Padding(
//               padding:
//                   EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const BigText(
//                     text: 'in need of a beauty team asap?',
//                     color: AppColorConstant.secondaryColor,
//                     height: 1.0,
//                     // height: 84 / 50,
//                   ),
//                   const SizedBox(height: 40.0),
//                   const BodyText(
//                     text:
//                         "WE'RE YOUR GO-TO GIRLS TO HELP YOU FEEL & LOOK YOUR MOST BEAUTIFUL.",
//                     size: 16.0,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   const SizedBox(height: 20.0),
//                   const BodyText(
//                     text:
//                         "Thank you so much for your consideration in working with the Makeup Star Studio Beauty Team! In need of a beauty team? Use the link below to instantly book one of our professional beauty stylists! For all Bridal & Event Inquiries, please use this booking form below to get in touch with us, and we'll get back to you shortly! ",
//                   ),
//                   const SizedBox(height: 20.0),
//                   ButtonCard(
//                     press: () {},
//                     text: 'BOOK AN APPOINTMENT',
//                   ),
//                   const SizedBox(height: 20.0),
//                   ButtonCard(
//                     press: () {
//                       Navigator.pushNamed(context, WebsiteRoute.aboutRoute);
//                     },
//                     text: 'ABOUT US',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 20.0),
//           Expanded(
//             child: ClipRect(
//               child: image.isNotEmpty
//                   ? Image.network(
//                       image[3].url,
//                       fit: BoxFit.cover,
//                       height: screenSize.height,
//                     )
//                   :
//               Image.asset(
//                 'assets/images/image.webp',
//                 // width: 500.0,
//                 // height: 500.0,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//           } else {
//             return const Text('Not enough images available');
//           }
//   }
//       },
//     );
//   }

//   // medium screen
//   Widget _buildMediumScreen(Size screenSize, BuildContext context) {
//     return _buildLargeScreen(
//         screenSize, context); // Just using large screen layout for medium
//   }

//   // small screen
//   Widget _buildSmallScreen(Size screenSize, BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//       return Consumer<RandomImageProvider>(
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
//       padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ClipRect(
//             child: image.isNotEmpty
//                 ? Image.network(
//                     image[3].url,
//                     width: screenSize.width,
//                     height: screenSize.height * 0.75,
//                     fit: BoxFit.cover,
//                   )
//                 :
//             Image.asset(
//               'assets/images/image.webp',
//               width: screenSize.width,
//               height: screenSize.height * 0.75,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(height: 20.0),
//           const BigText(
//             text: 'in need of a beauty team asap?',
//             color: AppColorConstant.secondaryColor,
//             height: 1.0,
//             // height: 84 / 50,
//           ),
//           // const SizedBox(height: 20.0),
//           const BodyText(
//             text:
//                 '"WE\'RE YOUR GO-TO GIRLS TO HELP YOU FEEL & LOOK YOUR MOST BEAUTIFUL."',
//             // smallSize: 16.0,
//             // fontWeight: FontWeight.w600,
//             letterSpacing: 1.5,
//           ),
//           const SizedBox(height: 20.0),
//           const BodyText(
//             text:
//                 "Thank you so much for your consideration in working with the Makeup Star Studio Beauty Team! In need of a beauty team? Use the link below to instantly book one of our professional beauty stylists! For all Bridal & Event Inquiries, please use this booking form below to get in touch with us, and we'll get back to you shortly! ",
//           ),
//           const SizedBox(height: 20.0),
//           ButtonCard(
//             press: () {},
//             text: 'BOOK AN APPOINTMENT',
//           ),
//           const SizedBox(height: 20.0),
//           ButtonCard(
//             press: () {
//               // Navigator.pushNamed(context, WebsiteRoute.contactRoute);
//             },
//             text: 'CONTACT US',
//           ),
//         ],
//       ),
//     );
//     } else {
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
import 'package:makeupstarstudio/core/common/text/button_card.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';

class BookingHeaderSection extends StatelessWidget {
  const BookingHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(screenSize, context),
      mediumScreen: _buildMediumScreen(screenSize, context),
      smallScreen: _buildSmallScreen(screenSize, context),
    );
  }

  // Large Screen
  Widget _buildLargeScreen(Size screenSize, BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: screenSize.height,
      color: AppColorConstant.backgroundColor,
      // padding: const EdgeInsets.only(left: 50),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BigText(
                    text: 'in need of a beauty team asap?',
                    color: AppColorConstant.secondaryColor,
                    height: 1.0,
                    // height: 84 / 50,
                  ),
                  const SizedBox(height: 40.0),
                  const BodyText(
                    text:
                        "WE'RE YOUR GO-TO GIRLS TO HELP YOU FEEL & LOOK YOUR MOST BEAUTIFUL.",
                    size: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 20.0),
                  const BodyText(
                    text:
                        "Thank you so much for your consideration in working with the Makeup Star Studio Beauty Team! In need of a beauty team? Use the link below to instantly book one of our professional beauty stylists! For all Bridal & Event Inquiries, please use this booking form below to get in touch with us, and we'll get back to you shortly! ",
                  ),
                  const SizedBox(height: 20.0),
                  ButtonCard(
                    press: () {},
                    text: 'BOOK AN APPOINTMENT',
                  ),
                  const SizedBox(height: 20.0),
                  ButtonCard(
                    press: () {
                      Navigator.pushNamed(context, WebsiteRoute.aboutRoute);
                    },
                    text: 'ABOUT US',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: ClipRect(
              child: Image.asset(
                'assets/images/booknow.webp',
                // width: 500.0,
                // height: 500.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // medium screen
  Widget _buildMediumScreen(Size screenSize, BuildContext context) {
    return _buildLargeScreen(
        screenSize, context); // Just using large screen layout for medium
  }

  // small screen
  Widget _buildSmallScreen(Size screenSize, BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRect(
            child: Image.asset(
              'assets/images/booknow.webp',
              width: screenSize.width,
              height: screenSize.height * 0.75,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20.0),
          const BigText(
            text: 'in need of a beauty team asap?',
            color: AppColorConstant.secondaryColor,
            height: 1.0,
            // height: 84 / 50,
          ),
          // const SizedBox(height: 20.0),
          const BodyText(
            text:
                '"WE\'RE YOUR GO-TO GIRLS TO HELP YOU FEEL & LOOK YOUR MOST BEAUTIFUL."',
            // smallSize: 16.0,
            // fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
          const SizedBox(height: 20.0),
          const BodyText(
            text:
                "Thank you so much for your consideration in working with the Makeup Star Studio Beauty Team! In need of a beauty team? Use the link below to instantly book one of our professional beauty stylists! For all Bridal & Event Inquiries, please use this booking form below to get in touch with us, and we'll get back to you shortly! ",
          ),
          const SizedBox(height: 20.0),
          ButtonCard(
            press: () {},
            text: 'BOOK AN APPOINTMENT',
          ),
          const SizedBox(height: 20.0),
          ButtonCard(
            press: () {
              // Navigator.pushNamed(context, WebsiteRoute.contactRoute);
            },
            text: 'CONTACT US',
          ),
        ],
      ),
    );
  }
}
