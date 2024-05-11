import 'package:flutter/material.dart';

class BridalGallery extends StatefulWidget {
  final List<String> imageUrls = [
    'assets/images/image.jpeg',
    'assets/images/service1.jpg',
    'assets/images/service2.jpg',
    'assets/images/service3.jpg',
    'assets/images/service4.jpg',
    'assets/images/testimonial.jpg',
    'assets/images/nonbridal.png',
    'assets/images/contact.png',
  ];

  BridalGallery({super.key});

  @override
  State<BridalGallery> createState() => _BridalGalleryState();
}

class _BridalGalleryState extends State<BridalGallery> {
  // late String _selectedImageUrl;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      padding: const EdgeInsets.all(40),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 24.0, // Vertical spacing between grid items
          crossAxisSpacing: 24.0, // Horizontal spacing between grid items
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _showFullImageDialog(widget.imageUrls[index]);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                image: DecorationImage(
                  image: AssetImage(widget.imageUrls[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
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
                  child: Image.asset(
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
