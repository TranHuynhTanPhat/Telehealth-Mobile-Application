import 'package:flutter/material.dart';
import 'package:healthline/res/images.dart';

class CompletedFrame extends StatefulWidget {
  const CompletedFrame({super.key});

  @override
  State<CompletedFrame> createState() => _CompletedFrameState();
}

class _CompletedFrameState extends State<CompletedFrame> {
  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(DImages.anhthe));
  }
}