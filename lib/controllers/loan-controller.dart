import 'package:dio/dio.dart';
import 'package:duluin_app/controllers/auth-controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contants/constant.dart';
import '../handler/api-handler.dart';
import '../models/loan-model.dart';
import '../views/partials/snackbar-alert.dart';
import '../views/widgets/success-withdraw.dart';

class LoanController {
  AuthController authController = AuthController();

  var dio = getBaseApiHandler();

  Future<List<LoanModel>?> loanDataService(
      BuildContext context, String paramLoan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.get(
        "$LOAN_CUSTOMER?status=$paramLoan",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final List<dynamic> responseData = response.data['data']['loans'];

      List<LoanModel> loans =
          responseData.map((data) => LoanModel.fromJson(data)).toList();

      return loans;
    } catch (error) {
      authController.checkHasLogin(context);
      return null;
    }
  }

  Future<List<LoanModel>?> loanListService(BuildContext context) async {
    AuthController authController = AuthController();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.get(
        LOAN_HISTORY_CUSTOMER,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final List<dynamic> responseData = response.data['data']['loans'];

      List<LoanModel> loans =
          responseData.map((data) => LoanModel.fromJson(data)).toList();

      return loans;
    } catch (error) {
      authController.checkHasLogin(context);
      return null;
    }
  }

  Future<LoanModel?> loanDetailService(
      BuildContext context, String loanId) async {
    AuthController authController = AuthController();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.get(
        "$LOAN_CUSTOMER/detail?id=$loanId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      final Map<String, dynamic> responseData = response.data['data'];

      return LoanModel.fromJson(responseData);
    } catch (error) {
      authController.checkHasLogin(context);
      return null;
    }
  }

  Future<void> createWithdrawService(
    BuildContext context,
    String loanAmountInput,
    String pointValueInput,
    String loanPurposeInput,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String resultData = '';

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.post(
        EMPLOYEE_WITHDRAW_CUSTOMER,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: {
          'loan_amount': loanAmountInput,
          'point': pointValueInput,
          'loan_purpose': loanPurposeInput,
        },
      );

      final Map<String, dynamic> responseData = response.data;

      if (!responseData.containsKey('data')) {
        resultData = responseData['message'];

        showSnackbarAlert(
          context,
          true,
          false,
          resultData,
        );

        return;
      } else {
        resultData = responseData['data']['id'];

        showSnackbarAlert(
          context,
          true,
          true,
          "Berhasil tarik gaji",
        );

        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessWithdrawPage(
              loanId: resultData,
              loanAmount: int.parse(loanAmountInput),
            ),
          ),
        );
      }
    } catch (error) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Failed withdraw",
      );
    }
  }
}
