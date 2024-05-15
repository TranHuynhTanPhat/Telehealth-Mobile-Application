import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/custom_corner_clip_path.dart';

class DrugCardMid extends StatelessWidget {
  const DrugCardMid({
    super.key,
    required this.widget,
  });
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCornerClipPath(
          cornerTL: dimensWidth() * 2,
          cornerTR: dimensWidth() * 2,
          cornerBL: dimensWidth() * 2,
          cornerBR: dimensWidth() * 2),
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
