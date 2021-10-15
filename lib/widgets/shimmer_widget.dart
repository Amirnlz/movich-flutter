import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;

  const ShimmerWidget(
      {Key? key, required this.height, this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
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
    );
  }
}
