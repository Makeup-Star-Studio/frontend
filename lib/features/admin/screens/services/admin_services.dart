import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/src/model/services_model.dart';
import 'package:makeupstarstudio/src/provider/services/services_provider.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';
import 'package:provider/provider.dart';

class AdminServicesView extends StatefulWidget {
  const AdminServicesView({super.key});

  @override
  State<AdminServicesView> createState() => _AdminServicesViewState();
}

class _AdminServicesViewState extends State<AdminServicesView> {
  final _servicesFormKey = GlobalKey<FormState>();
  String selectedFile = '';
  Uint8List? _imageUrl;
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategory;
  int? _editingIndex;
  bool _isImageRequired = true;

  final List<String> _categories = [
    'Bridal',
    'Makeup',
    'Hair',
    'Henna',
    'Draping'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ServicesProvider>(context, listen: false).fetchAllServices();
    });
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

  void _submitForm() {
    if (_servicesFormKey.currentState!.validate()) {
      final servicesProvider =
          Provider.of<ServicesProvider>(context, listen: false);

      // Find if a service already exists for the selected category
      final existingService = servicesProvider.services.firstWhere(
        (service) => service.category == _selectedCategory,
        orElse: () => Service(title: '', price: 0, category: '', image: ''),
      );

      // Check if the image is required based on whether an image is already present for the category
      _isImageRequired = existingService.image.isEmpty;

      if (_editingIndex == null) {
        // Adding a new service
        servicesProvider
            .postService(
          title: _titleController.text,
          price: double.parse(_priceController.text),
          category: _selectedCategory!,
          imageBytes: _isImageRequired ? _imageUrl : null,
          imageUrl: _isImageRequired ? selectedFile : existingService.image,
        )
            .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColorConstant.successColor,
              content: Text(
                'Service Added Successfully',
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
                'Failed to add service',
                style: TextStyle(color: AppColorConstant.white),
              ),
            ),
          );
          print('Error: $e');
        });
      } else {
        // Updating an existing service
        final service = servicesProvider.services[_editingIndex!];

        servicesProvider
            .updateService(
          id: service.id ?? '',
          title: _titleController.text,
          price: double.parse(_priceController.text),
          category: _selectedCategory!,
          imageBytes: _imageUrl,
          imageUrl: selectedFile,
        )
            .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColorConstant.successColor,
              content: Text(
                'Service Updated Successfully',
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
                'Failed to update service',
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
      _editingIndex = null;
      _imageUrl = null;
      _titleController.clear();
      _priceController.clear();
      _selectedCategory = null;
      _isImageRequired = true;
    });
  }

  void _editService(int index) {
    final service =
        Provider.of<ServicesProvider>(context, listen: false).services[index];

    setState(() {
      _editingIndex = index;
      _imageUrl = null;
      _titleController.text = service.title;
      _priceController.text = service.price.toString();
      _selectedCategory = service.category;
    });
  }

  void _deleteService(int index) async {
    final service =
        Provider.of<ServicesProvider>(context, listen: false).services[index];
    final id = service.id;

    final shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this service?'),
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
      await Provider.of<ServicesProvider>(context, listen: false)
          .deleteService(id ?? '')
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColorConstant.successColor,
            content: Text('Service Deleted Successfully'),
          ),
        );
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColorConstant.errorColor,
            content: Text('Failed to delete service'),
          ),
        );
        print('Error: $e');
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    super.dispose();
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
                    child: _imageUrl == null
                        ? Container(
                            height: 400,
                            color: Colors.grey[200],
                            child: const Icon(Icons.add_a_photo, size: 100),
                          )
                        : Image.memory(_imageUrl!,
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
                    hintText: "For eg: 5000 or 8000 or 10000 etc.",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      final n = num.tryParse(value);
                      if (n == null) {
                        return '"$value" is not a valid number';
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
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    hint: const Text("Select Category"),
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    validator: (value) => value == null ? 'required' : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: const BorderSide(
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
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
/* ----------------- Services List ----------------- */
        const VerticalDivider(thickness: 2, color: Colors.grey),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<ServicesProvider>(
              builder: (context, serviceProvider, child) {
                final services = serviceProvider.services;
                return Column(
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
                      child: services.isEmpty
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
                                rows: services.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  Service service = entry.value;
                                  return DataRow(cells: [
                                    DataCell(Image.network(
                                        '${ApiConstant.localUrl}/services/${services[index].image}',
                                        width: 50,
                                        height: 50)),
                                    DataCell(
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(maxWidth: 200),
                                        child: Text(
                                          service.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    DataCell(Text(service.price.toString())),
                                    DataCell(Text(service.category)),
                                    DataCell(Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          color: AppColorConstant.successColor,
                                          onPressed: () => _editService(index),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          color: AppColorConstant.errorColor,
                                          onPressed: () =>
                                              _deleteService(index),
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
    );
  }
}
