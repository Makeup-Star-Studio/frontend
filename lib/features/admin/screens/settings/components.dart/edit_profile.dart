import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/features/booking/widget/validator.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _profileFormKey = GlobalKey<FormState>();
  String selectedFile = '';
  Uint8List? _imageUrl;
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _bioController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        setState(() {
          _imageUrl = result.files.single.bytes;
          selectedFile = result.files.single.name;
        });
      }
    } catch (e) {
      print("File picker error: $e");
    }
  }

  void _clearForm() {
    setState(() {
      _imageUrl = null;
      _fullNameController.clear();
      _usernameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _bioController.clear();
      _locationController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _profileFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Colors.grey[300],
                  child: _imageUrl == null
                      ? const Icon(Icons.add_a_photo, size: 100)
                      : CircleAvatar(
                          backgroundImage: MemoryImage(_imageUrl!),
                          radius: 80.0,
                          backgroundColor: Colors.transparent),
                ),
              ),
              const SizedBox(height: 10.0),
              const BodyText(text: "Change Your Profile Picture"),
              // const SizedBox(height: 20.0),
              SizedBox(
                height: ResponsiveWidget.isSmallScreen(context) ? 0.0 : 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormInputField(
                      textAlign: TextAlign.start,
                      controller: _fullNameController,
                      hintText: 'Full Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
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
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormInputField(
                      textAlign: TextAlign.start,
                      controller: _usernameController,
                      hintText: 'Username',
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
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                textAlign: TextAlign.start,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  final emailRegex = RegExp(
                    r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9@.]')),
                  LowercaseTextFormatter(),
                ],
                cursorColor: AppColorConstant.black.withOpacity(0.6),
                keyboardType: TextInputType.emailAddress,
                maxLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColorConstant.white,
                  hintText: 'Email Address',
                  hintStyle: TextStyle(
                    color: ResponsiveWidget.isSmallScreen(context)
                        ? AppColorConstant.black
                        : AppColorConstant.black.withOpacity(0.6),
                    fontSize: ResponsiveWidget.isSmallScreen(context) ? 16 : 14,
                    fontWeight: ResponsiveWidget.isSmallScreen(context)
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: const BorderSide(
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    borderSide: const BorderSide(
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormInputField(
                textAlign: TextAlign.start,
                controller: _phoneController,
                hintText: 'Contact Number',
                keyboardType: TextInputType.phone,
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
              const SizedBox(height: 10.0),
              TextFormInputField(
                textAlign: TextAlign.start,
                controller: _locationController,
                hintText: 'Your Location',
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
              const SizedBox(height: 10.0),
              TextFormInputField(
                textAlign: TextAlign.start,
                controller: _bioController,
                hintText: 'Write about yourself',
                maxLines: 7,
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
              const SizedBox(height: 15.0),
              //  ModifiedButton(
              //         text: _editingIndex == null
              //             ? 'ADD SERVICE'
              //             : 'UPDATE SERVICE',
              //         color: AppColorConstant.adminPrimaryColor,
              //         textColor: AppColorConstant.white,
              //         press: (_submitForm)),
              ModifiedButton(
                  text: 'UPDATE SERVICE',
                  color: AppColorConstant.adminPrimaryColor,
                  textColor: AppColorConstant.white,
                  press: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
