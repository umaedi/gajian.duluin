import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:duluin_app/contants/color.dart';
import 'package:duluin_app/controllers/auth-controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../contants/attribute.dart';
import '../../controllers/page-dynamic-controller.dart';
import '../../controllers/user-controller.dart';
import '../../data/dynamic-page.dart';
import '../../models/user-model.dart';
import 'basic-information-page.dart';

class IdentityUploadPage extends StatefulWidget {
  const IdentityUploadPage({super.key});

  @override
  State<IdentityUploadPage> createState() => _IdentityUploadPageState();
}

class _IdentityUploadPageState extends State<IdentityUploadPage> {
  PageDynamicController pageController = PageDynamicController();
  AuthController authController = AuthController();
  UserController userController = UserController();
  UserModel? _userData;
  late Map<String, dynamic> pageData;

  File? _imageIdentity;

  bool isLoading = false;
  bool showBasicInfo = false;
  bool isUploading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadDynamicPage() async {
    var data = await pageController.pageTermCondition(context);
    if (data != null) {
      setState(() {
        pageData = data['data'];
      });
      modalTermCondition(context, pageData['content']);
    }
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
      loadDynamicPage(),
      _getUserData(),
    ]);

    setState(() => isLoading = false);
  }

  Future<void> _pickImage1() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final ImagePicker _picker1 = ImagePicker();
      final XFile? image1 =
          await _picker1.pickImage(source: ImageSource.camera);

      if (image1 != null) {
        setState(() {
          _imageIdentity = File(image1.path);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Camera permission is required to take photos.')),
      );
    }
  }

  void _savedIdentityUpload() async {
    if (_imageIdentity != null) {
      setState(() {
        isUploading = true;
      });

      bool redirectBasic = await authController.uploadPhotoService(
        context,
        _imageIdentity!,
        "ktp_photo",
      );

      setState(() {
        isUploading = false;
        showBasicInfo = redirectBasic;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please capture a photo first.'),
        ),
      );
    }
  }

  void _clearImage() {
    setState(() {
      _imageIdentity = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Unggah Identitas",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: _clearImage,
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          color: Colors.black,
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            size: 18,
          ),
        ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi, ${_userData?.name}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: COLOR_PRIMARY_GREEN,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              _userData!.email,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
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
                          children: [
                            Text(
                              "Ambil Foto KTP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: size.width * 0.035,
                              ),
                            ),
                            Divider(),
                            SizedBox(height: 5),
                            _imageIdentity != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(
                                      _imageIdentity!,
                                      width: size.width,
                                      height: size.height * 0.25,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : DottedBorder(
                                    color: Colors.black54,
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(15),
                                    strokeWidth: 1,
                                    child: Container(
                                      width: size.width,
                                      height: size.height * 0.30,
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
                                            'Panduan foto KTP:',
                                            style: TextStyle(
                                              fontSize: size.width * 0.035,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '• Pastikan seluruh KTP Anda muat dalam 1 layar',
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
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: _pickImage1,
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
                                          size: size.width * 0.05,
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
                                _imageIdentity != null
                                    ? SizedBox(width: 10)
                                    : Container(),
                                _imageIdentity != null
                                    ? Expanded(
                                        child: ElevatedButton(
                                          onPressed: isUploading
                                              ? null
                                              : _savedIdentityUpload,
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
                  SizedBox(height: 10),
                  showBasicInfo
                      ? !isLoading
                          ? BasicInformationPage()
                          : Container()
                      : Container(),
                ],
              ),
            ),
    );
  }
}
