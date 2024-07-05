import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contants/constant.dart';
import '../handler/api-handler.dart';
import '../models/account-model.dart';
import '../models/user-model.dart';

class AccountController {
  var dio = getBaseApiHandler();

  Future<AccountModel?> accountDataService(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.get(
        EMPLOYEE_ACCOUNT_CUSTOMER,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final Map<String, dynamic> responseData = response.data;

      return AccountModel.fromJson(responseData);
    } catch (error) {
      print("Error fetching data: $error");
      return null;
    }
  }

  Future<UserModel?> userAccountDetailService(BuildContext context) async {
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

      return UserModel.fromJson(responseData);
    } catch (error) {
      print("Error fetching data: $error");
      return null;
    }
  }
}
