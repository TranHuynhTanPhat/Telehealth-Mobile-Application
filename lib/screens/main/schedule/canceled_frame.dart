import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class CanceledFrame extends StatefulWidget {
  const CanceledFrame({super.key});

  @override
  State<CanceledFrame> createState() => _CanceledFrameState();
}

class _CanceledFrameState extends State<CanceledFrame> {
  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(DImages.logoGoogle));
  }
}
