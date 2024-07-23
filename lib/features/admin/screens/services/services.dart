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
  final List<Service> _services = [];
  int? _editingIndex;

  final List<String> _categories = [
    'Bridal',
    'Makeup',
    'Hair',
    'Henna',
    'Draping'
  ];

  void _submitForm() {
    if (_servicesFormKey.currentState!.validate() &&
        _selectedCategory != null &&
        _image != null) {
      setState(() {
        if (_editingIndex == null) {
          _services.add(Service(
            image: _image!,
            title: _titleController.text,
            price: double.parse(_priceController.text),
            category: _selectedCategory!.toLowerCase(),
          ));
        } else {
          _services[_editingIndex!] = Service(
            image: _image!,
            title: _titleController.text,
            price: double.parse(_priceController.text),
            category: _selectedCategory!.toLowerCase(),
          );
          _editingIndex = null;
        }
        _image = null;
        _titleController.clear();
        _priceController.clear();
        _selectedCategory = null;
      });
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

  void _editService(int index) {
    setState(() {
      _editingIndex = index;
      _image = _services[index].image;
      _titleController.text = _services[index].title;
      _priceController.text = _services[index].price.toString();
      _selectedCategory = _services[index].category;
    });
  }

  void _deleteService(int index) {
    setState(() {
      _services.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Service Deleted Successfully')),
    );
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
    return Row(
      children: [
        Expanded(
          child: Padding(
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
                        : Image.memory(_image!,
                            height: 500, fit: BoxFit.contain),
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
                      try {
                        double.parse(value);
                      } catch (_) {
                        return 'Please enter a valid number';
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
                      text: _editingIndex == null
                          ? 'ADD SERVICE'
                          : 'UPDATE SERVICE',
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
                  "Displayed Services",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _services.isEmpty
                      ? const Center(child: Text("No services added"))
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Image')),
                              DataColumn(label: Text('Title')),
                              DataColumn(label: Text('Price')),
                              DataColumn(label: Text('Category')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: _services.asMap().entries.map((entry) {
                              int index = entry.key;
                              Service service = entry.value;
                              return DataRow(cells: [
                                DataCell(Image.memory(service.image,
                                    width: 50, height: 50)),
                                DataCell(
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 200),
                                    child: Text(
                                      service.title,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataCell(Text('\$${service.price.toString()}')),
                                DataCell(Text(service.category)),
                                DataCell(Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () => _editService(index),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () => _deleteService(index),
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

class Service {
  final Uint8List image;
  final String title;
  final double price;
  final String category;

  Service({
    required this.image,
    required this.title,
    required this.price,
    required this.category,
  });
}
