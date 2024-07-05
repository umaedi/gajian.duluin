import 'package:duluin_app/contants/attribute.dart';
import 'package:duluin_app/controllers/auth-controller.dart';
import 'package:flutter/material.dart';

import '../../contants/color.dart';
import '../../controllers/user-controller.dart';
import '../../models/user-model.dart';
import '../partials/header-navigation.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final ValueNotifier<bool> isLoadingValue = ValueNotifier<bool>(false);

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmationPasswordController =
      TextEditingController();

  UserController userController = UserController();
  AuthController authController = AuthController();
  UserModel? _userData;

  bool isLoading = false;
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;
  bool _obscurePassword3 = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getUserData() async {
    UserModel? userData = await userController.currentUserDataService(context);
    setState(() {
      _userData = userData;
    });
  }

  Future loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _getUserData(),
    ]);

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmationPasswordController.dispose();
    isLoadingValue.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: true,
        titleText: 'Ubah Password',
        isTitleText: true,
        isShowNotificationButton: true,
        isCenterTitle: true,
        sizeImage: 0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: COLOR_PRIMARY_GREEN,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: SCROLL_PADDING_HORIZONTAL,
                vertical: SCROLL_PADDING_VERTICAL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width,
                    child: Card(
                      elevation: 2.5,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userData!.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: COLOR_PRIMARY_GREEN,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              _userData!.email,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Change Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: oldPasswordController,
                          obscureText: _obscurePassword1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            labelText: 'Password Lama',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword1 = !_obscurePassword1;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: newPasswordController,
                          obscureText: _obscurePassword2,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword2 = !_obscurePassword2;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextFormField(
                          controller: confirmationPasswordController,
                          obscureText: _obscurePassword3,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            labelText: 'Ulangi Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword3
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword3 = !_obscurePassword3;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: size.width,
                    height: size.height * 0.050,
                    margin: const EdgeInsets.only(top: 20),
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: oldPasswordController,
                      builder: (context, oldPasswordValue, child) {
                        return ValueListenableBuilder<TextEditingValue>(
                          valueListenable: newPasswordController,
                          builder: (context, newPasswordValue, child) {
                            return ValueListenableBuilder<TextEditingValue>(
                              valueListenable: confirmationPasswordController,
                              builder:
                                  (context, confirmationPasswordValue, child) {
                                bool isButtonEnabled = oldPasswordValue
                                        .text.isNotEmpty &&
                                    newPasswordValue.text.isNotEmpty &&
                                    confirmationPasswordValue.text.isNotEmpty;

                                return ValueListenableBuilder<bool>(
                                  valueListenable: isLoadingValue,
                                  builder: (context, loading, child) {
                                    return ElevatedButton(
                                      onPressed: isButtonEnabled && !loading
                                          ? () async {
                                              isLoadingValue.value = true;
                                              await authController
                                                  .changePasswordService(
                                                context,
                                                oldPasswordController.text,
                                                newPasswordController.text,
                                                confirmationPasswordController
                                                    .text,
                                              );
                                              isLoadingValue.value = false;
                                            }
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: COLOR_PRIMARY_GREEN,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: loading
                                          ? CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                            )
                                          : const Text(
                                              "PERBAHARUI",
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
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
