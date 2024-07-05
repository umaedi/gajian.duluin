import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contants/constant.dart';
import '../handler/api-handler.dart';
import '../models/user-model.dart';
import '../views/partials/snackbar-alert.dart';

class UserController {
  var dio = getBaseApiHandler();

  Future<UserModel?> currentUserDataService(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.get(
        CURRENT_USER_CUSTOMER,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final Map<String, dynamic> responseData = response.data;

      return UserModel.fromJson(responseData);
    } catch (error) {
      print("Error fetching data: $error");
      return null;
    }
  }

  Future<void> updateProfileService(
    BuildContext context,
    String addressInput,
    String birthdayAddressInput,
    String birthdayDateInput,
    String phoneNumberInput,
    String emergencyNameInput,
    String emergencyRelationInput,
    String emergencyPhoneInput,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.post(
        UPDATE_USER_CUSTOMER,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: {
          'address': addressInput,
          'birthday_address': birthdayAddressInput,
          'birthday_date': birthdayDateInput,
          'phone_number': phoneNumberInput,
          'emergency_name': emergencyNameInput,
          'emergency_relation': emergencyRelationInput,
          'emergency_phone_number': emergencyPhoneInput,
        },
      );

      showSnackbarAlert(
        context,
        true,
        true,
        "Data berhasil diubah",
      );

      Navigator.pop(context);
    } catch (error) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Failed update profile",
      );
    }
  }
}
