import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';

class AdminGlamTeamView extends StatefulWidget {
  const AdminGlamTeamView({super.key});
  @override
  State<AdminGlamTeamView> createState() => _AdminGlamTeamViewState();
}

class _AdminGlamTeamViewState extends State<AdminGlamTeamView> {
  final _memberFormKey = GlobalKey<FormState>();
  String selectedFile = '';
  Uint8List? _image;
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _phoneController = TextEditingController();

  void _submitForm() {
    if (_memberFormKey.currentState!.validate() && _image != null) {
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
    _nameController.dispose();
    _roleController.dispose();
    _phoneController.dispose();
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
        key: _memberFormKey,
        child: ListView(
          children: [
            const Text(
              textAlign: TextAlign.center,
              "Manage Glam Team Members",
              style: TextStyle(
                fontSize: 22,
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
              '"Select a photo of the member to upload"',
              style: TextStyle(
                color: AppColorConstant.adminPrimaryColor,
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            BodyText(
              text: "Member Name",
              textAlign: TextAlign.left,
              size: 16,
              fontWeight: ResponsiveWidget.isSmallScreen(context)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
            TextFormInputField(
              textAlign: TextAlign.left,
              controller: _nameController,
              hintText: "Write the member name here.",
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
              text: "Member Role",
              textAlign: TextAlign.left,
              size: 16,
              fontWeight: ResponsiveWidget.isSmallScreen(context)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
            TextFormInputField(
              textAlign: TextAlign.left,
              controller: _roleController,
              hintText:
                  "For eg: Makeup Artist, Hair Stylist, Henna Artist, Saree Draper, All-Rounder etc.",
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
              text: "Member Phone No.",
              textAlign: TextAlign.left,
              size: 16,
              fontWeight: ResponsiveWidget.isSmallScreen(context)
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
            TextFormInputField(
              textAlign: TextAlign.left,
              controller: _phoneController,
              hintText: "Write the member's phone number here. Eg: 1234567890",
              keyboardType: TextInputType.phone,
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
