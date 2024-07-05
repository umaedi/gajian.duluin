import 'package:duluin_app/contants/attribute.dart';
import 'package:duluin_app/data/relation-item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../contants/color.dart';
import '../../controllers/user-controller.dart';
import '../../models/user-model.dart';
import '../partials/header-navigation.dart';

class AccountSettingPage extends StatefulWidget {
  const AccountSettingPage({super.key});

  @override
  State<AccountSettingPage> createState() => _AccountSettingPageState();
}

class _AccountSettingPageState extends State<AccountSettingPage> {
  final ValueNotifier<bool> isLoadingValue = ValueNotifier<bool>(false);
  final GlobalKey<FormFieldState> _dropdownRelationKey =
      GlobalKey<FormFieldState>();

  // TextEditingController
  TextEditingController addressController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emergencyNameController = TextEditingController();
  TextEditingController emergencyRelationController = TextEditingController();
  TextEditingController emergencyPhoneNumberController =
      TextEditingController();

  DateTime selectedDate = DateTime.now();

  UserController userController = UserController();
  UserModel? _userData;

  String selectedRelation = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getUserData() async {
    UserModel? userData = await userController.currentUserDataService(context);
    setState(() {
      _userData = userData;

      // TextEditingController
      addressController.text = _userData?.address ?? '';
      birthPlaceController.text = _userData?.birthdayAddress ?? '';
      birthDateController.text = _userData?.birthdayDate ?? '';
      phoneNumberController.text = _userData?.phoneNumber ?? '';
      emergencyNameController.text = _userData?.emergencyName ?? '';
      emergencyRelationController.text = _userData?.emergencyRelation ?? '';
      emergencyPhoneNumberController.text =
          _userData?.emergencyPhoneNumber ?? '';

      selectedRelation = _userData?.emergencyRelation ?? '';
    });
  }

  Future loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _getUserData(),
    ]);

    setState(() => isLoading = false);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  @override
  void dispose() {
    super.dispose();
    isLoadingValue.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: true,
        titleText: 'Pengaturan Akun',
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
                    "Information Pengguna",
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
                          keyboardType: TextInputType.text,
                          controller: addressController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            labelText: 'Alamat Tinggal',
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
                          keyboardType: TextInputType.text,
                          controller: birthPlaceController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            labelText: 'Tempat Lahir',
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
                        child: InkWell(
                          onTap: () => _selectDate(context),
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: birthDateController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                labelText: 'Tanggal Lahir',
                              ),
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
                          keyboardType: TextInputType.phone,
                          controller: phoneNumberController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Kontak Darurat",
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
                          keyboardType: TextInputType.text,
                          controller: emergencyNameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            labelText: 'Nama Lengkap',
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
                        child: DropdownButtonFormField<String>(
                          key: _dropdownRelationKey,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          value:
                              selectedRelation.isEmpty ? '' : selectedRelation,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRelation = newValue!;
                              emergencyRelationController.text = newValue;
                            });
                          },
                          items: relationItems,
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
                          keyboardType: TextInputType.phone,
                          controller: emergencyPhoneNumberController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: size.width,
                    height: size.height * 0.050,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ValueListenableBuilder<bool>(
                      valueListenable: isLoadingValue,
                      builder: (context, loading, child) {
                        return ElevatedButton(
                          onPressed: !loading
                              ? () async {
                                  isLoadingValue.value = true;
                                  await userController.updateProfileService(
                                    context,
                                    addressController.text,
                                    birthPlaceController.text,
                                    birthDateController.text,
                                    phoneNumberController.text,
                                    emergencyNameController.text,
                                    emergencyRelationController.text,
                                    emergencyPhoneNumberController.text,
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
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                )
                              : const Text(
                                  "SIMPAN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
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
