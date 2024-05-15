import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/custom_corner_clip_path.dart';

class DrugCardNone extends StatelessWidget {
  const DrugCardNone({
    super.key,
    required this.widget,
  });
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const CustomCornerClipPath(
          cornerTL: 0, cornerTR: 0, cornerBL: 0, cornerBR: 0),
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
          decoration: BoxDecoration(
            color: secondary,
            border: const Border(top: BorderSide(width: 1, color: white)),
            borderRadius: BorderRadius.circular(dimensWidth() * 2),
          ),
          child: widget),
    );
  }
}
