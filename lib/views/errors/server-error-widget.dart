import 'package:duluin_app/contants/color.dart';
import 'package:flutter/material.dart';

class ServerErrorWidget extends StatelessWidget {
  const ServerErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              "assets/icons/server.png",
              scale: 5,
            ),
            const SizedBox(height: 15),
            const Text(
              "Server Problem",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: COLOR_PRIMARY_GREEN,
                fontSize: 20,
              ),
            ),
            const Text(
              "Sorry, our server is offline or maintenance.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black45,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
