import 'package:flutter/material.dart';

final List<DropdownMenuItem<String>> relationItems = [
  DropdownMenuItem(
    value: '',
    child: Text(
      'Pilih Status Hubungan',
      style: TextStyle(
        color: Colors.grey.shade600,
      ),
    ),
  ),
  DropdownMenuItem(
    value: 'Ayah',
    child: Text('Ayah'),
  ),
  DropdownMenuItem(
    value: 'Ibu',
    child: Text('Ibu'),
  ),
  DropdownMenuItem(
    value: 'Adik Kandung',
    child: Text('Adik Kandung'),
  ),
  DropdownMenuItem(
    value: 'Kakak Kandung',
    child: Text('Kakak Kandung'),
  ),
  DropdownMenuItem(
    value: 'Suami/Istri',
    child: Text('Suami/Istri'),
  ),
];
