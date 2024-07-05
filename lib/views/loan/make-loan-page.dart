import 'package:duluin_app/contants/attribute.dart';
import 'package:duluin_app/controllers/loan-controller.dart';
import 'package:duluin_app/controllers/user-controller.dart';
import 'package:duluin_app/models/user-model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../contants/color.dart';
import '../../controllers/account-controller.dart';
import '../../controllers/companies-controller.dart';
import '../../controllers/page-dynamic-controller.dart';
import '../../data/contract-loan-page.dart';
import '../../data/dynamic-page.dart';
import '../../data/purpose-item.dart';
import '../../models/account-model.dart';
import '../../models/companies-model.dart';
import '../../services/currency-formatter.dart';
import '../../services/currency-input-formatter.dart';
import '../partials/header-navigation.dart';
import '../partials/snackbar-alert.dart';

class MakeLoanPage extends StatefulWidget {
  const MakeLoanPage({super.key});

  @override
  State<MakeLoanPage> createState() => _MakeLoanPageState();
}

class _MakeLoanPageState extends State<MakeLoanPage> {
  final ValueNotifier<bool> isLoadingValue = ValueNotifier<bool>(false);
  final GlobalKey<FormFieldState> _dropdownPurposeKey =
      GlobalKey<FormFieldState>();

  TextEditingController loanTextEditing = TextEditingController();
  TextEditingController purposeTextEditing = TextEditingController();

  PageDynamicController pageController = PageDynamicController();
  AccountController accountController = AccountController();
  UserController userController = UserController();
  CompaniesController companiesController = CompaniesController();
  LoanController loanController = LoanController();

  AccountModel? _accountData;
  UserModel? _userData;
  CompanyInformationModel? _companiesData;

  String selectedPurpose = '';
  bool isLoading = false;
  bool isCheckedTerms = false;
  bool isSwitchPoint = false;
  late Map<String, dynamic> pageData;

  int loanAmount = 0;
  int adminFee = 0;
  int platformFee = 0;
  int pointFee = 0;
  int totalLoan = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getAccountData() async {
    AccountModel? accountData =
        await accountController.accountDataService(context);
    UserModel? userData = await userController.currentUserDataService(context);
    CompanyInformationModel? companiesData =
        await companiesController.informationCompanyService(context);

    setState(() {
      _accountData = accountData;
      _userData = userData;
      _companiesData = companiesData;
    });
  }

