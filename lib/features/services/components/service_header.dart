// import 'package:flutter/material.dart';
// import 'package:makeupstarstudio/config/constants/color.dart';
// import 'package:makeupstarstudio/config/constants/responsive.dart';
// import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
// import 'package:makeupstarstudio/src/provider/images/random_images_provider.dart';
// import 'package:provider/provider.dart';

// class ServiceHeaderSection extends StatefulWidget {
//   const ServiceHeaderSection({super.key});

//   @override
//   State<ServiceHeaderSection> createState() => _ServiceHeaderSectionState();
// }

// class _ServiceHeaderSectionState extends State<ServiceHeaderSection> {
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
//       largeScreen: _buildLargeScreen(screenSize, context),
//       mediumScreen: _buildMediumScreen(screenSize, context),
//       smallScreen: _buildSmallScreen(screenSize, context),
//     );
//   }

//   // large screen
//   Widget _buildLargeScreen(Size screenSize, BuildContext context) {
//     return Consumer<RandomImageProvider>(
//       builder: (context, imageProvider, child) {
//         if (imageProvider.isLoading) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (imageProvider.images.isEmpty) {
//           return const Center(child: Text('No Data'));
//         } else {
//           const imageIndex = 6; // Index you want to access
//           if (imageProvider.images.length > imageIndex) {
//             final image = imageProvider.images;
//             return SizedBox(
//               width: screenSize.width,
//               height: screenSize.height,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   FittedBox(
//                     fit: BoxFit.cover,
//                     child: Image.network(
//                       image.isEmpty
//                           ? 'assets/images/service_header.webp'
//                           : image[2].url,
//                       width: screenSize.width,
//                       height: screenSize.height,
//                     ),
//                   ),
//                   Container(
//                     color:
//                         Colors.black.withOpacity(0.5), // Overlay for contrast
//                   ),
//                   Positioned(
//                     top: 50.0,
//                     left: 50.0,
//                     right: 50.0,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         RichText(
//                           textAlign: TextAlign.center,
//                           text: const TextSpan(
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'Cradley',
//                                 height: 1.25,
//                                 fontSize:
//                                     60.0, // Increased font size for large screens
//                                 letterSpacing: 2.0),
//                             children: [
//                               TextSpan(text: "luxurious &\n"),
//                               TextSpan(text: "elevated"),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 20.0),
//                         const SubHeadingSlanted(
//                           text: 'beauty services',
//                           height: 1,
//                           size: 100, // Increased size for large screens
//                           color: AppColorConstant
//                               .white, // Adjust color for better visibility
//                         ),
//                         const SizedBox(height: 20.0),
//                         RichText(
//                           textAlign: TextAlign.center,
//                           text: const TextSpan(
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: 'Questrial',
//                               height: 1.75,
//                               fontSize:
//                                   24.0, // Increased font size for large screens
//                             ),
//                             children: [
//                               TextSpan(
//                                   text: "WE'RE YOUR GO-T0 GIRLS TO HELP YOU\n"),
//                               TextSpan(
//                                   text: "FEEL & LOOK YOUR BEST INSIDE & OUT!"),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Center(child: Text('Not enough images available'));
//           }
//         }
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
//     return Consumer<RandomImageProvider>(
//       builder: (context, imageProvider, child) {
//         if (imageProvider.isLoading) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (imageProvider.images.isEmpty) {
//           return const Center(child: Text('No Data'));
//         } else {
//           const imageIndex = 2; // Index you want to access
//           if (imageProvider.images.length > imageIndex) {
//             final image = imageProvider.images;
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20.0),
//               child: SizedBox(
//                 width: screenSize.width,
//                 height: screenSize.height * 0.5,
//                 child: FittedBox(
//                   fit: BoxFit.cover,
//                   child: Image.network(
//                     image.isNotEmpty
//                         ? image[2].url
//                         : 'assets/images/service_header.webp',
//                     width: screenSize.width,
//                     height: screenSize.height * 0.5,
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return const Center(child: Text('Not enough images available'));
//           }
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';

class ServiceHeaderSection extends StatelessWidget {
  const ServiceHeaderSection({super.key});

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
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            child: Image.network(
              'assets/images/services.webp',
              width: screenSize.width,
              height: screenSize.height,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Overlay for contrast
          ),
          Positioned(
            top: 50.0,
            left: 50.0,
            right: 50.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Cradley',
                        height: 1.25,
                        fontSize: 60.0, // Increased font size for large screens
                        letterSpacing: 2.0),
                    children: [
                      TextSpan(text: "luxurious &\n"),
                      TextSpan(text: "elevated"),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                const SubHeadingSlanted(
                  text: 'beauty services',
                  height: 1,
                  size: 100, // Increased size for large screens
                  color: AppColorConstant
                      .white, // Adjust color for better visibility
                ),
                const SizedBox(height: 20.0),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Questrial',
                      height: 1.75,
                      fontSize: 24.0, // Increased font size for large screens
                    ),
                    children: [
                      TextSpan(text: "WE'RE YOUR GO-T0 GIRLS TO HELP YOU\n"),
                      TextSpan(text: "FEEL & LOOK YOUR BEST INSIDE & OUT!"),
                    ],
                  ),
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
    return _buildLargeScreen(
        screenSize, context); // Just using large screen layout for medium
  }

  // small screen
  Widget _buildSmallScreen(Size screenSize, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: SizedBox(
        width: screenSize.width,
        height: screenSize.height * 0.5,
        child: ClipRRect(
          child: Image.network(
            'assets/images/services.webp',
            width: screenSize.width,
            height: screenSize.height * 0.5,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
