import 'package:flutter/material.dart';

import 'package:healthline/res/style.dart';

class BaseGridview extends StatelessWidget {
  const BaseGridview({super.key, required this.children, required this.radio});
  final List<Widget> children;
  final double radio;

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: radio,
        mainAxisSpacing: dimensWidth() * 2,
        crossAxisSpacing: dimensHeight() * 2,
      ),
      children: children,
    );
  }
}
