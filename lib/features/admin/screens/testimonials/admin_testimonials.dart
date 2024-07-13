import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';

class AdminTestimonialsView extends StatefulWidget {
  const AdminTestimonialsView({super.key});
  @override
  State<AdminTestimonialsView> createState() => _AdminTestimonialsViewState();
}

class _AdminTestimonialsViewState extends State<AdminTestimonialsView> {
  final _testimonialKey = GlobalKey<FormState>();
  String selectedFile = '';
  Uint8List? _reviewImage;
  final _firstNamController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _reviewController = TextEditingController();

  final List<Testimonial> _review = [];
  int? _editingIndex;

  void _submitForm() {
    if (_testimonialKey.currentState!.validate() && _reviewImage != null) {
      setState(() {
        if (_editingIndex == null) {
          _review.add(Testimonial(
            reviewImage: _reviewImage!,
            fname: _firstNamController.text,
            lname: _lastNameController.text,
            review: _reviewController.text,
          ));
        } else {
          _review[_editingIndex!] = Testimonial(
            reviewImage: _reviewImage!,
            fname: _firstNamController.text,
            lname: _lastNameController.text,
            review: _reviewController.text,
          );
          _editingIndex = null;
        }
        _reviewImage = null;
        _firstNamController.clear();
        _lastNameController.clear();
        _reviewController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Testimonial Added Successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and upload an image')),
      );
    }
  }

  void _editMember(int index) {
    setState(() {
      _editingIndex = index;
      _reviewImage = _review[index].reviewImage;
      _firstNamController.text = _review[index].fname;
      _lastNameController.text = _review[index].lname;
      _reviewController.text = _review[index].review;
    });
  }

  void _deleteMember(int index) {
    setState(() {
      _review.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Testimonial Deleted Successfully')),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNamController.dispose();
    _lastNameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        setState(() {
          _reviewImage = result.files.first.bytes;
        });
      }
    } catch (e) {
      print("File picker error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    child: _reviewImage == null
                        ? Container(
                            height: 400,
                            color: Colors.grey[200],
                            child: const Icon(Icons.add_a_photo, size: 100),
                          )
                        : Image.memory(_reviewImage!,
                            height: 500, fit: BoxFit.contain),
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
                      } else if (value.length < 10 || value.length > 500) {
                        return 'Review must be between 10 and 500 characters';
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                  child: _review.isEmpty
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
                            rows: _review.asMap().entries.map((entry) {
                              int index = entry.key;
                              Testimonial review = entry.value;
                              return DataRow(cells: [
                                DataCell(Image.memory(review.reviewImage,
                                    width: 50, height: 50)),
                                DataCell(
                                  Text(review.fname),
                                ),
                                DataCell(Text(review.lname)),
                                DataCell(
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 200),
                                    child: Text(
                                      maxLines: 2,
                                      review.review,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () => _editMember(index),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => _deleteMember(index),
                                    ),
                                  ],
                                )),
                              ]);
                            }).toList(),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Testimonial {
  final Uint8List reviewImage;
  final String fname;
  final String lname;
  final String review;

  Testimonial({
    required this.reviewImage,
    required this.fname,
    required this.lname,
    required this.review,
  });
}
