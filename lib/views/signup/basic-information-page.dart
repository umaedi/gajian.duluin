import 'package:duluin_app/controllers/auth-controller.dart';
import 'package:duluin_app/controllers/companies-controller.dart';
import 'package:duluin_app/controllers/user-controller.dart';
import 'package:duluin_app/models/companies-model.dart';
import 'package:duluin_app/models/user-model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../contants/color.dart';
import '../../data/relation-item.dart';
import '../../services/currency-formatter.dart';

class BasicInformationPage extends StatefulWidget {
  const BasicInformationPage({super.key});

  @override
  State<BasicInformationPage> createState() => _BasicInformationPageState();
}

class _BasicInformationPageState extends State<BasicInformationPage> {
  final GlobalKey<FormFieldState> _dropdownRelationKey =
      GlobalKey<FormFieldState>();

  // TextEditingController
  TextEditingController fullNameController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthPlaceController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emergencyNameController = TextEditingController();
  TextEditingController emergencyRelationController = TextEditingController();
  TextEditingController emergencyPhoneNumberController =
      TextEditingController();

  AuthController authController = AuthController();
  UserController userController = UserController();
  CompaniesController companiesController = CompaniesController();
  UserModel? _userData;
  CompanyInformationModel? _companiesData;

  DateTime selectedDate = DateTime.now();
  String selectedRelation = '';
  bool isLoading = false;

  Future<void> _getInformationData() async {
    UserModel? userData = await userController.currentUserDataService(context);
    CompanyInformationModel? companiesData =
        await companiesController.informationCompanyService(context);
    setState(() {
      _userData = userData;
      _companiesData = companiesData;

      // TextEditingController
      fullNameController.text = _userData?.name ?? '';
      identityNumberController.text = _userData?.nik ?? '';
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

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _getInformationData(),
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
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthDateController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: COLOR_PRIMARY_GREEN,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data Pribadi",
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
                      controller: fullNameController,
                      keyboardType: TextInputType.text,
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
                    child: TextFormField(
                      controller: identityNumberController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        labelText: 'NIK',
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
                      controller: birthPlaceController,
                      keyboardType: TextInputType.text,
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
                    child: TextFormField(
                      controller: addressController,
                      keyboardType: TextInputType.text,
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
                    child: InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          labelText: 'Tanggal Lahir',
                        ),
                        child: Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
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
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
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
                      controller: emergencyNameController,
                      keyboardType: TextInputType.text,
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
                      isExpanded: true,
                      key: _dropdownRelationKey,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      value: selectedRelation.isEmpty ? '' : selectedRelation,
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
                      controller: emergencyPhoneNumberController,
                      keyboardType: TextInputType.phone,
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
                "Information Perusahaan",
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
                  Text(
                    "Nama Perusahaan",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    _companiesData!.companyName ?? '-',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alamat Perusahaan",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    _companiesData?.companyAddress ?? '-',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Information Payroll",
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
                  Text(
                    "Nama Bank",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    _userData?.bankName ?? '-',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rekening Bank",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    _userData?.bankAccountNumber ?? '-',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jumlah Gaji",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    convertStringToCurrency(
                        _userData!.monthlySalary, 'id_ID', 'Rp '),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                width: size.width,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Perhatian !!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: COLOR_PRIMARY_RED,
                            ),
                          ),
                          TextSpan(
                            text:
                                ' Jika anda merasa terdapat kesalahan maupun ingin melakukan pengkinian data pada Informasi Payroll, anda dapat menghubungi kami melalui',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          TextSpan(
                            text: ' kontak resmi duluin.com',
                            style: TextStyle(
                              color: COLOR_PRIMARY_GREEN,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Terms of Service"');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: size.width,
                height: size.height * 0.050,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    authController.basicInformationUpdateService(
                      context,
                      fullNameController.text,
                      identityNumberController.text,
                      birthPlaceController.text,
                      addressController.text,
                      birthDateController.text,
                      phoneNumberController.text,
                      emergencyNameController.text,
                      emergencyPhoneNumberController.text,
                      emergencyRelationController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: COLOR_PRIMARY_GREEN,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "LANJUT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
