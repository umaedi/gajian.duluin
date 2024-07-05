import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialMediaWidget extends StatelessWidget {
  final String url;
  final IconData iconData;
  final double iconSize;

  const SocialMediaWidget({
    super.key,
    required this.url,
    required this.iconData,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString(url);
      },
      child: Container(
        padding: const EdgeInsets.all(12.5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2.5,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Icon(
          iconData,
          color: Colors.grey.shade800,
          size: iconSize,
        ),
      ),
    );
  }
}
