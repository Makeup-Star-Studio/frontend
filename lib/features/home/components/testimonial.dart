import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
import 'package:makeupstarstudio/features/home/widget/links.dart';
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

  final bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TestimonialProvider>(context, listen: false)
          .fetchTestimonial();
    });
  }

  void _nextTestimonial() {
    final testimonialCount =
        Provider.of<TestimonialProvider>(context, listen: false)
            .testimonials
            .length;
    if (_currentIndex < testimonialCount - 1 && _currentIndex < 2) {
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
        Provider.of<TestimonialProvider>(context).testimonials.take(3).toList();

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
          if (provider.testimonials.isEmpty) {
            return const Center(child: Text('No testimonials available'));
          }
          return Container(
            color: AppColorConstant.bgColor,
            padding: const EdgeInsets.symmetric(horizontal: 50),
            height: MediaQuery.of(context).size.height,
            child: PageView.builder(
              controller: _pageController,
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                final testimonial = testimonials[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SubHeadingSlanted(
                          // textAlign: TextAlign.left,
                          text: 'Client Love',
                          size: 65.0,
                          color: AppColorConstant.black,
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: Container(
                            height: 2.0,
                            width: MediaQuery.of(context).size.width * 0.7,
                            color: AppColorConstant.black.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    const Links(),
                    // const SizedBox(height: 20.0),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BodyText(
                                  size: 18.0,
                                  text: '"${testimonial.review}"',
                                ),
                                const SizedBox(height: 10.0),
                                SvgPicture.asset(
                                  'assets/svgs/star.svg',
                                  width: 150,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                BodyText(
                                  text:
                                      '- ${testimonial.fname} ${testimonial.lname}',
                                  color: const Color.fromARGB(255, 22, 22, 21),
                                  fontStyle: FontStyle.italic,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: testimonial.reviewImage == null
                                  ? const Center(
                                      child: Text('No image available'),
                                    )
                                  :
                              
                              Image.network(
                                'https://makeup-star-studio.sfo2.digitaloceanspaces.com/${testimonial.reviewImage}',

                                // '${ApiConstant.localUrl}/api/testimonial/${testimonial.reviewImage}',
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: MediaQuery.of(context).size.height,
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
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 20.0),
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
                );
              },
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
            height: screenSize.height,
            child: PageView.builder(
              controller: _pageController,
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                final testimonial = testimonials[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const SubHeadingSlanted(
                          text: 'Client Love',
                          size: 65.0,
                          color: AppColorConstant.black,
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: Container(
                            height: 2.0,
                            width: 150,
                            color: AppColorConstant.black.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                    const Links(),
                    const SizedBox(height: 20.0),
                    Flexible(
                      child: testimonial.reviewImage == null
                          ? const Center(
                              child: Text('No image available'),
                            )
                          :
                      Image.network(
                        '${ApiConstant.localUrl}/testimonial/${testimonial.reviewImage}',
                        fit: BoxFit.fitHeight,
                        width: 300.0,
                        height: screenSize.height * 0.4,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error');
                          return const Center(
                            child: Text('Failed to load image'),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    BodyText(
                      text: testimonial.review,
                      smallSize: 14.0,
                      mediumSize: 16.0,
                      height: 1.2,
                    ),
                    // const SizedBox(height: 10.0),
                    BodyText(
                      text: '- ${testimonial.fname} ${testimonial.lname}',
                      color: const Color.fromARGB(255, 22, 22, 21),
                      smallSize: 12.0,
                      mediumSize: 14.0,
                      fontStyle: FontStyle.italic,
                    ),
                    // const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            iconColor: AppColorConstant.black,
                            foregroundColor: AppColorConstant.black,
                          ),
                          onPressed: _previousTestimonial,
                          label: const Text('Previous Page'),
                          icon: const Icon(Icons.arrow_back_sharp),
                        ),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColorConstant.black,
                            iconColor: AppColorConstant.black,
                          ),
                          onPressed: _nextTestimonial,
                          label: const Text('Next Page'),
                          icon: const Icon(Icons.arrow_forward_sharp),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}
