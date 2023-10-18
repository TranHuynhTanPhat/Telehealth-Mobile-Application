import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class InvalidShift extends StatelessWidget {
  const InvalidShift({
    super.key,
    required this.time,
  });
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: dimensWidth() * 3,
      padding: EdgeInsets.all(
        dimensWidth(),
      ),
      decoration: BoxDecoration(
          border: Border.all(width: .5, color: colorCDDEFF),
          color: white,
          borderRadius: BorderRadius.circular(dimensWidth())),
      alignment: Alignment.center,
      child: Text(
        time,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: color1F1F1F.withOpacity(.3)),
      ),
    );
  }
}