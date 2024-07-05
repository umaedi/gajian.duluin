import 'dart:io';

import 'package:dio/dio.dart';
import 'package:duluin_app/controllers/user-controller.dart';
import 'package:duluin_app/views/partials/snackbar-alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../contants/constant.dart';
import '../contants/routes.dart';
import '../handler/api-handler.dart';
import '../models/auth-model.dart';
import '../models/user-model.dart';
import '../views/widgets/success-recovery.dart';
import '../views/widgets/success-signup.dart';

class AuthController {
  var dio = getBaseApiHandler();

  UserController userController = UserController();

  Future<void> registerService(
    BuildContext context,
    String employeeIdInput,
    String companyIdInput,
    String emailInput,
    String phoneInput,
    String passwordInput,
    String passwordConfirmationInput,
  ) async {
    if (passwordInput != passwordConfirmationInput) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Konfirmasi Password harus sama",
      );
      return;
    }

    final response = await dio.post(
      SIGNUP_AUTH_CUSTOMER,
      options: Options(
        validateStatus: (status) => true,
      ),
      data: {
        "phone_number": phoneInput,
        "company_id": companyIdInput,
        "employee_id_card": employeeIdInput,
        "email": emailInput,
        "password": passwordInput,
        "password_confirmation": passwordConfirmationInput,
      },
    );

    print("ahgshjags: ${response.statusCode}");
    print("ahgshjags: ${response.data}");

    final Map<String, dynamic> responseData = response.data;

    if (response.statusCode == 201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessSignupPage(),
        ),
      );
    } else {
      String errorMessage = "Unknown error occurred";
      if (responseData.containsKey('message')) {
        var message = responseData['message'];
        if (message is Map) {
          if (message.containsKey('message')) {
            errorMessage = message['message'] ?? errorMessage;
          } else {
            message.forEach((key, value) {
              if (value is List && value.isNotEmpty && value[0] is String) {
                errorMessage = value[0];
                return;
              }
            });
          }
        } else if (message is String) {
          errorMessage = message;
        }
      }

      showSnackbarAlert(
        context,
        true,
        false,
        errorMessage,
      );
    }
  }

  Future<void> loginService(BuildContext context, String emailPhoneInput,
      String passwordInput) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await dio.post(
        SIGNIN_AUTH_CUSTOMER,
        data: {
          'email': emailPhoneInput,
          'password': passwordInput,
        },
      );

      final Map<String, dynamic> responseData = response.data;
      AuthModel authModel = AuthModel.fromJson(responseData);

      await prefs.setString('access_token', authModel.accessToken);
      await prefs.setString('token_type', authModel.typeToken);

      UserModel? userData =
          await userController.currentUserDataService(context);

      if (userData?.isEmailVerified == 0) {
        sendEmailOTP(context, userData!.id);

        Navigator.pushNamed(context, verifyEmailPageRoute);
      } else {
        if (userData?.isApproved == "signup") {
          Navigator.pushNamed(
            context,
            identityUploadPageRoute,
            arguments: {'initialPage': 0},
          );

          return;
        }
        Navigator.popAndPushNamed(
          context,
          bottomNavRoute,
          arguments: {'initialPage': 0},
        );
      }
    } catch (error) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Invalid Email or Password",
      );
    }
  }

  Future<void> changePasswordService(
    BuildContext context,
    String oldPasswordInput,
    String newPasswordInput,
    String confirmationPasswordInput,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (newPasswordInput != confirmationPasswordInput) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Konfirmasi Password harus sama",
      );
      return;
    }

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.post(
        CHANGE_PASSWORD_AUTH_CUSTOMER,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: {
          'old_password': oldPasswordInput,
          'password': newPasswordInput,
          'password_confirmation': confirmationPasswordInput,
        },
      );

      showSnackbarAlert(
        context,
        true,
        true,
        "Password berhasil diubah",
      );

      Navigator.pop(context);
    } catch (error) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Failed change password",
      );
    }
  }

  Future<void> forgotPasswordService(
    BuildContext context,
    String emailInput,
  ) async {
    try {
      final response = await dio.post(
        FORGOT_PASSWORD_AUTH_CUSTOMER,
        data: {
          'email': emailInput,
        },
      );

      showSnackbarAlert(
        context,
        true,
        true,
        "Berhasil mengirim reset password ke email anda",
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SuccessRecovery(),
        ),
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Email tidak ditemukan",
      );
    }
  }

  Future<void> logoutService(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      String? accessToken = prefs.getString("access_token");

      final response = await dio.post(
        SIGNOUT_AUTH_CUSTOMER,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      clearAuthSession();

      Navigator.pushNamedAndRemoveUntil(
        context,
        signinRoute,
        (Route<dynamic> route) => false,
      );
    } catch (error) {
      clearAuthSession();

      Navigator.pushNamedAndRemoveUntil(
        context,
        signinRoute,
        (Route<dynamic> route) => false,
      );
    }
  }

  Future<String> sendEmailOTP(BuildContext context, String userId) async {
    try {
      final response = await dio.post(
        SEND_OTP_ENDPOINT,
        data: {
          "id": userId,
        },
      );

      showSnackbarAlert(
        context,
        true,
        true,
        "Berhasil mengirim OTP ke email anda",
      );

      return "Success send OTP";
    } catch (error) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Gagal mengirim OTP ke email anda",
      );

      return "Failed send OTP";
    }
  }

  Future<String> sendWhatsappOTP(BuildContext context, String userId) async {
    try {
      final response = await dio.post(
        SEND_OTP_WHATSAPP_ENDPOINT,
        data: {
          "id": userId,
        },
      );

      showSnackbarAlert(
        context,
        true,
        true,
        "Berhasil mengirim OTP ke whatsapp anda",
      );

      return "Success send OTP";
    } catch (error) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Gagal mengirim OTP ke nomor Whatsapp anda",
      );

      return "Failed send OTP";
    }
  }

  Future<void> verifyEmailOTP(BuildContext context, String otpInput) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("access_token");

    try {
      final response = await dio.post(
        VERIFY_OTP_ENDPOINT,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: {
          "otp_code": otpInput,
        },
      );

      Navigator.pushReplacementNamed(context, identityUploadPageRoute);
    } catch (error) {
      showSnackbarAlert(
        context,
        true,
        false,
        "OTP yang anda masukan salah",
      );
    }
  }

  Future<bool> uploadPhotoService(
      BuildContext context, File image, String photoType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("access_token");
    bool isSuccess = false;

    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      'name': photoType,
      'file': await MultipartFile.fromFile(image.path, filename: fileName),
    });

    final response = await dio.post(
      IDENTITY_UPLOAD_CUSTOMER,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        validateStatus: (status) => true,
      ),
      data: formData,
    );

    UserModel? userData = await userController.currentUserDataService(context);

    if (photoType == 'ktp_photo') {
      if (response.statusCode == 201) {
        isSuccess = true;

        showSnackbarAlert(
          context,
          true,
          true,
          "Identitas berhasil diupload",
        );
      } else {
        isSuccess = true;

        showSnackbarAlert(
          context,
          true,
          false,
          "KTP tidak terlihat dengan jelas, silahkan isi manual dibawah ini",
        );
      }
    } else {
      isSuccess = true;

      showSnackbarAlert(
        context,
        true,
        true,
        "Selfie berhasil diupload",
      );
    }

    return isSuccess;
  }

  Future<void> basicInformationUpdateService(
    BuildContext context,
    String nameInput,
    String nikInput,
    String birthdayAddressInput,
    String addressInput,
    String birthdayDateInput,
    String phoneInput,
    String emergencyNameInput,
    String emergencyPhoneNumberInput,
    String emergencyRelationInput,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("access_token");

    try {
      final response = await dio.post(
        BASIC_INFORMATION_UPDATE_CUSTOMER,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: {
          "name": nameInput,
          "nik": nikInput,
          "birthday_address": birthdayAddressInput,
          "address": addressInput,
          "birthday_date": birthdayDateInput,
          "phone_number": phoneInput,
          "emergency_name": emergencyNameInput,
          "emergency_phone_number": emergencyPhoneNumberInput,
          "emergency_relation": emergencyRelationInput,
        },
      );

      UserModel? userData =
          await userController.currentUserDataService(context);

      Navigator.pushNamed(context, selfieUploadPageRoute);
    } catch (error) {
      showSnackbarAlert(
        context,
        true,
        false,
        "Gagal update basic information",
      );
    }
  }

  Future<String> checkHasLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("access_token");

    if (accessToken == null || accessToken.isEmpty) {
      print("No access token found, redirecting to signinRoute");
      return signinRoute;
    }

    try {
      final response = await dio.get(
        CURRENT_USER_CUSTOMER,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 401) {
        print(
            "Received 401 status code, clearing session and redirecting to signinRoute");
        clearAuthSession();
        return signinRoute;
      }

      UserModel? userData =
          await userController.currentUserDataService(context);

      if (userData?.isApproved != "signup") {
        print("User is approved, redirecting to bottomNavRoute");
        return bottomNavRoute;
      } else {
        print(
            "User is not approved, clearing session and redirecting to signinRoute");
        clearAuthSession();
        return signinRoute;
      }
    } catch (e) {
      print("Error during authentication check: $e");
      clearAuthSession();
      return signinRoute;
    }
  }

  Future<void> clearAuthSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('token_type');
  }
}
