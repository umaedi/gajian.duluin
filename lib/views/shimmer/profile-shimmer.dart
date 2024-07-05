import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: SizedBox(
            width: size.width,
            child: Card(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              elevation: 5,
              color: Colors.white,
              child: Container(
                height: size.height * 0.5,
                width: size.width,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
