import 'package:duluin_app/contants/attribute.dart';
import 'package:duluin_app/contants/color.dart';
import 'package:duluin_app/data/loan-status.dart';
import 'package:duluin_app/services/currency-formatter.dart';
import 'package:flutter/material.dart';

import '../../controllers/loan-controller.dart';
import '../../models/loan-model.dart';
import '../partials/header-navigation.dart';

class DetailLoanPage extends StatefulWidget {
  final String loanId;
  final int? loanAmount;
  const DetailLoanPage({super.key, required this.loanId, this.loanAmount});

  @override
  State<DetailLoanPage> createState() => _DetailLoanPageState();
}

class _DetailLoanPageState extends State<DetailLoanPage> {
  LoanController loanController = LoanController();
  LoanModel? _loanData;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getLoanData() async {
    LoanModel? loanData =
        await loanController.loanDetailService(context, widget.loanId);
    setState(() {
      _loanData = loanData;
    });
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _getLoanData(),
    ]);

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: true,
        titleText: 'Detail Penarikan',
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
              padding: EdgeInsets.symmetric(
                horizontal: SCROLL_PADDING_HORIZONTAL,
                vertical: SCROLL_PADDING_VERTICAL,
              ),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Penarikan Gaji",
                                  style: TextStyle(
                                    color: COLOR_PRIMARY_GREEN,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "Tanggal",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getStatusText(_loanData!.loanStatus),
                                  style: TextStyle(
                                    color:
                                        getStatusColor(_loanData!.loanStatus),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  _loanData!.created,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Start Nilai Transaksi
                  Text(
                    "Nilai Transaksi",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Jumlah Penarikan",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        _loanData!.loanDisbursedAmount != "0"
                            ? convertStringToCurrency(
                                _loanData!.loanDisbursedAmount, 'id_ID', 'Rp ')
                            : "0",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Biaya Admin",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        _loanData!.loanAdminFee != "0"
                            ? convertStringToCurrency(
                                _loanData!.loanAdminFee, 'id_ID', 'Rp ')
                            : "-",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Biaya Platform",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        _loanData!.loanPlatformFee != "0"
                            ? convertStringToCurrency(
                                _loanData!.loanPlatformFee, 'id_ID', 'Rp ')
                            : "-",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Biaya Poin",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "Rp 0",
                        style: TextStyle(
                          fontSize: 14,
                          color: COLOR_PRIMARY_RED,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _loanData!.loanAmount != "0"
                            ? convertStringToCurrency(
                                _loanData!.loanAmount, 'id_ID', 'Rp ')
                            : "-",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // End Nilai Transaksi

                  // Start Penarikan
                  SizedBox(height: 30),
                  Text(
                    "Penarikan",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ID Transaksi",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        _loanData!.loanRefNum,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "No. Rekening",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        _loanData!.disbursedBank.isNotEmpty &&
                                _loanData!.disbursedAccNumber.isNotEmpty
                            ? "${_loanData!.disbursedBank} - ${_loanData!.disbursedAccNumber}"
                            : "-",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tanggal & Jam",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        _loanData!.loanDisbursedAt.isNotEmpty
                            ? _loanData!.loanDisbursedAt
                            : "-",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tujuan Penarikan",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        _loanData!.loanPurpose,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  // End Penarikan
                ],
              ),
            ),
    );
  }
}
