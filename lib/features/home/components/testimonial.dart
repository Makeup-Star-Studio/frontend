// import 'package:flutter/material.dart';
// import 'package:makeupstarstudio/config/constants/color.dart';
// import 'package:makeupstarstudio/config/constants/responsive.dart';
// import 'package:makeupstarstudio/core/common/text/body.dart';
// import 'package:makeupstarstudio/core/common/text/heading.dart';
// import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
// import 'package:makeupstarstudio/src/model/testimonial_model.dart';
// import 'package:makeupstarstudio/src/provider/testimonial/testimonial_provider.dart';
// import 'package:provider/provider.dart';

// class TestimonialSection extends StatefulWidget {
//   const TestimonialSection({super.key});

//   @override
//   State<TestimonialSection> createState() => _TestimonialSectionState();
// }

// class _TestimonialSectionState extends State<TestimonialSection> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch services data on widget initialization
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<TestimonialProvider>(context, listen: false)
//           .fetchTestimonial();
//     });
//   }

//   int _currentIndex = 0;

//   final List<Map<String, dynamic>> _testimonials = [
//     {
//       'bigText': '"THERE WERE NO TEARS OVER HAIR & MAKEUP THAT DAY!"',
//       'bodyText':
//           'I hired Makeup Star Studio for my wedding, I am so happy that I did. My hair and make up was incredible and all of my bridesmaids were so happy with how everything turned out. There were no tears over hair and make up that day! It was everything a bride could ask for. They were so skilled and efficient that we ran ahead of schedule and I had almost zero stress on my wedding day. The stylists are so talented and polite that I could not have found a better place. I highly recommend hiring them for your big day or any beauty needs!!',
//       'name': 'JENNA',
//       'imagePath': 'assets/images/testimonial.jpg',
//     },
//     {
//       'bigText': '"DO NOT LOOK ANYWHERE ELSE FOR WEDDING MAKE-UP"',
//       'bodyText':
//           'Do not look anywhere else for wedding make-up. Call and book, ASAP. Cannot say enough amazing things about Geet. Hired Makeup Star Studio for my wedding to do make-up for myself, mom, 4 bridesmaids and 2 flower girls. Grace and Hayley were our make-up artists and were wonderful. Kind, friendly and talented! Everyone loved their make-up and I was beyond happy with mine - it was perfect!',
//       'name': 'PREETI',
//       'imagePath': 'assets/images/service1.jpg',
//     },
//     {
//       'bigText': '"THERE WERE NO TEARS OVER HAIR & MAKEUP THAT DAY!"',
//       'bodyText':
//           'I hired Mane Chic for my wedding, I am so happy that I did. My hair and make up was incredible and all of my bridesmaids were so happy with how everything turned out. There were no tears over hair and make up that day! It was everything a bride could ask for. They were so skilled and efficient that we ran ahead of schedule and I had almost zero stress on my wedding day. The stylists are so talented and polite that I could not have found a better place. I highly recommend hiring them for your big day or any beauty needs!!',
//       'name': 'JENNA',
//       'imagePath': 'assets/images/testimonial.jpg',
//     },
//     // Add more testimonials as needed
//   ];

//   void _nextTestimonial() {
//     setState(() {
//       _currentIndex = (_currentIndex + 1) % _testimonials.length;
//     });
//   }

//   void _previousTestimonial() {
//     setState(() {
//       _currentIndex = (_currentIndex - 1) % _testimonials.length;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final testimonial = _testimonials[_currentIndex];
//     final screenSize = MediaQuery.of(context).size;
//     final List<Testimonial> testimonials =
//         Provider.of<TestimonialProvider>(context).testimonials;

//     return ResponsiveWidget(
//       largeScreen: _buildLargeScreen(testimonial, testimonials),
//       mediumScreen: _buildMediumScreen(screenSize, testimonial),
//       smallScreen: _buildSmallScreen(screenSize, testimonial),
//     );
//   }

//   Widget _buildLargeScreen(
//       Map<String, dynamic> testimonial, List<Testimonial> testimonials) {
//     return Consumer<TestimonialProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           return Container(
//             color: AppColorConstant.bgColor,
//             padding: const EdgeInsets.only(left: 50),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const SubHeadingSlanted(
//                         textAlign: TextAlign.start,
//                         text: 'Client Love',
//                         size: 65.0,
//                         color: AppColorConstant.black,
//                       ),
//                       const SizedBox(height: 50.0),
//                       BigText(
//                         textAlign: TextAlign.start,
//                         text: testimonial['bigText'],
//                         size: 25.0,
//                       ),
//                       const SizedBox(height: 20.0),
//                       BodyText(
//                         textAlign: TextAlign.start,
//                         // text: testimonial['bodyText'],
//                         text: testimonials
//                             .map((testimonial) => testimonial.review)
//                             .toString(),
//                       ),
//                       const SizedBox(height: 20.0),
//                       BodyText(
//                         text: testimonials
//                             .map((testimonial) =>
//                                 '${testimonial.fname} ${testimonial.lname}')
//                             .toString(),
//                         color: const Color.fromARGB(255, 22, 22, 21),
//                         size: 16.0,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 20.0),
//                 Stack(
//                   children: [
//                     ClipRect(
//                       child: Image.asset(
//                         testimonials
//                             .map((testimonial) => testimonial.reviewImage)
//                             .toString(),
//                         width: 750.0,
//                         height: 750.0,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 3,
//                       left: 5,
//                       child: Container(
//                         decoration: const BoxDecoration(
//                           color: AppColorConstant.iconBgColor,
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20.0, vertical: 4.0),
//                         child: Row(
//                           children: [
//                             IconButton(
//                               hoverColor: Colors.transparent,
//                               onPressed: _previousTestimonial,
//                               icon: const Icon(
//                                 Icons.arrow_back_sharp,
//                                 color: AppColorConstant.black,
//                               ),
//                             ),
//                             const SizedBox(width: 12.0),
//                             IconButton(
//                               hoverColor: Colors.transparent,
//                               onPressed: _nextTestimonial,
//                               icon: const Icon(
//                                 Icons.arrow_forward_sharp,
//                                 color: AppColorConstant.black,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }

