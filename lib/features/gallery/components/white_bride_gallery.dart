import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/src/provider/portfolio/white_bride_provider.dart';
import 'package:provider/provider.dart';

class WhiteBrideGallery extends StatefulWidget {
  const WhiteBrideGallery({super.key});

  @override
  State<WhiteBrideGallery> createState() => _WhiteBrideGalleryState();
}

class _WhiteBrideGalleryState extends State<WhiteBrideGallery> {
  final CarouselController _carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WhiteBridalProvider>(context, listen: false)
          .fetchWhiteBridalGallery();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Consumer<WhiteBridalProvider>(
      builder: (context, whiteBridalGalleryProvider, child) {
        if (whiteBridalGalleryProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (whiteBridalGalleryProvider.filteredPortfolio.isEmpty) {
          return const Center(child: Text('No portfolio available.'));
        }

        // Flatten the list of images from all portfolio items
        final List<String> allImages =
            whiteBridalGalleryProvider.filteredPortfolio
                .expand((portfolio) => portfolio.portfolioImage ?? [])
                .take(10) // Limit to 24 images
                .cast<String>() // Ensure type is List<String>
                .toList();

        if (allImages.isEmpty) {
          return const Center(child: Text('No portfolio available.'));
        }

        return Center(
          child: Stack(
            children: [
              CarouselSlider(
                carouselController: _carouselController,
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 10),
                  viewportFraction: 1.0, // Show one image at a time
                  height: screenSize.height, // Adjust height as needed
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  pauseAutoPlayOnTouch: true,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  // Add additional options as needed
                ),
                items: allImages.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: screenSize.width * 0.8,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Text('Error loading image'));
                          },
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Positioned(
                left: 10,
                top: screenSize.height * 0.4, // Adjust position as needed
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.black, size: 40),
                  onPressed: () => _carouselController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: screenSize.height * 0.4, // Adjust position as needed
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward,
                      color: Colors.black, size: 40),
                  onPressed: () => _carouselController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Container(
                  color: Colors.white.withOpacity(0.7),
                  padding: const EdgeInsets.all(16),
                  child: const BodyText(
                    text:
                        "Indian girls marrying foreign boys and embracing white weddings is a beautiful blend of cultures, celebrating the union of diverse traditions and values. These weddings highlight the harmonious fusion of rich Indian heritage with modern, global influences, showcasing a unique and elegant approach to matrimony. They symbolize love that transcends borders, bringing together the best of both worlds in a celebration of unity and diversity.",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
