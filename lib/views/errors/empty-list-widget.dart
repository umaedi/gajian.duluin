import 'package:duluin_app/contants/color.dart';
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(25.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              "assets/icons/folder.png",
              scale: size.width * 0.02,
            ),
            const SizedBox(height: 15),
            Text(
              "Data is Empty",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: COLOR_PRIMARY_GREEN,
                fontSize: size.width * 0.05,
              ),
            ),
            Text(
              "Sorry, no records found.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black45,
                fontSize: size.width * 0.035,
              ),
            )
          ],
        ),
      ),
    );
  }
}
