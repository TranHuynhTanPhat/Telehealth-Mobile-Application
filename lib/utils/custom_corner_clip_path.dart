import 'package:flutter/material.dart';

class CustomCornerClipPath extends CustomClipper<Path> {
  final double cornerBR;
  final double cornerBL;
  final double cornerTR;
  final double cornerTL;
  const CustomCornerClipPath({this.cornerBR = 0.0, this.cornerBL = 0.0,this.cornerTR = 0.0, this.cornerTL = 0.0});

  @override
  Path getClip(Size size) => Path()
    ..lineTo(size.width-cornerTR, 0)
    ..arcToPoint(
      Offset(size.width, cornerTR),
      radius: Radius.circular(cornerTR),
      clockwise: false,
    )
    ..lineTo(size.width, size.height - cornerBR)
    ..arcToPoint(
      Offset(size.width - cornerBR, size.height),
      radius: Radius.circular(cornerBR),
      clockwise: false,
    )
    ..lineTo(cornerBL, size.height)
    ..arcToPoint(
      Offset(0, size.height-cornerBL),
      radius: Radius.circular(cornerBL),
      clockwise: false,
    )
    ..lineTo(-cornerTL, 0)
    ..arcToPoint(
      Offset(cornerTL, 0),
      radius: Radius.circular(cornerTL),
      clockwise: false,
    )
    ;

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
