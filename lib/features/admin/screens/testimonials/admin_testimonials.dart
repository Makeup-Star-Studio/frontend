import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/src/model/testimonial_model.dart';
import 'package:makeupstarstudio/src/provider/testimonial/testimonial_provider.dart';
import 'package:provider/provider.dart';

class AdminTestimonialsView extends StatefulWidget {
  const AdminTestimonialsView({super.key});

  @override
  State<AdminTestimonialsView> createState() => _AdminTestimonialsViewState();
}

class _AdminTestimonialsViewState extends State<AdminTestimonialsView> {
  final _testimonialKey = GlobalKey<FormState>();
  String selectedFile = '';
  Uint8List? _reviewImageUrl;
  final _firstNamController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _reviewController = TextEditingController();
  int? _editingIndex;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TestimonialProvider>(context, listen: false)
          .fetchTestimonial();
    });
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        setState(() {
          _reviewImageUrl = result.files.single.bytes;
          selectedFile = result.files.single.name;
        });
      }
    } catch (e) {
      print("File picker error: $e");
    }
  }

  Future<void> _submitForm() async {
    if (_testimonialKey.currentState!.validate() &&
        (_reviewImageUrl != null || _editingIndex != null)) {
      String? uploadedImageUrl;
      if (_reviewImageUrl != null) {
        uploadedImageUrl =
            await Provider.of<TestimonialProvider>(context, listen: false)
                .uploadReviewImage(
                    imageBytes: _reviewImageUrl!, imageName: selectedFile);
      }

      // Ensure an image URL exists when adding a new testimonial
      if (uploadedImageUrl == null && _editingIndex == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Image upload failed. Please try again.')),
        );
        return;
      }

      if (_editingIndex == null) {
        // Add testimonial
        // print('Attempting to post testimonial...');
        // print('First Name: ${_firstNamController.text}');
        // print('Last Name: ${_lastNameController.text}');
        // print('Review: ${_reviewController.text}');
        // print('Image URL: $uploadedImageUrl');

        try {
          await Provider.of<TestimonialProvider>(context, listen: false)
              .postTestimonial(
            fname: _firstNamController.text,
            lname: _lastNameController.text,
            review: _reviewController.text,
            reviewImage: uploadedImageUrl!, // Use the uploaded image URL here
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: AppColorConstant.successColor,
                content: Text(
                  'Testimonial Added Successfully',
                  style: TextStyle(color: AppColorConstant.white),
                )),
          );
          _clearForm();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: AppColorConstant.errorColor,
                content: Text(
                  'Failed to add testimonial',
                  style: TextStyle(color: AppColorConstant.white),
                )),
          );
          print('Error posting testimonial: $e');
        }
      } else {
        // Update testimonial
        final testimonial =
            Provider.of<TestimonialProvider>(context, listen: false)
                .testimonials[_editingIndex!];

        // If no new image is uploaded, retain the existing one
        String updatedImageUrl =
            uploadedImageUrl ?? testimonial.reviewImage;

        // print('Attempting to update testimonial...');
        // print('Testimonial ID: ${testimonial.id}');
        // print('Updated First Name: ${_firstNamController.text}');
        // print('Updated Last Name: ${_lastNameController.text}');
        // print('Updated Review: ${_reviewController.text}');
        // print('Updated Image URL: $updatedImageUrl');

        try {
          await Provider.of<TestimonialProvider>(context, listen: false)
              .updateTestimonial(
            testimonial.id,
            Testimonial(
              id: testimonial.id,
              fname: _firstNamController.text,
              lname: _lastNameController.text,
              review: _reviewController.text,
              reviewImage: updatedImageUrl,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: AppColorConstant.successColor,
                content: Text(
                  'Testimonial Updated Successfully',
                  style: TextStyle(color: AppColorConstant.white),
                )),
          );
          _clearForm();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: AppColorConstant.errorColor,
                content: Text(
                  'Failed to update testimonial',
                  style: TextStyle(color: AppColorConstant.white),
                )),
          );
          print('Error updating testimonial: $e');
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: AppColorConstant.warningColor,
            content: Text(
              'Please fill all fields and upload an image',
              style: TextStyle(color: AppColorConstant.white),
            )),
      );
    }
  }

  void _clearForm() {
    setState(() {
      _firstNamController.clear();
      _lastNameController.clear();
      _reviewController.clear();
      _editingIndex = null;
    });
  }

  void _editTestimonial(int index) {
    final testimonial = Provider.of<TestimonialProvider>(context, listen: false)
        .testimonials[index];

    setState(() {
      _firstNamController.text = testimonial.fname;
      _lastNameController.text = testimonial.lname;
      _reviewController.text = testimonial.review;
      // Optionally load the existing image
      // _reviewImageUrl = ...;
      _editingIndex = index;
    });
  }

  void _deleteTestimonial(int index) async {
    final testimonial = Provider.of<TestimonialProvider>(context, listen: false)
        .testimonials[index];
    final id = testimonial.id;

    final shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content:
              const Text('Are you sure you want to delete this testimonial?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete) {
      await Provider.of<TestimonialProvider>(context, listen: false)
          .deleteTestimonial(id)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Testimonial Deleted Successfully')),
        );
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete testimonial')),
        );
        print('Error: $e');
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
  void dispose() {
    _firstNamController.dispose();
    _lastNameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(context),
      mediumScreen: _buildSmallScreen(context),
      smallScreen: _buildSmallScreen(context),
    );
  }

  Widget _buildLargeScreen(BuildContext context) {
    return Stack(
      children:[ Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _testimonialKey,
                child: ListView(
                  children: [
                    const Text(
                      textAlign: TextAlign.center,
                      "Manage Testimonials",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _pickImage,
                      child: _reviewImageUrl == null
                          ? Container(
                              height: 400,
                              color: Colors.grey[200],
                              child: const Icon(Icons.add_a_photo, size: 100),
                            )
                          : Image.memory(
                              _reviewImageUrl!,
                              height: 500,
                              fit: BoxFit.contain,
                            ),
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      '"Select an image of the client to upload"',
                      style: TextStyle(
                        color: AppColorConstant.adminPrimaryColor,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    BodyText(
                      text: "First Name",
                      textAlign: TextAlign.left,
                      size: 16,
                      fontWeight: ResponsiveWidget.isSmallScreen(context)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    TextFormInputField(
                      textAlign: TextAlign.left,
                      controller: _firstNamController,
                      hintText: " Enter Client First Name",
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
                      text: "Last Name",
                      textAlign: TextAlign.left,
                      size: 16,
                      fontWeight: ResponsiveWidget.isSmallScreen(context)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    TextFormInputField(
                      textAlign: TextAlign.left,
                      controller: _lastNameController,
                      hintText: " Enter Client Last Name",
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
                      text: "Review",
                      textAlign: TextAlign.left,
                      size: 16,
                      fontWeight: ResponsiveWidget.isSmallScreen(context)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    TextFormInputField(
                      maxLines: 5,
                      textAlign: TextAlign.left,
                      controller: _reviewController,
                      hintText:
                          "Write or copy a review given by a client from google review",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        } else if (value.length < 10) {
                          return 'Review must be more than 10  characters';
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
                        text: _editingIndex == null
                            ? 'ADD TESTIMONIAL'
                            : 'UPDATE TESTIMONIAL',
                        color: AppColorConstant.adminPrimaryColor,
                        textColor: AppColorConstant.white,
                        press: _submitForm),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading) _buildLoader(),
      /* ---------------------- Displayed Testimonials ---------------------- */
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<TestimonialProvider>(
                builder: (context, testimonialProvider, child) {
                  final testimonials = testimonialProvider.testimonials;
                  return Column(
                    children: [
                      const Text(
                        "Displayed Testimonials",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: testimonials.isEmpty
                            ? const Center(child: Text("No testimonials added"))
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
                                  columns: const [
                                    DataColumn(label: Text('Image')),
                                    DataColumn(label: Text('First Name')),
                                    DataColumn(label: Text('Last Name')),
                                    DataColumn(label: Text('Review')),
                                    DataColumn(label: Text('Actions')),
                                  ],
                                  rows: testimonials.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    Testimonial testimonial = entry.value;
                                    return DataRow(cells: [
                                      // ignore: unnecessary_null_comparison
                                      DataCell(testimonial.reviewImage == null
                                          ? const Icon(Icons.image)
                                          : Image.network(
                                              'https://makeup-star-studio.sfo2.digitaloceanspaces.com/${testimonial.reviewImage}',
      
                                              // '${ApiConstant.localUrl}/testimonial/${testimonials[index].reviewImage}',
                                              width: 50,
                                              height: 50)),
                                      DataCell(Text(testimonial.fname)),
                                      DataCell(Text(testimonial.lname)),
                                      DataCell(
                                        ConstrainedBox(
                                          constraints:
                                              const BoxConstraints(maxWidth: 200),
                                          child: Text(
                                            testimonial.review,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      DataCell(Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            color: AppColorConstant.successColor,
                                            onPressed: () =>
                                                _editTestimonial(index),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            color: AppColorConstant.errorColor,
                                            onPressed: () =>
                                                _deleteTestimonial(index),
                                          ),
                                        ],
                                      )),
                                    ]);
                                  }).toList(),
                                ),
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
      if (_isLoading) _buildLoader(),
      ],
    );
  }

/*---------------------- Small Screen ---------------------- */
  Widget _buildSmallScreen(BuildContext context) {
    return Stack(
      children:[ SingleChildScrollView(
        child: Column(
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
                      'Manage Testimonials',
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
                key: _testimonialKey,
                child: Column(
                  children: [
                    const Text(
                      "Post Testimonials",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: _pickImage,
                      child: _reviewImageUrl == null
                          ? Container(
                              width: 500,
                              height: 500,
                              color: Colors.grey[200],
                              child: const Icon(Icons.add_a_photo, size: 100),
                            )
                          : Image.memory(_reviewImageUrl!, fit: BoxFit.cover),
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      '"Select an image of the client to upload"',
                      style: TextStyle(
                        color: AppColorConstant.adminPrimaryColor,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const BodyText(
                      text: "First Name",
                      textAlign: TextAlign.left,
                      size: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    TextFormInputField(
                      textAlign: TextAlign.left,
                      controller: _firstNamController,
                      hintText: " Enter Client First Name",
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
                    const BodyText(
                      text: "Last Name",
                      textAlign: TextAlign.left,
                      size: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    TextFormInputField(
                      textAlign: TextAlign.left,
                      controller: _lastNameController,
                      hintText: " Enter Client Last Name",
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
                    const BodyText(
                      text: "Review",
                      textAlign: TextAlign.left,
                      size: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    TextFormInputField(
                      maxLines: 5,
                      textAlign: TextAlign.left,
                      controller: _reviewController,
                      hintText:
                          "Write or copy a review given by a client from google review",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        } else if (value.length < 10) {
                          return 'Review must be more than 10 characters';
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
                        text: _editingIndex == null
                            ? 'ADD TESTIMONIAL'
                            : 'UPDATE TESTIMONIAL',
                        color: AppColorConstant.adminPrimaryColor,
                        textColor: AppColorConstant.white,
                        press: _submitForm),
                  ],
                ),
              ),
            ),
            if (_isLoading) _buildLoader(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<TestimonialProvider>(
                builder: (context, testimonialProvider, child) {
                  final testimonials = testimonialProvider.testimonials;
                  return Column(
                    children: [
                      const Text(
                        "Displayed Testimonials",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      testimonials.isEmpty
                          ? const Center(child: Text("No testimonials added"))
                          :
                          // final testimonial = testimonials[index];
                          DataTable(
                              columns: const [
                                DataColumn(label: Text('Image')),
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Review')),
                                DataColumn(label: Text('Actions')),
                              ],
                              rows: testimonials.asMap().entries.map((entry) {
                                int index = entry.key;
                                Testimonial testimonial = entry.value;
                                return DataRow(cells: [
                                  // ignore: unnecessary_null_comparison
                                  DataCell(testimonial.reviewImage == null
                                      ? const Icon(Icons.image)
                                      : Image.network(
                                          'https://makeup-star-studio.sfo2.digitaloceanspaces.com/${testimonial.reviewImage}',
      
                                          // '${ApiConstant.localUrl}/testimonial/${testimonials[index].reviewImage}',
                                          width: 50,
                                          height: 50)),
                                  DataCell(Text(
                                      "${testimonial.fname} ${testimonial.lname}")),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 200),
                                      child: Text(
                                        testimonial.review,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: AppColorConstant.successColor,
                                        onPressed: () => _editTestimonial(index),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: AppColorConstant.errorColor,
                                        onPressed: () =>
                                            _deleteTestimonial(index),
                                      ),
                                    ],
                                  )),
                                ]);
                              }).toList(),
                            ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      if (_isLoading) _buildLoader(),
      ],
    );
  }
}
