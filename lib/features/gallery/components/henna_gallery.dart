import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/src/provider/portfolio/henna_provider.dart';
import 'package:provider/provider.dart';

class HennaGallery extends StatefulWidget {
  const HennaGallery({super.key});

  @override
  State<HennaGallery> createState() => _HennaGalleryState();
}

class _HennaGalleryState extends State<HennaGallery> {
  @override
  void initState() {
    super.initState();
    // Fetch services data on widget initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HennaGalleryProvider>(context, listen: false)
          .fetchHennaGallery();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HennaGalleryProvider>(
      builder: (context, hennaGalleryProvider, child) {
        if (hennaGalleryProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Flatten the list of images from all portfolio items
          final List<String> allImages = hennaGalleryProvider.filteredPortfolio
              .expand((portfolio) => portfolio.portfolioImage ?? [])
              .take(24) // Limit to 24 images
              .cast<String>() // Ensure type is List<String>
              .toList();

          if (allImages.isEmpty) {
            return const Center(child: Text('No portfolio available.'));
          }

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
              itemCount: allImages.length,
              itemBuilder: (BuildContext context, int index) {
                final imageUrl = allImages[index];
                print('Displaying image: $imageUrl');
                return GestureDetector(
                  onTap: () {
                    _showFullImageDialog(allImages, index);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.all(2.0), // Small margin for spacing
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        fit: BoxFit.cover, // Change to BoxFit.contain if needed
                      ),
                    ),
                    // Ensure the container has a fixed aspect ratio
                    width: double.infinity,
                    height: double.infinity,
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
