import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/src/provider/portfolio/henna_provider.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';
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
          if (hennaGalleryProvider.filteredPortfolio.isEmpty) {
            return const Center(child: Text('No portfolio available.'));
          }

          // Collect all images from all portfolios into a single list
          final List<String> allImageUrls = hennaGalleryProvider
              .filteredPortfolio
              .expand((portfolio) => portfolio.portfolioImage)
              .map((image) =>
                  '${ApiConstant.localUrl}/portfolio/${image.filename}')
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

                return GestureDetector(
                  onTap: () {
                    _showFullImageDialog(imageUrl);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
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

  void _showFullImageDialog(String imageUrl) {
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
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
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
