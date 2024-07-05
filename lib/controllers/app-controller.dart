import 'package:duluin_app/handler/api-handler.dart';
import 'package:flutter/cupertino.dart';

import '../contants/constant.dart';
import '../models/app-model.dart';
import '../views/partials/snackbar-alert.dart';

class AppController {
  var dio = getMainApiHandler();

  Future<AppModel?> getAppUpdateService(BuildContext context) async {
    try {
      final response = await dio.get(
        APP_UPDATE_ENDPOINT,
      );

      final Map<String, dynamic> responseData = response.data;

      return AppModel.fromJson(responseData);
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
