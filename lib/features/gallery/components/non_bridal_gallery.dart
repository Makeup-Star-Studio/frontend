import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/src/provider/portfolio/non_bridal_gallery.dart';
import 'package:provider/provider.dart';

class NonBridalGallery extends StatefulWidget {
  const NonBridalGallery({super.key});

  @override
  State<NonBridalGallery> createState() => _NonBridalGalleryState();
}

class _NonBridalGalleryState extends State<NonBridalGallery> {
  @override
  void initState() {
    super.initState();
    // Fetch services data on widget initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NonBridalGalleryProvider>(context, listen: false)
          .fetchNonBridalGallery();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NonBridalGalleryProvider>(
      builder: (context, nonBridalGalleryProvider, child) {
        if (nonBridalGalleryProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (nonBridalGalleryProvider.portfolio.isEmpty) {
            return const Center(child: Text('No portfolio available.'));
          }
          // Collect all images from all portfolios into a single list
          final List<String> allImageUrls = nonBridalGalleryProvider
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
                            'assets/images/logo.png'), // Replace with your placeholder image
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 50.0,
                              ),
                            ),
                          );
                        },
                        fit: BoxFit.cover, // Change to BoxFit.contain if needed
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
                      return CachedNetworkImage(
                        imageUrl: imageUrls[index],
                        fit: BoxFit.contain, // Ensure the full image is visible
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
