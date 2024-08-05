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
import 'package:url_launcher/url_launcher.dart';

class TestimonialSection extends StatefulWidget {
  const TestimonialSection({super.key});

  @override
  State<TestimonialSection> createState() => _TestimonialSectionState();
}

class _TestimonialSectionState extends State<TestimonialSection> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentIndex = 0;

  bool _isHovering = false;

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
                        Container(
                          height: 2.0,
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: AppColorConstant.black.withOpacity(0.2),
                        ),
                        const SizedBox(width: 150.0),
                        Align(
                          alignment: Alignment.topRight,
                          child: MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                _isHovering = true;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                _isHovering = false;
                              });
                            },
                            child: GestureDetector(
                              onTap: () {
                                launchGoogleReview();
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 180,
                                height: 65,
                                decoration: BoxDecoration(
                                  color: _isHovering
                                      ? AppColorConstant.subHeadingColor
                                          .withOpacity(0.8)
                                      : AppColorConstant.subHeadingColor,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icons/review.png', // Change to the actual path of WhatsApp logo
                                        fit: BoxFit.contain,
                                        color: AppColorConstant.white,
                                        width: 40,
                                        height: 40,
                                      ),
                                      const Text(
                                        'Tap here',
                                        style: TextStyle(
                                          color: AppColorConstant.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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
                                const BigText(
                                  text:
                                      '"Real Stories, Real Glam: Hear From Our Happy Clients"',
                                  size: 28.0,
                                  mediumSize: 25.0,
                                  height: 1.75,
                                ),
                                BodyText(
                                  size: 18.0,
                                  text: testimonial.review,
                                ),
                                const SizedBox(height: 10.0),
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
                              child: Image.network(
                                '${ApiConstant.localUrl}/testimonial/${testimonial.reviewImage}',
                                fit: BoxFit.cover,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SubHeadingSlanted(
                          text: 'Client Love',
                          size: 65.0,
                          color: AppColorConstant.black,
                        ),
                        MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              _isHovering = true;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              _isHovering = false;
                            });
                          },
                          child: GestureDetector(
                            onTap: () {
                              launchGoogleReview();
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 100,
                              height: 45,
                              decoration: BoxDecoration(
                                color: _isHovering
                                    ? AppColorConstant.subHeadingColor
                                    : AppColorConstant.subHeadingColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/review.png', // Change to the actual path of WhatsApp logo
                                      fit: BoxFit.contain,
                                      color: AppColorConstant.white,
                                      width: 30,
                                      height: 30,
                                    ),
                                    const Text(
                                      'Tap here',
                                      style: TextStyle(
                                        color: AppColorConstant.white,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const BigText(
                      text:
                          '"Real Stories, Real Glam: Hear From Our Happy Clients"',
                      smallSize: 26.0,
                      height: 1.3,
                    ),
                    const SizedBox(height: 20.0),
                    Flexible(
                      child: Image.network(
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

  void launchGoogleReview() async {
    const url =
        'https://www.google.com/search?q=makeup+star+studio+google+reviews&oq=makeup+star+studio+google+reviews&gs_lcrp=EgZjaHJvbWUyCQgAEEUYORigAdIBCDY3MzFqMGo3qAIIsAIB&sourceid=chrome&ie=UTF-8#lrd=0x808fc97cb59a6a31:0xd75d72a6d64c7eb4,1,,,,'; // Replace with your google review number
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
