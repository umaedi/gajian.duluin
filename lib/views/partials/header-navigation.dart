import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../contants/routes.dart';

class HeaderNavigationAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isShowBackButton;
  final bool isShowNotificationButton;
  final bool isCenterTitle;
  final bool isTitleText;
  final String titleText;
  final double sizeImage;
  const HeaderNavigationAppbar({
    super.key,
    required this.titleText,
    required this.isShowBackButton,
    required this.isShowNotificationButton,
    required this.isCenterTitle,
    required this.isTitleText,
    required this.sizeImage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: isCenterTitle ? true : false,
      title: isTitleText
          ? Text(
              titleText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )
          : CachedNetworkImage(
              imageUrl: titleText,
              height: sizeImage,
            ),
      leading: isShowBackButton
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    const WidgetStatePropertyAll<Color>(Colors.white),
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
            )
          : null,
      actions: isShowNotificationButton
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, notificationPageRoute);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        const WidgetStatePropertyAll<Color>(Colors.white),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  icon: Icon(
                    FontAwesomeIcons.bell,
                    size: 22,
                  ),
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
