import 'package:flutter/material.dart';

import '../../contants/assets.dart';
import '../../contants/attribute.dart';
import '../../contants/color.dart';
import '../../contants/routes.dart';
import '../partials/header-navigation.dart';

class SuccessRecovery extends StatefulWidget {
  const SuccessRecovery({super.key});

  @override
  State<SuccessRecovery> createState() => _SuccessRecoveryState();
}

class _SuccessRecoveryState extends State<SuccessRecovery> {
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
        sizeImage: size.width * 0.070,
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
              SizedBox(height: 25),
              Text(
                "Berhasil",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: COLOR_PRIMARY_GREEN,
                  fontSize: size.width * 0.075,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Kami telah mengirimkan link untuk mengubah password ke email Anda. Cek folder inbox atau spam untuk menemukannya.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.0375,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.050,
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, signinRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: COLOR_PRIMARY_GREEN,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "HOME",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
