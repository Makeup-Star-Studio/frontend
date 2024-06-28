import 'package:flutter/material.dart';

class AboutServices {
  final int? id;
  final String? title, price;
  final IconData? editButton, dltButton;

  AboutServices({this.id, this.title, this.price, this.editButton, this.dltButton});
}

List demoServicesPricing = [
  AboutServices(
    id: 1,
    title: "Bridal Makeup",
    price: "\$500",
    editButton: Icons.edit,
    dltButton: Icons.delete,
  ),
  AboutServices(
    id: 2,
    title: "Figma File",
    price: "\$500",
    editButton: Icons.edit,
    dltButton: Icons.delete,
  ),
  AboutServices(
    id: 3,
    title: "Document",
    price: "\$500",
    editButton: Icons.edit,
    dltButton: Icons.delete,
  ),
  AboutServices(
    id: 4,
    title: "Sound File",
    price: "\$500",
    editButton: Icons.edit,
    dltButton: Icons.delete,
  ),
  AboutServices(
    id: 5,
    title: "Media File",
    price: "\$500",
    editButton: Icons.edit,
    dltButton: Icons.delete,
  ),
  AboutServices(
    id: 6,
    title: "Sales PDF",
    price: "\$500",
    editButton: Icons.edit,
    dltButton: Icons.delete,
  ),
  AboutServices(
    id: 7,
    title: "Excel File",
    price: "\$500",
    editButton: Icons.edit,
    dltButton: Icons.delete,
  ),
];