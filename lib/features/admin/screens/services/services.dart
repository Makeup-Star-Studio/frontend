import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';

class AdminServicesView extends StatefulWidget {
  const AdminServicesView({super.key});
  @override
  State<AdminServicesView> createState() => _AdminServicesViewState();
}

class _AdminServicesViewState extends State<AdminServicesView> {
  final _servicesFormKey = GlobalKey<FormState>();
  String selectedFile = '';
  Uint8List? _image;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;

  final List<String> _categories = [
    'Bridal',
    'Non Bridal Makeup',
    'Non Bridal Hair',
    'Henna',
    'Saree Draping'
  ];

  void _submitForm() {
    if (_servicesFormKey.currentState!.validate() &&
        _selectedCategory != null &&
        _image != null) {
      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Service Added Successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and upload an image')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        setState(() {
          _image = result.files.first.bytes;
        });
      }
    } catch (e) {
      print("File picker error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _servicesFormKey,
        child: ListView(
          children: [
            const Text(
              textAlign: TextAlign.center,
              "Manage Services",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _pickImage,
              child: _image == null
                  ? Container(
                      height: 400,
                      color: Colors.grey[200],
                      child: const Icon(Icons.add_a_photo, size: 100),
                    )
                  : Image.memory(_image!, height: 500, fit: BoxFit.contain),
            ),
            const Text(
              textAlign: TextAlign.center,
              '"Pick One Image"',
              style: TextStyle(
                color: AppColorConstant.adminPrimaryColor,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            BodyText(
              text: "Service Title",
              textAlign: TextAlign.left,
              size: 16,
              fontWeight: ResponsiveWidget.isSmallScreen(context)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
            TextFormInputField(
              textAlign: TextAlign.left,
              controller: _titleController,
              hintText:
                  "For eg: Bridal Makeup and Hair or Non Bridal Makeup or Henna Both Hands or South Indian Saree Draping etc.",
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required';
                }
                return null;
              },
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: const BorderSide(
                  width: 1.0,
                ),
              ),
              focusBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: const BorderSide(
                  width: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            BodyText(
              text: "Service Price",
              textAlign: TextAlign.left,
              size: 16,
              fontWeight: ResponsiveWidget.isSmallScreen(context)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
            TextFormInputField(
              textAlign: TextAlign.left,
              controller: _priceController,
              hintText: "For eg: 5000 or 10000 etc.",
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required';
                }
                return null;
              },
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: const BorderSide(
                  width: 1.0,
                ),
              ),
              focusBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: const BorderSide(
                  width: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            BodyText(
              text: "Service Category",
              textAlign: TextAlign.left,
              size: 16,
              fontWeight: ResponsiveWidget.isSmallScreen(context)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
            ..._categories.map((category) => RadioListTile<String>(
                  title: BodyText(
                    textAlign: TextAlign.left,
                    text: category,
                  ),
                  value: category,
                  groupValue: _selectedCategory,
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                )),
            const SizedBox(height: 20),
            ModifiedButton(
                text: 'ADD SERVICE',
                color: AppColorConstant.adminPrimaryColor,
                textColor: AppColorConstant.white,
                press: _submitForm),
          ],
        ),
      ),
    );
  }
}
