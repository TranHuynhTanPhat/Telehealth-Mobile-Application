import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
    required this.object,
  });
  final Map<String, dynamic> object;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: dimensWidth() * 2),
      padding: EdgeInsets.symmetric(
          vertical: dimensHeight(), horizontal: dimensWidth()),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(color: color1F1F1F.withOpacity(.1)),
        borderRadius: BorderRadius.circular(dimensWidth() * 1.8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: object['color'].withOpacity(.4),
                    borderRadius: BorderRadius.circular(dimensWidth() * 1.3)),
                padding: EdgeInsets.all(dimensWidth() * 1.3),
                margin: EdgeInsets.only(right: dimensWidth()),
                child: FaIcon(
                  object['icon'],
                  size: dimensWidth() * 4,
                  color: object['color'],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    translate(context,object['name']),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "10 ${translate(context,object['unit'])}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              )
            ],
          ),
          const FaIcon(FontAwesomeIcons.angleRight)
        ],
      ),
    );
  }
}
