import 'package:duluin_app/contants/attribute.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../contants/color.dart';
import '../partials/header-navigation.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: true,
        titleText: 'Kontak Kami',
        isTitleText: true,
        isShowNotificationButton: true,
        isCenterTitle: true,
        sizeImage: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: SCROLL_PADDING_HORIZONTAL,
          vertical: SCROLL_PADDING_VERTICAL,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dapatkan kemudahan bersama Duluin Gajian",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: COLOR_PRIMARY_GREEN,
                fontSize: 20,
              ),
            ),
            Text(
              "Kami akan senantiasa memberikan informasi yang kamu butuhkan!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black45,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 25),
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
                      CircleAvatar(
                        child: Icon(
                          FontAwesomeIcons.whatsapp,
                          size: 22,
                          color: COLOR_PRIMARY_GREEN,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Customer Care",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Kami akan mendengarkanmu, bagaimana kami bisa membantu.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          fontSize: size.width * 0.040,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          String urlWhatsapp = "https://wa.me/628170031000";
                          launchUrlString(urlWhatsapp);
                        },
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(
                              vertical: 7.5,
                              horizontal: 12.5,
                            ),
                          ),
                          backgroundColor: const WidgetStatePropertyAll<Color>(
                            COLOR_PRIMARY_GREEN,
                          ),
                          shape: WidgetStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon(
                            //   FontAwesomeIcons.whatsapp,
                            //   color: Colors.white,
                            //   size: 14,
                            // ),
                            // SizedBox(width: 5),
                            Text(
                              "Hubungi Kami",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: size.width * 0.035,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              "Kantor Kami:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
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
                      SizedBox(height: 10),
                      Text(
                        "Gading Kirana Timur A11/15",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: COLOR_PRIMARY_GREEN,
                          fontSize: size.width * 0.043,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Kelapa Gading Barat, Kelapa Gading, Jakarta Utara, Jakarta, 14240",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                          fontSize: size.width * 0.0375,
                        ),
                      ),
                      SizedBox(height: 10),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Text(
                              "hello@duluin.com",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: COLOR_PRIMARY_GREEN,
                                fontSize: size.width * 0.035,
                              ),
                            ),
                            VerticalDivider(
                              color: COLOR_PRIMARY_GREEN,
                              thickness: 1,
                            ),
                            Text(
                              "duluin.com",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: COLOR_PRIMARY_GREEN,
                                fontSize: size.width * 0.035,
                              ),
                            ),
                          ],
                        ),
                      )
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
