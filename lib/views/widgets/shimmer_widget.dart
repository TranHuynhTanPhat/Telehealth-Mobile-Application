import 'package:flutter/material.dart';
import 'package:healthline/res/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  const ShimmerWidget({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorEBEBF4,
      highlightColor: colorF4F4F4,
      period: const Duration(milliseconds: 1000),
      child: child,
    );
  }
}
