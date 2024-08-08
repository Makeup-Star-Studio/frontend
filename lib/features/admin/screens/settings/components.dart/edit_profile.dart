import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/src/provider/admin/user_provider.dart';
import 'package:provider/provider.dart'; // Ensure provider package is imported

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
    await userProvider.fetchUserInfo('66b3796a543fdd2a8139fe32');
    _populateUserInfo();
  }

void _populateUserInfo() {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final user = userProvider.user;
  if (user != null) {
    setState(() {
      _fullNameController.text = user.data.user.fname;
      _usernameController.text = user.data.user.username;
      _emailController.text = user.data.user.email;
      _phoneController.text = user.data.user.phoneNumber;
      _bioController.text = user.data.user.bio;
      _locationController.text = user.data.user.location;

      final imageUrl = user.data.user.imageUrl;
      if (imageUrl.isNotEmpty) {
        // Handle image URL
        // You might want to fetch the image data from the URL instead
        _imageUrl = null; // You need to handle this differently if imageUrl is a URL
        selectedFile = 'profile_picture.jpg'; // Default name if image is present
      } else {
        _imageUrl = null; // No image
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_profileFormKey.currentState?.validate() ?? false) {
                      _updateProfile();
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.updateUserInfo(
      id: '66b3796a543fdd2a8139fe32', // Replace with the actual user ID
      fname: _fullNameController.text,
      username: _usernameController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      bio: _bioController.text,
      location: _locationController.text,
      imageBytes: _imageUrl,
      imageName: selectedFile,
    );
    // Optionally fetch user info again to reflect updates
    await _fetchUserInfo();
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
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
