import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
    'Gallery',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PortfolioProvider>(context, listen: false)
          .fetchAllPortfolios();
    });
  }

  Future<void> _pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true, // Allow multiple file selection
      );

      if (result != null) {
        setState(() {
          _selectedFiles = result.files; // Store multiple files
        });
      }
    } catch (e) {
      print("File picker error: $e");
    }
  }

  void _submitForm() {
    if (_portfolioKey.currentState!.validate() && _selectedFiles != null) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Portfolio View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _portfolioKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Select Category'),
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
    );
  }
}
