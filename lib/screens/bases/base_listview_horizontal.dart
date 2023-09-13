import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BaseListviewHorizontal extends StatelessWidget {
  const BaseListviewHorizontal({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 0),
      shrinkWrap: true,
      dragStartBehavior: DragStartBehavior.start,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      children: children
    );
  }
}


