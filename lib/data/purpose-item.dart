import 'package:flutter/material.dart';

final List<DropdownMenuItem<String>> purposeItems = [
  DropdownMenuItem(
    value: '',
    child: Text(
      'Pilih Tujuan Penarikan',
      style: TextStyle(
        color: Colors.grey.shade600,
      ),
    ),
  ),
  DropdownMenuItem(
    value: 'Kebutuhan Belanja',
    child: Text('Kebutuhan Belanja'),
  ),
  DropdownMenuItem(
    value: 'Kebutuhan Rumah Tangga',
    child: Text('Kebutuhan Rumah Tangga'),
  ),
  DropdownMenuItem(
    value: 'Pembayaran Cicilan',
    child: Text('Pembayaran Cicilan'),
  ),
  DropdownMenuItem(
    value: 'Lainnya',
    child: Text('Lainnya'),
  ),
];
