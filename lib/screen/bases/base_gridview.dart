import 'package:flutter/material.dart';

import 'package:healthline/res/style.dart';

class BaseGridview extends StatelessWidget {
  const BaseGridview({super.key, required this.children, required this.radio, this.reserve = false});
  final List<Widget> children;
  final double radio;
  final bool reserve;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      reverse: reserve,
      crossAxisCount: 2,
      mainAxisSpacing: dimensWidth()*2,
      crossAxisSpacing: dimensHeight()*3,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      childAspectRatio: radio,
      // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //   maxCrossAxisExtent: 200,
      //   childAspectRatio: radio,
      //   mainAxisSpacing: dimensWidth() * 2,
      //   crossAxisSpacing: dimensHeight() * 2,
      // ),
      children: children,
    );
  }
}
