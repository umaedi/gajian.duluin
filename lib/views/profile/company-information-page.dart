import 'package:duluin_app/contants/attribute.dart';
import 'package:duluin_app/controllers/account-controller.dart';
import 'package:duluin_app/controllers/companies-controller.dart';
import 'package:duluin_app/models/companies-model.dart';
import 'package:duluin_app/models/user-model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../contants/color.dart';
import '../../services/currency-formatter.dart';
import '../partials/header-navigation.dart';

class CompanyInformationPage extends StatefulWidget {
  const CompanyInformationPage({super.key});

  @override
  State<CompanyInformationPage> createState() => _CompanyInformationPageState();
}

class _CompanyInformationPageState extends State<CompanyInformationPage> {
  AccountController accountController = AccountController();
  CompaniesController companiesController = CompaniesController();
  UserModel? _userDetailModel;
  CompanyInformationModel? _companyDetailModel;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getCompanyInformationData() async {
    CompanyInformationModel? companyInformationData =
        await companiesController.informationCompanyService(context);
    setState(() {
      _companyDetailModel = companyInformationData;
    });
  }

  Future<void> _getPayrollInformationData() async {
    UserModel? informationData =
        await accountController.userAccountDetailService(context);
    setState(() {
      _userDetailModel = informationData;
    });
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _getCompanyInformationData(),
      _getPayrollInformationData(),
    ]);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: true,
        titleText: 'Info Perusahaan',
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
                        _companyDetailModel!.companyName,
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
                        _companyDetailModel!.companyAddress,
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
                        _userDetailModel!.bankName,
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
                        _userDetailModel!.bankAccountNumber,
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
                            _userDetailModel!.monthlySalary, 'id_ID', 'Rp '),
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
                        "Tgl. Gajian",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black45,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        _userDetailModel!.companyPayday,
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
                ],
              ),
            ),
    );
  }
}
