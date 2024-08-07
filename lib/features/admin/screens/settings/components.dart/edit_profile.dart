import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/features/booking/widget/validator.dart';
import 'package:makeupstarstudio/src/provider/auth/login_provider.dart';
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
      final provider = Provider.of<LoginProvider>(context, listen: false);
      provider.fetchUserInfo(provider.id);
        });
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

  Future<void> _submitForm() async {
    if (_profileFormKey.currentState?.validate() ?? false) {
      final provider = Provider.of<LoginProvider>(context, listen: false);

      if (provider.user.isNotEmpty) {
        final id = provider.user[0].id; // Assuming you have a single user

        await provider.updateuserInfo(
          id: id ?? '',
          fname: _fullNameController.text,
          username: _usernameController.text,
          email: _emailController.text,
          phoneNumber: _phoneController.text,
          bio: _bioController.text,
          location: _locationController.text,
          imageBytes: _imageUrl,
          imgSource: selectedFile,
        ).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColorConstant.successColor,
              content: Text(
                'Profile Updated Successfully',
                style: TextStyle(color: AppColorConstant.white),
              ),
            ),
          );
          _clearForm();
        }).catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColorConstant.errorColor,
              content: Text(
                'Failed to update profile',
                style: TextStyle(color: AppColorConstant.white),
              ),
            ),
          );
          print('Error: $e');
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColorConstant.errorColor,
          content: Text(
            'Please fill all fields and upload an image if required',
            style: TextStyle(color: AppColorConstant.white),
          ),
        ),
      );
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
  void dispose() {
    _fullNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<LoginProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.user.isEmpty) {
            return const Center(
              child: Text('No user available.'),
            );
          } else {
            return Padding(
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
                      controller: _bioController,
                      hintText: 'Bio',
                      maxLines: 4,
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
                      press: _submitForm,
                      
                      text:  "Update Profile",
                      ),
        
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
