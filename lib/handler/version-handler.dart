import 'package:duluin_app/controllers/app-controller.dart';
import 'package:duluin_app/models/app-model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

Future<void> checkForUpdate(BuildContext context) async {
  AppController appController = AppController();
  AppModel? appInfo = await appController.getAppUpdateService(context);

  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version;

  if (appInfo?.appId == packageInfo.packageName &&
      appInfo?.appId != '' &&
      appInfo?.latestVersion != currentVersion) {
    showDialog(
      context: context,
      barrierDismissible: appInfo!.isCriticalUpdate,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pembaruan Tersedia'),
          content: appInfo.releaseNotes != ''
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        'Versi baru (${appInfo.latestVersion}) tersedia. Anda memiliki versi ${packageInfo.version}.'),
                    SizedBox(height: 10),
                    Text(
                      'Catatan Rilis:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    HtmlWidget(appInfo.releaseNotes),
                  ],
                )
              : Container(),
          actions: <Widget>[
            if (!appInfo.isCriticalUpdate)
              TextButton(
                child: Text('Nanti'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            TextButton(
              child: Text('Perbarui'),
              onPressed: () {
                print("Perbarui diklik");
                launchUrlString(appInfo.downloadUrl);

                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
