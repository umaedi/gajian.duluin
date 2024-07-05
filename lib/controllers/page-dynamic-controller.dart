import 'package:duluin_app/contants/constant.dart';
import 'package:flutter/material.dart';

import '../handler/api-handler.dart';
import '../views/partials/snackbar-alert.dart';

class PageDynamicController {
  var dio = getBaseApiHandler();

  Future<Map<String, dynamic>?> pageTermCondition(BuildContext context) async {
    try {
      final response = await dio.get(
        TERM_CONDITION_PAGE,
      );

      var data = response.data;

      return data;
    } catch (error) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Internal Server Error",
      );
      return null;
    }
  }

  Future<Map<String, dynamic>?> pagePrivacyPolicy(BuildContext context) async {
    try {
      final response = await dio.get(
        PRIVACY_POLICY_PAGE,
      );

      var data = response.data;

      return data;
    } catch (error) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Internal Server Error",
      );
      return null;
    }
  }
}
