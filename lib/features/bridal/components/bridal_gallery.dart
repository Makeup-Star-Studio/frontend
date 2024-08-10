import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/src/provider/portfolio/bridal_portfolio.dart';
import 'package:provider/provider.dart';

class BridalGallery extends StatefulWidget {
  const BridalGallery({super.key});

  @override
  State<BridalGallery> createState() => _BridalGalleryState();
}

class _BridalGalleryState extends State<BridalGallery> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BridalPortfolioProvider>(context, listen: false)
          .fetchBridalPortfolios();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BridalPortfolioProvider>(
      builder: (context, bridalPortfolioProvider, child) {
        if (bridalPortfolioProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (bridalPortfolioProvider.filteredPortfolio.isEmpty) {
            return const Center(child: Text('No portfolio available.'));
          }

          // Collect all image URLs
          final List<String> allImageUrls = bridalPortfolioProvider
              .filteredPortfolio
              .expand((portfolio) =>
                  (portfolio.portfolioImage ?? []).cast<String>())
              .toList();

          // Display only the latest 24 images
          final List<String> limitedImageUrls = allImageUrls.take(24).toList();

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemCount: limitedImageUrls.length,
              itemBuilder: (BuildContext context, int index) {
                final imageUrl = limitedImageUrls[index];

                return GestureDetector(
                  onTap: () {
                    _showFullImageDialog(imageUrl);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fadeInDuration: const Duration(milliseconds: 500),
                      fadeInCurve: Curves.easeIn,
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
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fadeInDuration: const Duration(milliseconds: 500),
                    fadeInCurve: Curves.easeIn,
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