  Future<void> loadDynamicPage() async {
    var data = await pageController.pageTermCondition(context);
    if (data != null) {
      setState(() {
        pageData = data['data'];
      });
    }
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _getAccountData(),
      loadDynamicPage(),
    ]);

    if (_accountData != null) {
      String defaultFeeValue = _accountData!.defaultCost;
      String loanInputValue =
          convertStringToCurrency(_accountData!.loanMinAmount, 'id_ID', 'Rp ');

      loanTextEditing.text = loanInputValue;

      int loanAdminFee = int.parse(_accountData!.loanAdminFee);
      double platformFeePercentage =
          double.parse(_accountData!.loanPlatformFee);
      int pointValue = _accountData!.pointValue;

      await calculationLoan(
        defaultFeeValue,
        loanInputValue,
        loanAdminFee,
        platformFeePercentage,
        pointValue,
      );
    }

    setState(() => isLoading = false);
  }

  Future<void> calculationLoan(
    String defaultFeeValue,
    String loanInputValue,
    int loanAdminFee,
    double platformFeePercentage,
    int pointValue,
  ) async {
    setState(() => isLoading = true);

    String loanAmountText = loanInputValue;
    loanAmountText = loanAmountText.replaceAll('Rp ', '');
    loanAmountText = loanAmountText.replaceAll('.', '');
    loanAmountText = loanAmountText.replaceAll(',', '');

    loanAmount = int.tryParse(loanAmountText) ?? 0;
    adminFee = loanAdminFee;
    platformFee = (loanAmount * platformFeePercentage).toInt();
    pointFee = 0;

    print("hjkhasah: $loanAmount");

    if (isSwitchPoint) {
      totalLoan = loanAmount - adminFee - platformFee + pointFee;
    } else {
      totalLoan = loanAmount - adminFee - platformFee + 0;
    }

    // if (defaultFeeValue == 'loan_platform_fee') {
    //   totalLoan = int.parse(calculateWithPlatformFee(
    //     loanAmount.toString(),
    //     adminFee,
    //     platformFee,
    //     isSwitchPoint ? pointValue : 0,
    //   ));
    // } else if (defaultFeeValue == 'loan_interest') {
    //   totalLoan = int.parse(calculateWithInterest(
    //     loanAmount.toString(),
    //     adminFee,
    //     platformFee,
    //     isSwitchPoint ? pointValue : 0,
    //   ));
    // }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    loanTextEditing.dispose();
    purposeTextEditing.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const HeaderNavigationAppbar(
        isShowBackButton: true,
        titleText: 'Penarikan Gaji',
        isTitleText: true,
        isShowNotificationButton: false,
        isCenterTitle: true,
        sizeImage: 0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: COLOR_PRIMARY_GREEN,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: SCROLL_PADDING_VERTICAL,
                horizontal: SCROLL_PADDING_HORIZONTAL,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: TextFormField(
                      controller: loanTextEditing,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      onFieldSubmitted: (valueLoanInput) async {
                        String? removeFormatCurrency =
                            valueLoanInput.replaceAll(RegExp(r'[^0-9]'), '');

                        if (int.parse(removeFormatCurrency) <
                            int.parse(_accountData!.loanMinAmount)) {
                          loanTextEditing.text = convertStringToCurrency(
                              _accountData!.loanMinAmount, 'id_ID', 'Rp ');
                          loanTextEditing.selection =
                              TextSelection.fromPosition(
                            TextPosition(offset: loanTextEditing.text.length),
                          );

                          await calculationLoan(
                            _accountData!.defaultCost,
                            _accountData!.loanMinAmount,
                            int.parse(_accountData!.loanAdminFee),
                            double.parse(_accountData!.loanPlatformFee),
                            _accountData!.pointValue,
                          );

                          showSnackbarAlert(
                            context,
                            true,
                            false,
                            "Pastikan tidak bisa kurang dari batas minimal",
                          );
                          return;
                        }

                        if (int.parse(removeFormatCurrency) >
                            int.parse(_accountData!.loanMaxAmount)) {
                          loanTextEditing.text = convertStringToCurrency(
                              _accountData!.loanMinAmount, 'id_ID', 'Rp ');
                          loanTextEditing.selection =
                              TextSelection.fromPosition(
                            TextPosition(offset: loanTextEditing.text.length),
                          );

                          await calculationLoan(
                            _accountData!.defaultCost,
                            _accountData!.loanMinAmount,
                            int.parse(_accountData!.loanAdminFee),
                            double.parse(_accountData!.loanPlatformFee),
                            _accountData!.pointValue,
                          );

                          showSnackbarAlert(
                            context,
                            true,
                            false,
                            "Pastikan tidak bisa lebih dari batas maksimal",
                          );
                          return;
                        }

                        calculationLoan(
                          _accountData!.defaultCost,
                          valueLoanInput,
                          int.parse(_accountData!.loanAdminFee),
                          double.parse(_accountData!.loanPlatformFee),
                          _accountData!.pointValue,
                        );
                      },
                      onChanged: (String valueLoanInput) {
                        if (valueLoanInput != valueLoanInput) {
                          valueLoanInput = valueLoanInput;
                          loanTextEditing.text = valueLoanInput;
                          loanTextEditing.selection =
                              TextSelection.fromPosition(
                            TextPosition(offset: loanTextEditing.text.length),
                          );
                        } else {
                          loanTextEditing.text = valueLoanInput;
                        }
                      },
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.055,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        const TextInputFormatter.withFunction(
                            currencyInputFormatter),
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: convertStringToCurrency(
                            _accountData!.loanMinAmount, 'id_ID', 'Rp '),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Limit tersedia: ${convertStringToCurrency(_accountData!.loanCreditAmount, 'id_ID', 'Rp ')}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Biaya Admin",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: COLOR_PRIMARY_GREEN,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        adminFee != 0
                            ? convertIntegerToCurrency(adminFee, 'id_ID', 'Rp ')
                            : 'Rp 0',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Biaya Platform",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: COLOR_PRIMARY_GREEN,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        platformFee != 0
                            ? convertIntegerToCurrency(
                                platformFee, 'id_ID', 'Rp ')
                            : 'Rp 0',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total ${convertIntegerToCurrency(pointFee, 'id_ID', 'Rp ')} Poin",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: COLOR_PRIMARY_GREEN,
                              fontSize: 16,
                            ),
                          ),
                          Transform.scale(
                            scale: size.width * 0.0015,
                            child: Switch(
                                value: isSwitchPoint,
                                activeColor: Colors.white,
                                activeTrackColor: COLOR_PRIMARY_ORANGE,
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: Colors.white,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      isSwitchPoint = value;
                                    },
                                  );
                                }),
                          )
                        ],
                      ),
                      Expanded(
                        child: Text(
                          isSwitchPoint
                              ? "-${convertIntegerToCurrency(pointFee, 'id_ID', 'Rp ')}"
                              : 'Rp 0',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: isSwitchPoint
                                ? COLOR_PRIMARY_ORANGE
                                : Colors.grey.shade800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Diterima",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: COLOR_PRIMARY_GREEN,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        loanTextEditing.text.isNotEmpty
                            ? convertIntegerToCurrency(
                                isSwitchPoint
                                    ? pointFee + totalLoan
                                    : totalLoan,
                                'id_ID',
                                'Rp ')
                            : 'Rp 0',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tujuan Penarikan",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
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
                      key: _dropdownPurposeKey,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      value: selectedPurpose.isEmpty ? '' : selectedPurpose,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPurpose = newValue!;
                          purposeTextEditing.text = newValue;
                        });
                      },
                      items: purposeItems,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 25,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isCheckedTerms = !isCheckedTerms;
                        });
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: COLOR_PRIMARY_GREEN,
                            value: isCheckedTerms,
                            onChanged: (newValue) {
                              setState(() {
                                isCheckedTerms = newValue!;
                              });
                            },
                          ),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: size.width * 0.035,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'DISCLAIMER! ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const TextSpan(
                                      text:
                                          'Saya telah membaca dan menyetujui '),
                                  TextSpan(
                                    text: 'Syarat dan Ketentuan',
                                    style: const TextStyle(
                                      color: COLOR_PRIMARY_GREEN,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        modalTermCondition(
                                            context, pageData['content']);
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
                      valueListenable: loanTextEditing,
                      builder: (context, loanInputValue, child) {
                        return ValueListenableBuilder<String?>(
                          valueListenable:
                              ValueNotifier<String?>(selectedPurpose),
                          builder: (context, purposeValue, child) {
                            bool isButtonEnabled = isCheckedTerms;

                            return ValueListenableBuilder<bool>(
                              valueListenable: isLoadingValue,
                              builder: (context, loading, child) {
                                return ElevatedButton(
                                  onPressed: isButtonEnabled && !loading
                                      ? () async {
                                          if (selectedPurpose.isEmpty) {
                                            showSnackbarAlert(
                                              context,
                                              true,
                                              false,
                                              "Tujuan Penarikan harus dipilih",
                                            );
                                            _dropdownPurposeKey.currentState
                                                ?.didChange(selectedPurpose);
                                            return;
                                          } else {
                                            isLoadingValue.value = true;
                                            modalWDTermCondition(
                                              context,
                                              _accountData,
                                              _companiesData,
                                              _userData,
                                              loanAmount,
                                              totalLoan,
                                              pointFee,
                                              purposeValue!,
                                              isSwitchPoint,
                                            );
                                            isLoadingValue.value = false;
                                          }
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
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          "TARIK SEKARANG",
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
                ],
              ),
            ),
    );
  }
}
