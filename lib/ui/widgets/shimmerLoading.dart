import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    this.width,
    this.height,
    this.radius,
  });
  final double? height;
  final double? width;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white70,
      highlightColor: Colors.grey[400]!,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            radius ?? 8,
          ),
        ),
      ),
    );
  }
}