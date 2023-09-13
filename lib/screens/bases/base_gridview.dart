import 'package:flutter/material.dart';

import 'package:healthline/res/style.dart';

class BaseGridview extends StatelessWidget {
  const BaseGridview({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 0.8,
        mainAxisSpacing: dimensWidth() * 2,
        crossAxisSpacing: dimensHeight() * 2,
      ),
      children: children,
    );
  }
}
