import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/src/provider/portfolio/bridal_henna_provider.dart';
import 'package:provider/provider.dart';

class BridalHennaGallery extends StatefulWidget {
  const BridalHennaGallery({super.key});

  @override
  State<BridalHennaGallery> createState() => _BridalHennaGalleryState();
}

class _BridalHennaGalleryState extends State<BridalHennaGallery> {
  @override
  void initState() {
    super.initState();
    // Fetch services data on widget initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BridalHennaGalleryProvider>(context, listen: false)
          .fetchBridalHennaGallery();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BridalHennaGalleryProvider>(
      builder: (context, bridalHennaGalleryProvider, child) {
        if (bridalHennaGalleryProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (bridalHennaGalleryProvider.portfolio.isEmpty) {
            return const Center(child: Text('No portfolio available.'));
          }
          // Collect all images from all portfolios into a single list
          final List<String> allImageUrls = bridalHennaGalleryProvider
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
                crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 2 : 5,
                mainAxisSpacing: 24.0,
                crossAxisSpacing: 24.0,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: limitedImageUrls.length,
              itemBuilder: (BuildContext context, int index) {
                final imageUrl = limitedImageUrls[index];
                print('Displaying image: $imageUrl'); // Debug statement

                return GestureDetector(
                  onTap: () {
                    _showFullImageDialog(limitedImageUrls, index);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: FadeInImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        placeholder: const AssetImage('assets/images/logo.png'),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Container(
                          color: Colors.grey[200],
                          child: const Center(
                              child: Icon(Icons.error, color: Colors.red)),
                        ),
                        fadeInDuration: const Duration(milliseconds: 300),
                        fit: BoxFit.cover,
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
                        placeholder:
                            const AssetImage('assets/images/logo-gold.png'),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Container(
                          color: Colors.grey[200],
                          child: const Center(
                              child: Icon(Icons.error, color: Colors.red)),
                        ),
                        fadeInDuration: const Duration(milliseconds: 300),
                        fit: BoxFit.contain,
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
