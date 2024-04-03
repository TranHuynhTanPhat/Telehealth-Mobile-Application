import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class ShortNewPatient extends StatelessWidget {
  const ShortNewPatient({
    super.key,
    required this.fullName,
    this.symptom,
  });

  final String fullName;
  final String? symptom;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: dimensWidth()*3),
      padding: EdgeInsets.symmetric( vertical: dimensHeight() ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: colorF2F5FF),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: primary,
            backgroundImage: AssetImage(DImages.placeholder),
            radius: dimensHeight() * 2.5,
            onBackgroundImageError: (exception, stackTrace) {
              logPrint(exception);
            },
          ),
          const VerticalDivider(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  translate(context, symptom ?? "undefine"),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}