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
  final _phoneController = TextEditingController();

  String? _selectedRole;
  final List<Member> _member = [];
  int? _editingIndex;

  final List<String> _memberRole = [
    'All Rounder',
    'Makeup Artist',
    'Hairstylist',
    'Henna Artist',
    'Saree Draper'
  ];

  void _submitForm() {
    if (_memberFormKey.currentState!.validate() &&
        _selectedRole != null &&
        _image != null) {
      setState(() {
        if (_editingIndex == null) {
          _member.add(Member(
            image: _image!,
            name: _nameController.text,
            phone: _phoneController.text,
            role: _selectedRole!,
          ));
        } else {
          _member[_editingIndex!] = Member(
            image: _image!,
            name: _nameController.text,
            phone: _phoneController.text,
            role: _selectedRole!,
          );
          _editingIndex = null;
        }
        _image = null;
        _nameController.clear();
        _phoneController.clear();
        _selectedRole = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Member Added Successfully')),
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
      _image = _member[index].image;
      _nameController.text = _member[index].name;
      _phoneController.text = _member[index].phone;
      _selectedRole = _member[index].role;
    });
  }

  void _deleteMember(int index) {
    setState(() {
      _member.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Member Deleted Successfully')),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _memberFormKey,
              child: ListView(
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    "Manage Glam Team",
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
                    '"Select an image of the member to upload"',
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
                    hintText: " Enter Glam Team Member Name",
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
                    text: "Member Phone Number",
                    textAlign: TextAlign.left,
                    size: 16,
                    fontWeight: ResponsiveWidget.isSmallScreen(context)
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  TextFormInputField(
                    textAlign: TextAlign.left,
                    controller: _phoneController,
                    hintText: "Enter Glam Team Member Phone Number",
                    keyboardType: TextInputType.number,
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
                  ..._memberRole.map((role) => RadioListTile<String>(
                        title: BodyText(
                          textAlign: TextAlign.left,
                          text: role,
                        ),
                        value: role,
                        groupValue: _selectedRole,
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value;
                          });
                        },
                      )),
                  const SizedBox(height: 20),
                  ModifiedButton(
                      text: _editingIndex == null
                          ? 'ADD MEMBER'
                          : 'UPDATE MEMBER',
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
                  "Displayed Members",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _member.isEmpty
                      ? const Center(child: Text("No members added"))
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Image')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Phone')),
                              DataColumn(label: Text('Role')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: _member.asMap().entries.map((entry) {
                              int index = entry.key;
                              Member member = entry.value;
                              return DataRow(cells: [
                                DataCell(Image.memory(member.image,
                                    width: 50, height: 50)),
                                DataCell(
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 200),
                                    child: Text(
                                      member.name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                DataCell(Text('\$${member.phone}')),
                                DataCell(Text(member.role)),
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

class Member {
  final Uint8List image;
  final String name;
  final String phone;
  final String role;

  Member({
    required this.image,
    required this.name,
    required this.phone,
    required this.role,
  });
}
