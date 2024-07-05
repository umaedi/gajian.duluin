import 'package:duluin_app/contants/attribute.dart';
import 'package:duluin_app/contants/routes.dart';
import 'package:duluin_app/controllers/auth-controller.dart';
import 'package:duluin_app/controllers/companies-controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../contants/color.dart';
import '../../data/companies-item.dart';
import '../../models/companies-model.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final ValueNotifier<bool> isLoadingValue = ValueNotifier<bool>(false);

  final TextEditingController nomorKaryawanController = TextEditingController();
  final TextEditingController perusahaanController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmationPasswordController =
      TextEditingController();

  AuthController authController = AuthController();
  CompaniesController companiesController = CompaniesController();

  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;
  bool _isChecked = false;

  List<CompaniesModel>? _companies;
  String? _selectedCompanyId;

  @override
  void initState() {
    super.initState();
    nomorKaryawanController.addListener(_onSearchTextChanged);
    _fetchCompanies();
  }

  void _onSearchTextChanged() {
    String searchText = nomorKaryawanController.text.trim();
    if (searchText.isEmpty) {
      setState(() {
        _selectedCompanyId = null;
      });
    } else {
      setState(() {
        _selectedCompanyId = null;
      });
    }
    _fetchCompanies();
  }

  Future<void> _fetchCompanies() async {
    String searchText = nomorKaryawanController.text.trim();
    if (searchText.isEmpty) {
      setState(() {
        _companies = null;
      });
      return;
    }

    final List<CompaniesModel>? companiesData =
        await companiesController.companiesDataService(context, searchText);

    setState(() {
      _companies = companiesData;
    });
  }

  @override
  void dispose() {
    nomorKaryawanController.removeListener(_onSearchTextChanged);
    nomorKaryawanController.dispose();
    perusahaanController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmationPasswordController.dispose();
    isLoadingValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: BG_PRIMARY_GREY,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Registrasi Akun",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          color: Colors.black,
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            size: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(
          horizontal: SCROLL_PADDING_HORIZONTAL,
          vertical: SCROLL_PADDING_VERTICAL,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
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
                controller: nomorKaryawanController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: 'Nomor Karyawan',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
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
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: _selectedCompanyId,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCompanyId = newValue;
                    perusahaanController.text = newValue!;
                  });
                },
                items: getCopmayItemLists(_companies, size),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: 'Perusahaan',
                  hintText: 'Pilih Perusahaan',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
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
                  labelText: 'Alamat Email',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
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
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: 'No Telp',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
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
                controller: passwordController,
                obscureText: _obscurePassword1,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: 'Password',
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
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
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
                controller: confirmationPasswordController,
                obscureText: _obscurePassword2,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  labelText: 'Confirm Password',
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
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isChecked = !_isChecked;
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: COLOR_PRIMARY_GREEN,
                      value: _isChecked,
                      onChanged: (newValue) {
                        setState(() {
                          _isChecked = newValue!;
                        });
                      },
                    ),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: size.width * 0.035,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                                text: 'Saya telah membaca dan menyetujui '),
                            TextSpan(
                              text: 'Syarat dan Ketentuan Pengguna',
                              style: TextStyle(
                                color: COLOR_PRIMARY_GREEN,
                                fontSize: size.width * 0.035,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, termConditionPageRoute);
                                },
                            ),
                            const TextSpan(text: ' serta '),
                            TextSpan(
                              text: 'Kebijakan Privasi',
                              style: TextStyle(
                                color: COLOR_PRIMARY_GREEN,
                                fontSize: size.width * 0.035,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, privacyPolicyPageRoute);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: size.width,
              height: size.height * 0.050,
              margin: const EdgeInsets.only(top: 20),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: nomorKaryawanController,
                builder: (context, nomorKaryawanValue, child) {
                  return ValueListenableBuilder<TextEditingValue>(
                    valueListenable: perusahaanController,
                    builder: (context, perusahaanValue, child) {
                      return ValueListenableBuilder<TextEditingValue>(
                        valueListenable: emailController,
                        builder: (context, emailValue, child) {
                          return ValueListenableBuilder<TextEditingValue>(
                            valueListenable: phoneController,
                            builder: (context, phoneValue, child) {
                              return ValueListenableBuilder<TextEditingValue>(
                                valueListenable: passwordController,
                                builder: (context, passwordValue, child) {
                                  return ValueListenableBuilder<
                                      TextEditingValue>(
                                    valueListenable:
                                        confirmationPasswordController,
                                    builder: (context,
                                        confirmationPasswordValue, child) {
                                      bool isButtonEnabled =
                                          nomorKaryawanValue.text.isNotEmpty &&
                                              perusahaanValue.text.isNotEmpty &&
                                              emailValue.text.isNotEmpty &&
                                              phoneValue.text.isNotEmpty &&
                                              passwordValue.text.isNotEmpty &&
                                              confirmationPasswordValue
                                                  .text.isNotEmpty &&
                                              _isChecked;

                                      return ValueListenableBuilder<bool>(
                                        valueListenable: isLoadingValue,
                                        builder: (context, loading, child) {
                                          return ElevatedButton(
                                            onPressed: isButtonEnabled &&
                                                    !loading
                                                ? () async {
                                                    isLoadingValue.value = true;
                                                    await authController
                                                        .registerService(
                                                      context,
                                                      nomorKaryawanController
                                                          .text,
                                                      perusahaanController.text,
                                                      emailController.text,
                                                      phoneController.text,
                                                      passwordController.text,
                                                      confirmationPasswordController
                                                          .text,
                                                    );
                                                    isLoadingValue.value =
                                                        false;
                                                  }
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  COLOR_PRIMARY_GREEN,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: loading
                                                ? const CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Colors.white,
                                                    ),
                                                  )
                                                : const Text(
                                                    "DAFTAR",
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
