import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
import 'package:makeupstarstudio/src/provider/images/random_images_provider.dart';
import 'package:provider/provider.dart';

class AdminImageManagementScreen extends StatefulWidget {
  const AdminImageManagementScreen({super.key});

  @override
  State<AdminImageManagementScreen> createState() =>
      _AdminImageManagementScreenState();
}

class _AdminImageManagementScreenState
    extends State<AdminImageManagementScreen> {
  final _imageKey = GlobalKey<FormState>();
  List<PlatformFile>? _selectedFiles; // Handle multiple files
  bool _isUploading = false; // Flag to indicate if uploading is in progress

  @override
  void initState() {
    super.initState();
    // Fetch existing images when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RandomImageProvider>(context, listen: false).fetchAllImages();
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
          if (result.files.length <= 7) {
            _selectedFiles = result.files;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColorConstant.errorColor,
                content: Text('You can only select up to 7 images.',
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
    if (_imageKey.currentState!.validate() && _selectedFiles != null) {
      if (_selectedFiles!.length <= 8) {
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
          _isUploading = true; // Start showing loader
        });

        List<String>? uploadedImageUrls =
            await Provider.of<RandomImageProvider>(context, listen: false)
                .uploadImage(
          imageBytesList,
          imageNames,
        );

        setState(() {
          _isUploading = false; // Stop showing loader
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: AppColorConstant.successColor,
              content: BodyText(
                  text: 'Images Added Successfully', color: Colors.white)),
        );
        Provider.of<RandomImageProvider>(context, listen: false)
            .fetchAllImages();
        _clearForm();
            }
    }
  }

  void _clearForm() {
    setState(() {
      _selectedFiles = null;
    });
  }

  Future<void> _deleteImage(String id) async {
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
      await Provider.of<RandomImageProvider>(context, listen: false)
          .deleteImage(id);
    }
  }

  Future<void> _deleteAllImages() async {
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
      await Provider.of<RandomImageProvider>(context, listen: false)
          .deleteAllImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<RandomImageProvider>(context);
    return SingleChildScrollView(
      child: Consumer<RandomImageProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && !_isUploading) {
            return const Center(child: LinearProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        'Image Management',
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
                  key: _imageKey,
                  child: Column(
                    children: [
                      if (ResponsiveWidget.isLargeScreen(context))
                        const Text(
                          textAlign: TextAlign.center,
                          "Manage Images",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const BodyText(
                        text:
                            "'You can choose up to 7 images. \n Click on the pick images and choose the images you want to upload'",
                        textAlign: TextAlign.center,
                        size: 18,
                        mediumSize: 16,
                        smallSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal,
                      ),
                      ModifiedButton(
                        press: _pickImages,
                        text: 'Pick Images',
                        color: AppColorConstant.adminPrimaryColor,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 16.0),
                      if (_selectedFiles != null) ...[
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: _selectedFiles!.map((file) {
                            return Image.memory(
                              file.bytes!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            );
                          }).toList(),
                        ),
                      ],
                      const SizedBox(height: 16.0),
                      ModifiedButton(
                        press: _submitForm,
                        text: 'Upload Images',
                        color: AppColorConstant.adminPrimaryColor,
                        textColor: Colors.white,
                      ),
                      if (_isUploading) ...[
                        const SizedBox(height: 16.0),
                        const CircularProgressIndicator(),
                      ],
                      const SizedBox(height: 16.0),
                      if (provider.images.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const BodyText(
                                text: 'Existing Images',
                                height: 1.2,
                                size: 28.0,
                                mediumSize: 28.0,
                                smallSize: 20.0,
                                color: AppColorConstant.adminPrimaryColor,
                              ),
                              const SizedBox(height: 16.0),
                              GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                itemCount: provider.images.length,
                                itemBuilder: (context, index) {
                                  final image = provider.images[index];
                                  return Stack(
                                    children: [
                                      Image.network(
                                        image.url,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () =>
                                              _deleteImage(image.id ?? ''),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 16.0),
                              ModifiedButton(
                                press: _deleteAllImages,
                                text: 'Delete All Images',
                                color: AppColorConstant.adminPrimaryColor,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
