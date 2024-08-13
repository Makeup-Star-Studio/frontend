import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
import 'package:makeupstarstudio/src/model/portfolio_model.dart';
import 'package:makeupstarstudio/src/provider/portfolio/portfolio_provider.dart';
import 'package:provider/provider.dart';

class AdminPortfolioView extends StatefulWidget {
  const AdminPortfolioView({super.key});

  @override
  State<AdminPortfolioView> createState() => _AdminPortfolioViewState();
}

class _AdminPortfolioViewState extends State<AdminPortfolioView> {
  final _portfolioKey = GlobalKey<FormState>();
  List<PlatformFile>? _selectedFiles;
  String? _selectedCategory;
  bool _isLoading = false;

  final List<String> _portfolioCategory = [
    'Bridal',
    'Bridal-Henna',
    'NonBridal-Henna',
    'Non-Bridal',
    'White-Bride',
    'Draping'
  ];

  @override
  void initState() {
    super.initState();
    // Fetch existing images when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PortfolioProvider>(context, listen: false)
          .fetchAllPortfolios();
    });
  }

  Future<void> _pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          if (result.files.length <= 24) {
            _selectedFiles = result.files;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColorConstant.errorColor,
                content: Text('You can only select up to 24 images.',
                    style: TextStyle(color: Colors.white)),
              ),
            );
          }
        });
      }
    } catch (e) {
      print("File picker error: $e");
    }
  }

  Future<void> _submitForm() async {
    if (_portfolioKey.currentState!.validate() && _selectedFiles != null) {
      if (_selectedFiles!.length <= 24) {
        // Validate file sizes
        bool filesTooLarge = _selectedFiles!.any(
            (file) => file.bytes!.length > 15 * 1024 * 1024); // 15 MB in bytes

        if (filesTooLarge) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColorConstant.errorColor,
              content: Text(
                'File size too large. Each file must be less than 15 MB.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
          return;
        }

        List<Uint8List> imageBytesList =
            _selectedFiles!.map((file) => file.bytes!).toList();
        List<String> imageNames =
            _selectedFiles!.map((file) => file.name).toList();

        setState(() {
          _isLoading = true;
        });

        try {
          List<String>? uploadedImageUrls =
              await Provider.of<PortfolioProvider>(context, listen: false)
                  .uploadPortfolioImages(
            _selectedCategory!,
            imageBytesList,
            imageNames,
          );
          if (uploadedImageUrls != null && uploadedImageUrls.isNotEmpty) {
            await Provider.of<PortfolioProvider>(context, listen: false)
                .postPortfolio(
              category: _selectedCategory!,
              portfolioImage: uploadedImageUrls,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: AppColorConstant.successColor,
                  content: BodyText(
                      text: 'Portfolio Added Successfully',
                      color: Colors.white)),
            );
            _clearForm();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColorConstant.errorColor,
                content: Text(
                  'Image upload failed. Please try again.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: AppColorConstant.errorColor,
                content: BodyText(
                    text: 'Failed to add portfolio', color: Colors.white)),
          );
          print('Error: $e');
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: AppColorConstant.errorColor,
            content: BodyText(
                text: 'Please fill all fields and upload images',
                color: Colors.white)),
      );
    }
  }

  void _clearForm() {
    setState(() {
      _selectedCategory = null;
      _selectedFiles = null;
    });
  }

  Future<void> _deleteImage(String portfolioId, String imageId) async {
    // Show a dialog to confirm deletion
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const SubHeadingSlanted(
            text: 'Confirm Deletion',
            height: 1.2,
            color: AppColorConstant.errorColor,
          ),
          content: const BodyText(
              text: 'Are you sure you want to delete this image?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User pressed Cancel
              },
              child: const BodyText(text: 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User pressed Delete
              },
              child: const BodyText(text: 'Delete'),
            ),
          ],
        );
      },
    );

    // If user confirmed deletion
    if (confirmDelete == true) {
      await Provider.of<PortfolioProvider>(context, listen: false)
          .deleteOnePortfolioImage(portfolioId, imageId);
    }
  }

  Future<void> _deleteCategoryImages(String category) async {
    setState(() {
      _isLoading = true;
    });
    // Show a dialog to confirm deletion
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const SubHeadingSlanted(
            text: 'Confirm Deletion',
            height: 1.2,
            color: AppColorConstant.errorColor,
          ),
          content: const BodyText(
              text: 'Are you sure you want to delete all images?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User pressed Cancel
              },
              child: const BodyText(text: 'Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User pressed Delete
              },
              child: const BodyText(text: 'Delete'),
            ),
          ],
        );
      },
    );

    // If user confirmed deletion
    if (confirmDelete == true) {
      await Provider.of<PortfolioProvider>(context, listen: false)
          .deletePortfolioByCat(category);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildLoader() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: const LinearProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(AppColorConstant.adminPrimaryColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Consumer<PortfolioProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                // Group images by category
                final Map<String, List<PortfolioImage>> imagesByCategory = {};
                for (var portfolio in provider.portfolio) {
                  for (var image in portfolio.portfolioImage) {
                    if (!imagesByCategory.containsKey(portfolio.category)) {
                      imagesByCategory[portfolio.category] = [];
                    }
                    imagesByCategory[portfolio.category]!.add(image);
                  }
                }
                return Column(
                  children: [
                    if (!ResponsiveWidget.isLargeScreen(context))
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        color: AppColorConstant.adminMenuColor,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.menu, color: Colors.white),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Manage Portfolio',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _portfolioKey,
                        child: Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: _selectedCategory,
                              items: _portfolioCategory.map((category) {
                                return DropdownMenuItem<String>(
                                  value: category,
                                  child: Text(category),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Select Category',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const BodyText(
                                text:
                                    "you can only upload 24 images for bridal category and 10 images for others, the image size should be less than 15 mb and it should be in JPEG format",
                                color: AppColorConstant.adminMenuColor),
                            ElevatedButton(
                              onPressed: _pickImages,
                              child: const Text('Select Images'),
                            ),
                            if (_selectedFiles != null)
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _selectedFiles!.length,
                                  itemBuilder: (context, index) {
                                    final file = _selectedFiles![index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.memory(
                                        file.bytes!,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text('Upload Images'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const BodyText(
                        text:
                            "if you want to delete all images of a category, click on the delete icon on the right side of the category name",
                        color: Colors.red),
                    ...imagesByCategory.entries.map((entry) {
                      final category = entry.key;
                      final images = entry.value;

                      if (images.isEmpty) {
                        return Center(
                          child: Text(
                            'No images found for $category',
                            style: const TextStyle(fontSize: 18),
                          ),
                        );
                      }

                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(category),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    _deleteCategoryImages(category),
                              ),
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: images.length,
                                itemBuilder: (context, index) {
                                  final image = images[index];
                                  final portfolio = provider.portfolio
                                      .firstWhere((p) =>
                                          p.portfolioImage.contains(image));
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          image.url,
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () => _deleteImage(
                                              portfolio.id!,
                                              image.id,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                );
              }
            },
          ),
        ),
        if (_isLoading) _buildLoader(),
      ],
    );
  }
}
