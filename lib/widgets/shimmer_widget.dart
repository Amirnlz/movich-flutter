import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const ShimmerWidget({Key? key, this.height, this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Shimmer.fromColors(
          highlightColor: const Color(0xff6c757d),
          baseColor: const Color(0xff495057),
          period: const Duration(seconds: 4),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Column shimmerItemHorizontal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ShimmerWidget(
          height: 220,
        ),
        SizedBox(
          height: 8,
        ),
        ShimmerWidget(
          height: 10,
          width: 100,
        ),
        SizedBox(
          height: 5,
        ),
        ShimmerWidget(
          height: 10,
          width: 150,
        ),
      ],
    );
  }

  Widget shimmerItemVertical() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerWidget(
            height: 160,
            width: 140,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerWidget(
                  height: 10,
                  width: 100,
                ),
                ShimmerWidget(
                  height: 10,
                  width: 120,
                ),
                ShimmerWidget(
                  height: 10,
                  width: 100,
                ),
                ShimmerWidget(
                  height: 10,
                  width: 200,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
