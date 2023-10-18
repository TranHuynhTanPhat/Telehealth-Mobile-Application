import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class ValidShift extends StatelessWidget {
  const ValidShift({
    super.key,
    required this.time,
  });
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: dimensWidth() * 2,
      padding: EdgeInsets.all(
        dimensWidth(),
      ),
      decoration: BoxDecoration(
          color: colorCDDEFF,
          borderRadius: BorderRadius.circular(dimensWidth()*2)),
      alignment: Alignment.center,
      child: Text(
        time,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}