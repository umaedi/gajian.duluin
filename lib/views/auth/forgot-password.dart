import 'package:duluin_app/contants/attribute.dart';
import 'package:duluin_app/contants/color.dart';
import 'package:duluin_app/controllers/auth-controller.dart';
import 'package:flutter/material.dart';

import '../../contants/assets.dart';
import '../partials/header-navigation.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final ValueNotifier<bool> isLoadingValue = ValueNotifier<bool>(false);

  AuthController authController = AuthController();

  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    isLoadingValue.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        titleText: ASSET_DULUIN_GAJIAN,
        isTitleText: false,
        isShowBackButton: true,
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
            children: [
              const Text(
                "Masukan alamat email yang terdaftar untuk melakukan reset password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 25,
                  bottom: 20,
                ),
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
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    labelText: 'Email',
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height * 0.050,
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: emailController,
                  builder: (context, emailValue, child) {
                    return ElevatedButton(
                      onPressed: emailValue.text.isNotEmpty
                          ? () async {
                              isLoadingValue.value = true;
                              await authController.forgotPasswordService(
                                  context, emailController.text);
                              isLoadingValue.value = false;
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: COLOR_PRIMARY_GREEN,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: isLoadingValue,
                        builder: (context, isLoading, child) {
                          return isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                )
                              : const Text(
                                  "LUPA PASSWORD",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
