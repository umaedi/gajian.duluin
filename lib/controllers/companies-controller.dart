import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contants/constant.dart';
import '../handler/api-handler.dart';
import '../models/companies-model.dart';

class CompaniesController {
  var dio = getBaseApiHandler();

  Future<List<CompaniesModel>?> companiesDataService(
      BuildContext context, String employeeIdCard) async {
    try {
      final response = await dio.get(
        "$COMPANIES_ENDPOINT?employee_id_card=$employeeIdCard",
      );

      final List<dynamic> responseData = response.data['data'];

      List<CompaniesModel> companies =
          responseData.map((data) => CompaniesModel.fromJson(data)).toList();

      return companies;
    } catch (error) {
      print("Error fetching data: $error");
      return null;
    }
  }

  Future<CompanyInformationModel?> informationCompanyService(
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.get(
        EMPLOYEE_ACCOUNT_USER_CUSTOMER,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final Map<String, dynamic> responseData = response.data['data'];

      return CompanyInformationModel.fromJson(responseData);
    } catch (error) {
      print("Error fetching data: $error");
      return null;
    }
  }
}
