import 'package:duluin_app/contants/attribute.dart';
import 'package:duluin_app/contants/color.dart';
import 'package:duluin_app/contants/routes.dart';
import 'package:duluin_app/services/currency-formatter.dart';
import 'package:duluin_app/views/errors/empty-list-widget.dart';
import 'package:duluin_app/views/partials/header-navigation.dart';
import 'package:duluin_app/views/partials/pie-chart.dart';
import 'package:duluin_app/views/shimmer/history-shimmer.dart';
import 'package:flutter/material.dart';

import '../controllers/loan-controller.dart';
import '../data/loan-status.dart';
import '../models/loan-model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  LoanController loanController = LoanController();
  List<LoanModel>? _loanTransaction;
  Map<String, double> _loanPurposeData = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getLoanData() async {
    List<LoanModel>? loanTransactionData =
        await loanController.loanListService(context);
    Map<String, double> loanPurposeData = {};

    if (loanTransactionData != null) {
      for (var loan in loanTransactionData) {
        if (loanPurposeData.containsKey(loan.loanPurpose)) {
          loanPurposeData[loan.loanPurpose] =
              loanPurposeData[loan.loanPurpose]! + 1;
        } else {
          loanPurposeData[loan.loanPurpose] = 1;
        }
      }
    }

    setState(() {
      _loanTransaction = loanTransactionData;
      _loanPurposeData = loanPurposeData;
    });
  }

  Future loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _getLoanData(),
    ]);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: false,
        titleText: 'Riwayat Penarikan',
        isTitleText: true,
        isShowNotificationButton: true,
        isCenterTitle: true,
        sizeImage: 0,
      ),
      body: isLoading
          ? HistoryShimmer()
          : RefreshIndicator(
              onRefresh: () async {
                loadData();
              },
              color: COLOR_PRIMARY_GREEN,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: SCROLL_PADDING_HORIZONTAL,
                  vertical: SCROLL_PADDING_VERTICAL,
                ),
                child: Column(
                  children: [
                    _loanTransaction!.isNotEmpty
                        ? PieChartHistory(dataMap: _loanPurposeData)
                        : Container(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Penarikan Terakhir",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, withdrawPageRoute);
                            },
                            style: ButtonStyle(
                              overlayColor: WidgetStateProperty.resolveWith(
                                (states) => Colors.transparent,
                              ),
                            ),
                            child: Text(
                              "Buat Penarikan",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: COLOR_PRIMARY_GREEN,
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _loanTransaction!.isNotEmpty
                        ? ListView.builder(
                            itemCount: _loanTransaction?.length ?? 0,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              LoanModel _loan = _loanTransaction![index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    detailLoanPageRoute,
                                    arguments: {
                                      'loanId': _loan.id,
                                    },
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(12.5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: 'Penarikan Gaji - ',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: COLOR_PRIMARY_GREEN,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: _loan.loanPurpose,
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            convertStringToCurrency(
                                                                _loan
                                                                    .loanAmount,
                                                                'id_ID',
                                                                'Rp '),
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: size.width *
                                                              0.0375,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ' ${_loan.updated}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: size.width *
                                                              0.0375,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 5,
                                                  vertical: 2.5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: getStatusColor(
                                                      _loan.loanStatus),
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: Text(
                                                  getStatusText(
                                                      _loan.loanStatus),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : EmptyListWidget(),
                  ],
                ),
              ),
            ),
    );
  }
}
