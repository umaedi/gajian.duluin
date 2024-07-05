import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:duluin_app/contants/color.dart';
import 'package:duluin_app/controllers/auth-controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../contants/attribute.dart';
import '../../contants/routes.dart';
import '../../controllers/user-controller.dart';
import '../../models/user-model.dart';
import '../partials/header-navigation.dart';

class SelfieUploadPage extends StatefulWidget {
  const SelfieUploadPage({super.key});

  @override
  State<SelfieUploadPage> createState() => _SelfieUploadPageState();
}

class _SelfieUploadPageState extends State<SelfieUploadPage> {
  AuthController authController = AuthController();
  UserController userController = UserController();
  UserModel? _userData;
  late Map<String, dynamic> pageData;

  bool isLoading = false;
  bool isUploading = false;

  File? _selfieImage;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getUserData() async {
    UserModel? userData = await userController.currentUserDataService(context);
    setState(() {
      _userData = userData;
    });
  }

  Future loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _getUserData(),
    ]);

    setState(() => isLoading = false);
  }

  Future<void> _pickImage2() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        setState(() {
          _selfieImage = File(image.path);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Camera permission is required to take photos.'),
        ),
      );
    }
  }

  void _savedSelfieUpload() async {
    if (_selfieImage != null) {
      setState(() {
        isUploading = true;
      });

      await authController.uploadPhotoService(
        context,
        _selfieImage!,
        "selfie_photo",
      );

      setState(() {
        isUploading = false;
      });

      Navigator.pushNamedAndRemoveUntil(
        context,
        bottomNavRoute,
        (Route<dynamic> route) => false,
        arguments: {'initialPage': 0},
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please capture a photo first.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: true,
        titleText: 'Unggah Selfie',
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Foto Selfie KTP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: size.width * 0.035,
                              ),
                            ),
                            Divider(),
                            SizedBox(height: 5),
                            _selfieImage != null
                                ? Image.file(
                                    _selfieImage!,
                                    width: size.width,
                                    height: size.height * 0.55,
                                    fit: BoxFit.cover,
                                  )
                                : DottedBorder(
                                    color: Colors.black54,
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(15),
                                    strokeWidth: 1,
                                    child: Container(
                                      width: size.width,
                                      height: size.height * 0.55,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Panduan Selfie dengan KTP:',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '• Pastikan wajah menghadap kamera',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            '• Pastikan KTP Anda masih berlaku',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            '• Pastikan Anda menggunakan KTP asli. (Bukan hasil scan atau fotocopy)',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            '• Pastikan informasi identitas terlihat jelas',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            '• Pastikan Anda memberikan izin penggunaan kamera',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _pickImage2,
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                          COLOR_PRIMARY_GREEN),
                                      shadowColor: WidgetStateProperty.all(
                                          Colors.transparent),
                                      overlayColor: WidgetStateProperty.all(
                                          Colors.transparent),
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.camera,
                                          size: size.width * 0.050,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 7.5),
                                        Text(
                                          "Capture",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.width * 0.040,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                _selfieImage != null
                                    ? SizedBox(width: 10)
                                    : Container(),
                                _selfieImage != null
                                    ? Expanded(
                                        child: ElevatedButton(
                                          onPressed: _savedSelfieUpload,
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                              isUploading
                                                  ? Colors.grey
                                                  : Colors.black87,
                                            ),
                                            shadowColor:
                                                WidgetStateProperty.all(
                                                    Colors.transparent),
                                            overlayColor:
                                                WidgetStateProperty.all(
                                                    Colors.transparent),
                                            shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                          child: isUploading
                                              ? SizedBox(
                                                  width: 15,
                                                  height: 15,
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .solidSave,
                                                      size: size.width * 0.050,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 7.5),
                                                    Text(
                                                      "Simpan",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.width * 0.040,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
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
