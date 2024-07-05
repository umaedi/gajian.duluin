import 'package:duluin_app/contants/routes.dart';
import 'package:flutter/material.dart';

import '../../contants/assets.dart';
import '../../contants/attribute.dart';
import '../../contants/color.dart';
import '../../services/currency-formatter.dart';
import '../partials/header-navigation.dart';

class SuccessWithdrawPage extends StatefulWidget {
  final String loanId;
  final int loanAmount;
  const SuccessWithdrawPage(
      {super.key, required this.loanId, required this.loanAmount});

  @override
  State<SuccessWithdrawPage> createState() => _SuccessWithdrawPageState();
}

class _SuccessWithdrawPageState extends State<SuccessWithdrawPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.popAndPushNamed(
        context,
        detailLoanPageRoute,
        arguments: {
          'loanId': widget.loanId,
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        titleText: ASSET_DULUIN_GAJIAN,
        isTitleText: false,
        isShowBackButton: false,
        isCenterTitle: true,
        isShowNotificationButton: false,
        sizeImage: size.width * 0.085,
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
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                "assets/images/success-2-image.png",
                scale: 1,
              ),
              const SizedBox(height: 25),
              Text(
                "Selamat",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: COLOR_PRIMARY_GREEN,
                  fontSize: size.width * 0.075,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Permintaan penarikan gaji sebesar ${convertIntegerToCurrency(widget.loanAmount, 'id_ID', 'Rp ')} berhasil diproses",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.0375,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
