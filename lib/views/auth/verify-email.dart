import 'dart:async';

import 'package:duluin_app/controllers/auth-controller.dart';
import 'package:duluin_app/controllers/user-controller.dart';
import 'package:duluin_app/models/user-model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../contants/attribute.dart';
import '../../contants/color.dart';
import '../partials/header-navigation.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  _VerifyEmailPageState createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  AuthController authController = AuthController();
  UserController userController = UserController();

  late Timer _timer;
  int _start = 120;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _canResend = false;
      _start = 120;
    });

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _canResend = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void resendCode() {
    getSendOTP().then((value) {
      startTimer();
    });
  }

  Future<void> getSendOTP() async {
    UserModel? userData = await userController.currentUserDataService(context);

    await authController.sendEmailOTP(context, userData!.id);
  }

  void resendCodeToWhatsapp() {
    getSendOTPWhatsapp().then((value) {
      startTimer();
    });
  }

  Future<void> getSendOTPWhatsapp() async {
    UserModel? userData = await userController.currentUserDataService(context);

    await authController.sendWhatsappOTP(context, userData!.id);
  }

  void onChangedOtp(String otp) {
    if (otp.length == 6) {
      authController.verifyEmailOTP(context, otp);
    }
  }

  @override
  void dispose() {
    _controllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((focusNode) => focusNode.dispose());
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextStyle defaultStyle =
        const TextStyle(color: Colors.grey, fontSize: 16.0);
    TextStyle linkStyle = const TextStyle(color: COLOR_PRIMARY_GREEN);

    int minutes = (_start / 60).floor();
    int seconds = _start % 60;
    String timeText =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        titleText: "Verifikasi Kode OTP",
        isTitleText: true,
        isShowBackButton: true,
        isCenterTitle: true,
        isShowNotificationButton: false,
        sizeImage: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SCROLL_PADDING_HORIZONTAL,
          vertical: SCROLL_PADDING_VERTICAL,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Verifikasi Email Kamu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.bold,
                  color: COLOR_PRIMARY_GREEN,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Masukan kode otp yang kami kirimkan ke email kamu yang terdaftar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.035,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  6,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: SizedBox(
                      width: 40,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              width: 2,
                              color: COLOR_PRIMARY_GREEN,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          onChangedOtp(_controllers.map((e) => e.text).join());
                          if (value.length == 1) {
                            if (index < 5) {
                              _focusNodes[index].unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index + 1]);
                            } else {
                              _focusNodes[index].unfocus();
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              !_canResend
                  ? Text(
                      timeText,
                      style: TextStyle(
                        fontSize: size.width * 0.040,
                        color: COLOR_PRIMARY_GREEN,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Container(),
              SizedBox(height: 25),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: defaultStyle,
                  children: <TextSpan>[
                    const TextSpan(text: 'Belum menerima kode OTP? '),
                    TextSpan(
                      text: 'Kirim ulang kode OTP',
                      style: linkStyle.copyWith(
                        color: _canResend ? COLOR_PRIMARY_GREEN : Colors.grey,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _canResend
                            ? () {
                                resendCode();
                              }
                            : null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: defaultStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Atau',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: defaultStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Kirim OTP Melalui Whatsapp',
                      style: linkStyle.copyWith(
                        color: _canResend ? COLOR_PRIMARY_GREEN : Colors.grey,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _canResend
                            ? () {
                                resendCodeToWhatsapp();
                              }
                            : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
