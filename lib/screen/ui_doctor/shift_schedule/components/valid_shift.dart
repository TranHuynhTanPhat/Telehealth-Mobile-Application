import 'package:flutter/material.dart';

import 'package:healthline/res/style.dart';

class ValidShift extends StatelessWidget {
  const ValidShift({
    Key? key,
    required this.time,
    this.choosed = false,
  }) : super(key: key);
  final String time;
  final bool choosed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: dimensWidth() * 2,
      padding: EdgeInsets.all(
        dimensWidth(),
      ),
      decoration: BoxDecoration(
          color: choosed ? secondary : colorCDDEFF,
          borderRadius: BorderRadius.circular(dimensWidth() * 2)),
      alignment: Alignment.center,
      child: Text(
        time,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: choosed ? white : null),
      ),
    );
  }
}
