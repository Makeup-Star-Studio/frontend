import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/src/provider/portfolio/draping_gallery_provider.dart';
import 'package:provider/provider.dart';

class DrapingGallery extends StatefulWidget {
  const DrapingGallery({super.key});

  @override
  State<DrapingGallery> createState() => _DrapingGalleryState();
}

class _DrapingGalleryState extends State<DrapingGallery> {
  @override
  void initState() {
    super.initState();
    // Fetch services data on widget initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DrapingGalleryProvider>(context, listen: false)
          .fetchDrapingGallery();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DrapingGalleryProvider>(
      builder: (context, drapingGalleryProvider, child) {
        if (drapingGalleryProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (drapingGalleryProvider.portfolio.isEmpty) {
            return const Center(child: Text('No portfolio available.'));
          }
          // Collect all images from all portfolios into a single list
          final List<String> allImageUrls = drapingGalleryProvider
              .filteredPortfolio
              .expand((portfolio) => portfolio.portfolioImage)
              .map((image) =>
                  image.url) // Extract the URL from the PortfolioImage object
              .toList();

          // Display only the latest 24 images
          final List<String> limitedImageUrls = allImageUrls.take(10).toList();

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveWidget.isSmallScreen(context) ? 20.0 : 30.0,
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveWidget.isSmallScreen(context)
                    ? 2
                    : 5, // Number of grid items in the cross axis
                mainAxisSpacing: 24.0, // Vertical spacing between grid items
                crossAxisSpacing: 24.0, // Horizontal spacing between grid items
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: limitedImageUrls.length,
              itemBuilder: (BuildContext context, int index) {
                final imageUrl = limitedImageUrls[index];
                // print('Displaying image: $imageUrl');
                return GestureDetector(
                  onTap: () {
                    _showFullImageDialog(limitedImageUrls, index);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.all(2.0), // Small margin for spacing
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: FadeInImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        placeholder: const AssetImage(
                          'assets/images/logo.png',
                        ), // Placeholder image
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Container(
                          color: Colors.grey[200],
                          child: const Center(
                              child: Icon(Icons.error, color: Colors.red)),
                        ),
                        fadeInDuration: const Duration(milliseconds: 300),
                        fit: BoxFit.cover, // Ensure the image fits properly
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  void _showFullImageDialog(List<String> imageUrls, int initialIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: PageView.builder(
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return FadeInImage(
                        image: NetworkImage(imageUrls[index]),
                        placeholder: const AssetImage(
                            'assets/images/logo-gold.png'), // Placeholder image
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Container(
                          color: Colors.grey[200],
                          child: const Center(
                              child: Icon(Icons.error, color: Colors.red)),
                        ),
                        fadeInDuration: const Duration(milliseconds: 300),
                        fit: BoxFit.contain, // Ensure the full image is visible
                      );
                    },
                    controller: PageController(initialPage: initialIndex),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