import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
import 'package:makeupstarstudio/src/model/testimonial_model.dart';
import 'package:makeupstarstudio/src/provider/testimonial/testimonial_provider.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';
import 'package:provider/provider.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TestimonialProvider>(context, listen: false)
          .fetchTestimonial();
    });
  }

  void _nextTestimonial() {
    if (_currentIndex < 2) {
      setState(() {
        _currentIndex++;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _previousTestimonial() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final List<Testimonial> testimonials =
        Provider.of<TestimonialProvider>(context).testimonials;

    for (var testimonial in testimonials) {
      print("Image URL: ${testimonial.reviewImage}");
    }

    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(testimonials),
      mediumScreen: _buildMediumScreen(screenSize, testimonials),
      smallScreen: _buildSmallScreen(screenSize, testimonials),
    );
  }

  Widget _buildLargeScreen(List<Testimonial> testimonials) {
    return Consumer<TestimonialProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container(
            color: AppColorConstant.bgColor,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SubHeadingSlanted(
                  // textAlign: TextAlign.start,
                  text: 'Client Love',
                  size: 65.0,
                  color: AppColorConstant.black,
                ),
                // const SizedBox(height: 50.0),
                SizedBox(
                  height: 750.0,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: testimonials.length,
                    itemBuilder: (context, index) {
                      final testimonial = testimonials[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const BigText(
                            // textAlign: TextAlign.start,
                            text:
                                '"THERE WERE NO TEARS OVER HAIR & MAKEUP THAT DAY!"',
                            size: 20.0,
                            height: 1.3,
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            height: 500.0,
                            width: 500,
                            child: Image.network(
                              '${ApiConstant.localUrl}/testimonial/${testimonials[index].reviewImage}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error');
                                return const Center(
                                  child: Text('Failed to load image'),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          BodyText(
                            // textAlign: TextAlign.center,
                            text: testimonial.review,
                          ),
                          const SizedBox(height: 20.0),
                          BodyText(
                            text: '- ${testimonial.fname} ${testimonial.lname}',
                            color: const Color.fromARGB(255, 22, 22, 21),
                            size: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      hoverColor: Colors.transparent,
                      onPressed: _previousTestimonial,
                      icon: const Icon(
                        Icons.arrow_back_sharp,
                        color: AppColorConstant.black,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    IconButton(
                      hoverColor: Colors.transparent,
                      onPressed: _nextTestimonial,
                      icon: const Icon(
                        Icons.arrow_forward_sharp,
                        color: AppColorConstant.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildMediumScreen(Size screenSize, List<Testimonial> testimonials) {
    return _buildSmallScreen(screenSize, testimonials);
  }

  Widget _buildSmallScreen(Size screenSize, List<Testimonial> testimonials) {
    return Consumer<TestimonialProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container(
            color: AppColorConstant.bgColor,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SubHeadingSlanted(
                  textAlign: TextAlign.start,
                  text: 'Client Love',
                  size: 65.0,
                  color: AppColorConstant.black,
                ),
                // const SizedBox(height: 50.0),
                SizedBox(
                  height: 750.0,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: testimonials.length,
                    itemBuilder: (context, index) {
                      final testimonial = testimonials[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const BigText(
                            // textAlign: TextAlign.start,
                            text:
                                '"THERE WERE NO TEARS OVER HAIR & MAKEUP THAT DAY!"',
                            size: 20.0,
                            height: 1.3,
                          ),
                          const SizedBox(height: 20.0),
                          BodyText(
                            // textAlign: TextAlign.center,
                            text: testimonial.review,
                          ),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            height: 250.0,
                            width: double.infinity,
                            child: Image.network(
                              '${ApiConstant.localUrl}/testimonial/${testimonial.reviewImage}',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error');
                                return const Center(
                                  child: Text('Failed to load image'),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          BodyText(
                            text: '- ${testimonial.fname} ${testimonial.lname}',
                            color: const Color.fromARGB(255, 22, 22, 21),
                            size: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      hoverColor: Colors.transparent,
                      onPressed: _previousTestimonial,
                      icon: const Icon(
                        Icons.arrow_back_sharp,
                        color: AppColorConstant.black,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    IconButton(
                      hoverColor: Colors.transparent,
                      onPressed: _nextTestimonial,
                      icon: const Icon(
                        Icons.arrow_forward_sharp,
                        color: AppColorConstant.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
