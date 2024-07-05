import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../contants/attribute.dart';

class HistoryShimmer extends StatefulWidget {
  const HistoryShimmer({super.key});

  @override
  State<HistoryShimmer> createState() => _HistoryShimmerState();
}

class _HistoryShimmerState extends State<HistoryShimmer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SCROLL_PADDING_HORIZONTAL,
          vertical: SCROLL_PADDING_VERTICAL,
        ),
        child: ListView.builder(
          itemCount: 8,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(12.5),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20.0,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 150.0,
                              height: 20.0,
                              color: Colors.white,
                            ),
                            Container(
                              width: 50.0,
                              height: 20.0,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
