import 'package:duluin_app/contants/color.dart';
import 'package:flutter/material.dart';

void showSnackbarAlert(BuildContext context, bool isShowCloseIcon,
    bool isSuccessAlertColor, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: isShowCloseIcon,
      duration: Duration(seconds: 5),
      backgroundColor:
          isSuccessAlertColor ? COLOR_PRIMARY_GREEN : COLOR_PRIMARY_RED,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(15),
      elevation: 25,
      content: Text(message),
    ),
  );
}
