import 'package:duluin_app/models/account-model.dart';
import 'package:duluin_app/models/companies-model.dart';
import 'package:duluin_app/models/user-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../contants/attribute.dart';
import '../contants/color.dart';
import '../controllers/loan-controller.dart';
import '../services/currency-formatter.dart';

class ContractTermConditionWDModal extends StatefulWidget {
  final CompanyInformationModel? companiesData;
  final AccountModel? accountData;
  final UserModel? userData;
  final int loanAmount;
  final int totalAmountReceive;
  final int pointFee;
  final String purposeValue;
  final bool isSwitchPoint;

  const ContractTermConditionWDModal({
    Key? key,
    this.accountData,
    this.companiesData,
    this.userData,
    required this.loanAmount,
    required this.totalAmountReceive,
    required this.pointFee,
    required this.purposeValue,
    required this.isSwitchPoint,
  }) : super(key: key);

  @override
  _ContractTermConditionWDModalState createState() =>
      _ContractTermConditionWDModalState();
}

class _ContractTermConditionWDModalState
    extends State<ContractTermConditionWDModal> {
  late WebViewControllerPlus _webController;

  LoanController loanController = LoanController();
  late ScrollController _scrollController;
  bool _isButtonEnabled = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _isButtonEnabled = true;
          });
        }
      });
    loadData();
  }

  double _height = 1.0;

  Future loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _loadHtmlFromAssets(),
    ]);

    setState(() => isLoading = false);
  }

  Future<void> _loadHtmlFromAssets() async {
    final html = await rootBundle
        .loadString('assets/statics/terms_and_conditions_wd.html');
    final formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    final replacedHtml = html
        .replaceAll('<span class="c4 company_name"></span>',
            '<span class="c4 company_name">${widget.accountData?.companyName ?? ''}, </span>')
        .replaceAll(
          '<span class="c4"></span>',
          '<span class="c4">$formattedDate WIB, </span>',
        )
        .replaceAll(
          '<span class="c4 company_address">[ alamat perusahaan ] </span>',
          '<span class="c4 company_address">${widget.companiesData?.companyAddress ?? ''} </span>',
        )
        .replaceAll(
          '<span class="c4 responsible_name">[ responsible name ]</span>',
          '<span class="c4 responsible_name">${widget.companiesData?.responsibleName ?? ''}</span>',
        )
        .replaceAll(
          '<span class="c4 responsible_position">[ responsible position ]</span>',
          '<span class="c4 responsible_position">${widget.companiesData?.responsiblePosition ?? ''}</span>',
        )
        .replaceAll(
          '<span class="c4 name">[ nama pemohon ], </span>',
          '<span class="c4 name">${widget.userData?.name ?? ''}, </span>',
        )
        .replaceAll(
          '<span class="c4 nik">[ nik ]</span>',
          '<span class="c4 nik">${widget.userData?.nik ?? ''}, </span>',
        )
        .replaceAll(
          '<span class="c4 address">[ address ]</span>',
          '<span class="c4 address">${widget.userData?.address ?? ''}, </span>',
        )
        .replaceAll(
          '<span class="c4 employee_id_card">[ employee id card ]</span>',
          '<span class="c4 employee_id_card">${widget.userData?.employeeIdCard ?? ''}, </span>',
        )
        .replaceAll(
          '<span class="c4 loan_max_amount">[ credit balance ]</span>',
          '<span class="c4 loan_max_amount">${convertStringToCurrency(widget.accountData!.loanMaxAmount, 'id_ID', 'Rp ') ?? ''}</span>',
        )
        .replaceAll(
          '<span class="c4 admin_fee">[ Rp biaya admin ] </span>',
          '<span class="c4 admin_fee">${convertStringToCurrency(widget.accountData!.loanAdminFee, 'id_ID', 'Rp ') ?? ''} </span>',
        )
        .replaceAll(
          '<span class="c4 platform_fee">[ platform fee ] </span>',
          '<span class="c4 platform_fee">1.5</span>',
        )
        .replaceAll(
          '<span class="c4 bank_name">[ bank name ]</span>',
          '<span class="c4 bank_name">${widget.userData?.bankName ?? ''}</span>',
        )
        .replaceAll(
          '<span class="c4 bank_account_number">[ bank account number ], </span>',
          '<span class="c4 bank_account_number">${widget.userData?.bankAccountNumber ?? ''}, </span>',
        )
        .replaceAll(
          '<span class="c4 name">[ account name ]</span>',
          '<span class="c4 name">${widget.userData?.name ?? ''}</span>',
        )
        .replaceAll(
          '<span class="c4 total">[ Rp loan amount ] </span>',
          '<span class="c4 total">${convertIntegerToCurrency(widget.totalAmountReceive + (widget.isSwitchPoint ? widget.pointFee : 0), 'id_ID', 'Rp ') ?? ''} </span>',
        )
        .replaceAll(
          '<span class="small"><br />Tanggal Pemohon WIB</span>',
          '<span class="small"><br />$formattedDate</span>',
        )
        .replaceAll(
          '<span class="c4 name">[ pemohon ]</span>',
          '<span class="c4 name">${widget.userData?.name ?? ''}</span>',
        )
        .replaceAll(
          '<span class="c4 responsible_name">[ perusahaan ]</span>',
          '<span class="c4 name">${widget.companiesData?.responsibleName ?? ''}</span>',
        );

    _webController = WebViewControllerPlus()
      ..loadHtmlString(replacedHtml)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            _webController.getWebViewHeight().then((value) {
              var height = int.parse(value.toString()).toDouble();
              if (height != _height) {
                setState(() {
                  _height = height;
                });
              }
            });
          },
        ),
      );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: COLOR_PRIMARY_GREEN,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(
                      vertical: SCROLL_PADDING_VERTICAL,
                      horizontal: SCROLL_PADDING_HORIZONTAL,
                    ),
                    child: SizedBox(
                      height: _height,
                      child: WebViewWidget(
                        controller: _webController,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () async {
                              await loanController.createWithdrawService(
                                context,
                                widget.loanAmount.toString(),
                                widget.pointFee.toString(),
                                widget.purposeValue.toString(),
                              );
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.black12;
                          }
                          return COLOR_PRIMARY_GREEN;
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.white;
                          }
                          return Colors.white;
                        }),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: const Text('TARIK GAJI SAYA'),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Future<void> modalWDTermCondition(
  BuildContext context,
  AccountModel? accountData,
  CompanyInformationModel? companiesData,
  UserModel? userData,
  int loanAmount,
  int totalAmountReceive,
  int pointFee,
  String purposeValue,
  bool isSwitchPoint,
) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 750),
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return ContractTermConditionWDModal(
        accountData: accountData,
        companiesData: companiesData,
        userData: userData,
        loanAmount: loanAmount,
        totalAmountReceive: totalAmountReceive,
        pointFee: pointFee,
        purposeValue: purposeValue,
        isSwitchPoint: isSwitchPoint,
      );
    },
  );
}
