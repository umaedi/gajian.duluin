import 'package:cached_network_image/cached_network_image.dart';
import 'package:duluin_app/contants/assets.dart';
import 'package:duluin_app/contants/attribute.dart';
import 'package:duluin_app/contants/color.dart';
import 'package:duluin_app/contants/routes.dart';
import 'package:duluin_app/views/partials/header-navigation.dart';
import 'package:duluin_app/views/shimmer/profile-shimmer.dart';
import 'package:duluin_app/views/widgets/social-media.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../controllers/auth-controller.dart';
import '../controllers/user-controller.dart';
import '../handler/app-handler.dart';
import '../models/user-model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthController authController = AuthController();
  UserController userController = UserController();

  UserModel? _userData;
  bool isLoading = false;
  String _version = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getVersionInfo() async {
    PackageInfo packageInfo = await getAppHandler();
    setState(() {
      _version = 'Versi ${packageInfo.version}';
    });
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
      _getVersionInfo(),
      _getUserData(),
    ]);

    setState(() => isLoading = false);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                authController.logoutService(
                  context,
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const HeaderNavigationAppbar(
        isShowBackButton: false,
        titleText: 'Profile',
        isTitleText: true,
        isShowNotificationButton: true,
        isCenterTitle: true,
        sizeImage: 0,
      ),
      body: isLoading
          ? ProfileShimmer()
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: SCROLL_PADDING_HORIZONTAL,
                vertical: SCROLL_PADDING_VERTICAL,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            child: Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: ASSET_DEFAULT_PROFILE,
                                  fit: BoxFit.cover,
                                  width: size.width * 0.1,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _userData!.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: COLOR_PRIMARY_GREEN,
                                          fontSize: size.width * 0.05,
                                        ),
                                      ),
                                      Text(
                                        _userData!.email,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54,
                                          fontSize: size.width * 0.035,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.black26,
                            height: 0.0,
                            thickness: 0.25,
                          ),
                          SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, companyInformationPageRoute);
                                },
                                style: ButtonStyle(
                                  overlayColor: WidgetStateProperty.resolveWith(
                                    (states) => Colors.transparent,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.briefcase,
                                      size: 16,
                                      color: COLOR_PRIMARY_GREEN,
                                    ),
                                    SizedBox(width: 7.5),
                                    Text(
                                      "Info Perusahaan",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: COLOR_PRIMARY_GREEN,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.black26,
                            height: 0.0,
                            thickness: 0.25,
                          ),
                          SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, accountSettingPageRoute);
                                },
                                style: ButtonStyle(
                                  overlayColor: WidgetStateProperty.resolveWith(
                                    (states) => Colors.transparent,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.solidUserCircle,
                                      size: 16,
                                      color: COLOR_PRIMARY_GREEN,
                                    ),
                                    SizedBox(width: 7.5),
                                    Text(
                                      "Data Pribadi",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: COLOR_PRIMARY_GREEN,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.black26,
                            height: 0.0,
                            thickness: 0.25,
                          ),
                          SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, changePasswordPageRoute);
                                },
                                style: ButtonStyle(
                                  overlayColor: WidgetStateProperty.resolveWith(
                                    (states) => Colors.transparent,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.lock,
                                      size: 16,
                                      color: COLOR_PRIMARY_GREEN,
                                    ),
                                    SizedBox(width: 7.5),
                                    Text(
                                      "Ubah Password",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: COLOR_PRIMARY_GREEN,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.black26,
                            height: 0.0,
                            thickness: 0.25,
                          ),
                          SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, contactUsPageRoute);
                                },
                                style: ButtonStyle(
                                  overlayColor: WidgetStateProperty.resolveWith(
                                    (states) => Colors.transparent,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.headset,
                                      size: 16,
                                      color: COLOR_PRIMARY_GREEN,
                                    ),
                                    SizedBox(width: 7.5),
                                    Text(
                                      "Kontak Kami",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: COLOR_PRIMARY_GREEN,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.black26,
                            height: 0.0,
                            thickness: 0.25,
                          ),
                          SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  _showLogoutDialog(context);
                                },
                                style: ButtonStyle(
                                  overlayColor: WidgetStateProperty.resolveWith(
                                    (states) => Colors.transparent,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.signOutAlt,
                                      size: 16,
                                      color: COLOR_PRIMARY_RED,
                                    ),
                                    SizedBox(width: 7.5),
                                    Text(
                                      "Keluar",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: COLOR_PRIMARY_RED,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 25),
                      Text(
                        'Follow us on:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.040,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialMediaWidget(
                            url:
                                'https://www.facebook.com/people/Duluin-ID/61559841304605/',
                            iconData: FontAwesomeIcons.facebook,
                          ),
                          SizedBox(width: 15),
                          SocialMediaWidget(
                            url: 'https://www.instagram.com/duluin.id/',
                            iconData: FontAwesomeIcons.instagram,
                          ),
                          SizedBox(width: 15),
                          SocialMediaWidget(
                            url: 'https://www.linkedin.com/company/duluin/',
                            iconData: FontAwesomeIcons.linkedin,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        _version,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 14,
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
