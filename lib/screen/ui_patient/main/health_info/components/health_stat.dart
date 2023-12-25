import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class HealthStat extends StatelessWidget {
  const HealthStat({
    super.key,
    required this.fullName,
    required this.relationship,
    required this.heartRate,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.temperature,
  });

  final String? fullName;
  final String? relationship;
  final num heartRate;
  final String bloodGroup;
  final double height;
  final num weight;
  final double bmi;
  final num temperature;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${translate(context, 'full_name')}: ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              // if (state.subUsers.isNotEmpty)
              Expanded(
                child: Text(
                  fullName ?? translate(context, 'undefine'),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
            ],
          ),
        ),
        if (relationship != null)
          Padding(
            padding: EdgeInsets.symmetric(vertical: dimensHeight()),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${translate(context, 'relationship')}: ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                // if (state.subUsers.isNotEmpty)
                Expanded(
                  child: Text(
                    translate(context, relationship?.toLowerCase()),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${translate(context, 'heart_rate')}: ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                child: Text(
                  '$heartRate bpm',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${translate(context, 'blood_group')}: ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                child: Text(
                  bloodGroup,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${translate(context, 'height')}: ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                child: Text(
                  '$height m',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${translate(context, 'weight')}: ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                child: Text(
                  '$weight Kg',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${translate(context, 'BMI')}: ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                child: Text(
                  '${double.parse(
                    bmi.toStringAsFixed(2),
                  )} ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: dimensHeight()),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${translate(context, 'temperature')}: ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                child: Text(
                  '$temperature °C',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
