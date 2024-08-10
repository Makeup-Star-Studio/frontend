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

  Future<void> _submitForm() async {
    if (_servicesFormKey.currentState!.validate() &&
        (_imageUrl != null || _editingIndex != null)) {
      String? uploadedImageUrl;
      if (_imageUrl != null) {
        uploadedImageUrl =
            await Provider.of<ServicesProvider>(context, listen: false)
                .uploadServiceImage(
                     _imageUrl!, selectedFile);
      }

      // Ensure an image URL exists when adding a new testimonial
      if (uploadedImageUrl == null && _editingIndex == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColorConstant.errorColor,
            content: Text(
              'Image upload failed. Please try again.',
              style: TextStyle(color: AppColorConstant.white),
            ),
          ),
        );
        return;
      }

      if (_editingIndex == null) {
        // Add testimonial
        print('Attempting to post testimonial...');
        print('Title: ${_titleController.text}');
        print('Price: ${_priceController.text}');
        print('Category: $_selectedCategory');
        print('Image URL: $uploadedImageUrl');

        try {
          await Provider.of<ServicesProvider>(context, listen: false)
              .postService(
            title: _titleController.text,
            price: double.parse(_priceController.text),
            category: _selectedCategory!,
            image: uploadedImageUrl!,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColorConstant.successColor,
              content: Text(
                'Services Added Successfully',
                style: TextStyle(color: AppColorConstant.white),
              ),
            ),
          );
          _clearForm();
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColorConstant.errorColor,
              content: Text(
                'Failed to add services',
                style: TextStyle(color: AppColorConstant.white),
              ),
            ),
          );
          print('Error posting services: $e');
        }
      } else {
        // Update service
        final service = Provider.of<ServicesProvider>(context, listen: false)
            .services[_editingIndex!];

        // If no new image is uploaded, retain the existing one
        String updatedImageUrl = uploadedImageUrl ?? service.image!;

        print('Attempting to update service...');
        print('Id: ${service.id}');
        print('Title: ${_titleController.text}');
        print('Price: ${_priceController.text}');
        print('Category: $_selectedCategory');
        print('Image URL: $updatedImageUrl');

        try {
          await Provider.of<ServicesProvider>(context, listen: false)
              .updateService(
            service.id ?? '',
            Service(
              id: service.id,
              title: _titleController.text,
              price: double.parse(_priceController.text),
              category: _selectedCategory!,
              image: updatedImageUrl,
            ),
          );
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
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColorConstant.errorColor,
              content: Text(
                'Failed to update service',
                style: TextStyle(color: AppColorConstant.white),
              ),
            ),
          );
          print('Error updating testimonial: $e');
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColorConstant.errorColor,
          content: Text(
            'Please fill all fields and upload an image',
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
    // Determine if the screen is small or large
    bool isSmallScreen = ResponsiveWidget.isSmallScreen(context);

    // Return the appropriate layout based on screen size
    return isSmallScreen
        ? _buildSmallScreen(context)
        : _buildLargeScreen(context);
  }

  Widget _buildLargeScreen(BuildContext context) {
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
                                    DataCell(services[index].image == null
                                        ? const Icon(Icons.image)
                                        : Image.network(
                                            'https://makeup-star-studio.sfo2.digitaloceanspaces.com/services/${service.image}',
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

/*----------------- Small Screen Layout -----------------*/
  Widget _buildSmallScreen(BuildContext context) {
    return SingleChildScrollView(
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
                    'Manage Service',
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
              key: _servicesFormKey,
              child: Column(
                children: [
                  const Text(
                    "Post Services",
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
                            width: 500,
                            height: 500,
                            color: Colors.grey[200],
                            child: const Icon(Icons.add_a_photo, size: 100),
                          )
                        : Image.memory(_imageUrl!, fit: BoxFit.cover),
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
                  const BodyText(
                    text: "Service Title",
                    textAlign: TextAlign.left,
                    size: 16,
                    fontWeight: FontWeight.bold,
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
                  const BodyText(
                    text: "Service Price",
                    textAlign: TextAlign.left,
                    size: 16,
                    fontWeight: FontWeight.bold,
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
                  const BodyText(
                    text: "Service Category",
                    textAlign: TextAlign.left,
                    size: 16,
                    fontWeight: FontWeight.bold,
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
          const SizedBox(height: 20),
          Padding(
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
                    const SizedBox(height: 5),
                    services.isEmpty
                        ? const Center(child: Text("No services added"))
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: services.length,
                            itemBuilder: (context, index) {
                              final service = services[index];
                              return ListTile(
                                leading: services[index].image == null
                                    ? const Icon(Icons.image)
                                    : Image.network(
                                        'https://makeup-star-studio.sfo2.digitaloceanspaces.com/services/${service.image}',
                                        width: 50,
                                        height: 50),
                                title: Text(service.title),
                                subtitle: Text(
                                    '${service.price} - ${service.category}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: AppColorConstant.successColor,
                                      onPressed: () => _editService(index),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: AppColorConstant.errorColor,
                                      onPressed: () => _deleteService(index),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
