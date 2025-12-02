import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/src/provider/admin/user_provider.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserInfo();
    });
  }

  Future<void> _fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.fetchUserInfo();
    _populateUserInfo();
  }

  void _populateUserInfo() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    if (user != null) {
      setState(() {
        _fullNameController.text = user.data.admin.fname;
        _usernameController.text = user.data.admin.username;
        _emailController.text = user.data.admin.email;
        _phoneController.text = user.data.admin.phoneNumber;
        _bioController.text = user.data.admin.bio ?? '';
        _locationController.text = user.data.admin.location ?? '';

        final imageUrl = user.data.admin.imageUrl;
        if (imageUrl.isNotEmpty) {
          _imageUrl = null;
          selectedFile = 'profile_picture.jpg';
        } else {
          _imageUrl = null;
          selectedFile = '';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    if (userProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

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
                          backgroundColor: Colors.transparent,
                        ),
                ),
              ),
              const SizedBox(height: 10.0),
              const BodyText(text: "Change Your Profile Picture"),
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
              TextFormInputField(
                textAlign: TextAlign.start,
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
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
              const SizedBox(height: 10.0),
              TextFormInputField(
                textAlign: TextAlign.start,
                controller: _phoneController,
                hintText: 'Phone Number',
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
                controller: _bioController,
                hintText: 'Bio',
                maxLines: 3,
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
                hintText: 'Location',
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
              const SizedBox(height: 20.0),
              ModifiedButton(
                color: AppColorConstant.adminMenuColor,
                textColor: AppColorConstant.white,
                press: () {
                  if (_profileFormKey.currentState?.validate() ?? false) {
                    _updateProfile();
                  }
                },
                text: 'UPDATE PROFILE',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.user?.data.admin.id;

    String? uploadedImageUrl;

    // Check if a new image is selected before attempting to upload
    if (_imageUrl != null) {
      uploadedImageUrl =
          await userProvider.uploadAdminImage(_imageUrl!, selectedFile);
    } else {
      // Use the existing image URL if no new image is selected
      uploadedImageUrl = userProvider.user?.data.admin.imageUrl;
    }

    if (userId != null) {
      await userProvider.updateUserInfo(
        id: userId,
        fname: _fullNameController.text,
        username: _usernameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        bio: _bioController.text,
        location: _locationController.text,
        imageUrl: uploadedImageUrl,
      );
      await _fetchUserInfo();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColorConstant.successColor,
          content: Text(
            'Profile updated successfully',
            style: TextStyle(color: AppColorConstant.white),
          ),
        ),
      );
    } else {
      // print('User ID or image URL is null. Unable to update profile.');
    }
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
}
