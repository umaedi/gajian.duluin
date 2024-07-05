import 'package:flutter/material.dart';

import '../models/companies-model.dart';

List<DropdownMenuItem<String>> getCopmayItemLists(
    List<CompaniesModel>? _companies, Size size) {
  return [
    DropdownMenuItem<String>(
      value: null,
      child: Text(
        "Pilih Perusahaan Anda",
        style: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),
    ),
    ...(_companies?.map<DropdownMenuItem<String>>((company) {
          return DropdownMenuItem<String>(
            value: company.company_id,
            child: Text(
              company.company_name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: size.width * 0.045,
              ),
            ),
          );
        }).toList() ??
        []),
  ];
}
