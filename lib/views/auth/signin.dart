import 'package:duluin_app/contants/assets.dart';
import 'package:duluin_app/contants/attribute.dart';
import 'package:duluin_app/contants/routes.dart';
import 'package:duluin_app/controllers/auth-controller.dart';
import 'package:duluin_app/views/partials/header-navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../contants/color.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final ValueNotifier<bool> isLoadingValue = ValueNotifier<bool>(false);

  TextEditingController emailPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthController authController = AuthController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailPhoneController.dispose();
    passwordController.dispose();
    isLoadingValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: HeaderNavigationAppbar(
        titleText: ASSET_DULUIN_GAJIAN,
        isTitleText: false,
        isShowBackButton: false,
        isCenterTitle: true,
        isShowNotificationButton: false,
        sizeImage: size.width * 0.070,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: SCROLL_PADDING_HORIZONTAL,
            vertical: SCROLL_PADDING_VERTICAL,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  "Masuk Akun",
                  style: TextStyle(
                    fontSize: size.width * 0.050,
                    fontWeight: FontWeight.bold,
                    color: COLOR_PRIMARY_GREEN,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: const Border(
                    left: BorderSide(
                      width: 5,
                      color: COLOR_PRIMARY_GREEN,
                    ),
                  ),
                ),
                child: TextFormField(
                  controller: emailPhoneController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    labelText: 'Email atau Nomor Telp',
                  ),
                  onFieldSubmitted: (value) {
                    emailPhoneController.clear();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: const Border(
                      left: BorderSide(
                        width: 5,
                        color: COLOR_PRIMARY_GREEN,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      emailPhoneController.clear();
                    },
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, forgotPasswordRoute);
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.resolveWith(
                    (states) => Colors.transparent,
                  ),
                ),
                child: const Text(
                  "Lupa password anda ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: COLOR_PRIMARY_GREEN,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.050,
                margin: const EdgeInsets.only(top: 20),
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: emailPhoneController,
                  builder: (context, emailPhoneValue, child) {
                    return ValueListenableBuilder<TextEditingValue>(
                      valueListenable: passwordController,
                      builder: (context, passwordValue, child) {
                        bool isButtonEnabled =
                            emailPhoneValue.text.isNotEmpty &&
                                passwordValue.text.isNotEmpty;

                        return ValueListenableBuilder<bool>(
                          valueListenable: isLoadingValue,
                          builder: (context, loading, child) {
                            return ElevatedButton(
                              onPressed: isButtonEnabled && !loading
                                  ? () async {
                                      isLoadingValue.value = true;
                                      await authController.loginService(
                                        context,
                                        emailPhoneController.text,
                                        passwordController.text,
                                      );
                                      isLoadingValue.value = false;
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: COLOR_PRIMARY_GREEN,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: loading
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "MASUK",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                "Anda belum memiliki akun ?",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, signupRoute);
                },
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.resolveWith(
                    (states) => Colors.transparent,
                  ),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Daftar sekarang",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: COLOR_PRIMARY_GREEN,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      FontAwesomeIcons.arrowRight,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
