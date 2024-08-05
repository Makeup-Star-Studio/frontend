import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/src/provider/portfolio/portfolio_provider.dart';
import 'package:provider/provider.dart';

class AdminPortfolioView extends StatefulWidget {
  const AdminPortfolioView({super.key});
  @override
  State<AdminPortfolioView> createState() => _AdminPortfolioViewState();
}

class _AdminPortfolioViewState extends State<AdminPortfolioView> {
  final _portfolioKey = GlobalKey<FormState>();
  List<PlatformFile>? _selectedFiles; // Updated to handle multiple files

  String? _selectedCategory;

  final List<String> _portfolioCategory = [
    'Bridal',
    'Henna',
    'Non-Bridal',
    'White-Bride'
  ];

  Future<void> _pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true, // Allow multiple file selection
      );

      if (result != null) {
        setState(() {
          if (result.files.length <= 24) {
            _selectedFiles = result.files; // Store multiple files
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColorConstant.successColor,
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

  void _submitForm() {
    if (_portfolioKey.currentState!.validate() && _selectedFiles != null) {
      if (_selectedFiles!.length <= 24) {
        List<Uint8List> imageBytesList =
            _selectedFiles!.map((file) => file.bytes!).toList();
        List<String> imageNames =
            _selectedFiles!.map((file) => file.name).toList();

        Provider.of<PortfolioProvider>(context, listen: false)
            .postPortfolio(
          category: _selectedCategory!,
          imageBytesList: imageBytesList,
          imageNames: imageNames,
        )
            .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Portfolio Added Successfully')),
          );
          _clearForm();
        }).catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to add portfolio')),
          );
          print('Error: $e');
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select up to 24 images only.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and upload images')),
      );
    }
  }

  void _clearForm() {
    setState(() {
      _selectedCategory = null;
      _selectedFiles = null; // Clear selected files
    });
  }

  @override
  Widget build(BuildContext context) {
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
                if (ResponsiveWidget.isLargeScreen(context))
                  const Text(
                    textAlign: TextAlign.center,
                    "Manage Portfolio",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration:
                      const InputDecoration(labelText: 'Select Category'),
                  items: _portfolioCategory.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const BodyText(
                  text:
                      "'You can choose up to 24 images for bridal and 10 images each for henna, non bridal and white bridal posts .... Click on the pick images and choose the images you want to upload'",
                  color: AppColorConstant.errorColor,
                  textAlign: TextAlign.center,
                  size: 16,
                  mediumSize: 14,
                  smallSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                ),
                ElevatedButton(
                  onPressed: _pickImages,
                  child: const Text('Pick Images'),
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
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
