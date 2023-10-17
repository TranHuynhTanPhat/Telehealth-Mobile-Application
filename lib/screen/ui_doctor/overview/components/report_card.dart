import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';

class ReportCard extends StatelessWidget {
  const ReportCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: dimensHeight() * 8,
          left: dimensWidth() * 2,
          right: dimensWidth() * 2,
          child: FaIcon(
            FontAwesomeIcons.circleExclamation,
            color: color9D4B6C.withOpacity(.5),
            size: dimensWidth() * 20,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: dimensWidth() * 3,
            vertical: dimensWidth() * 3,
          ),
          decoration: BoxDecoration(
            color: color9D4B6C.withOpacity(.2),
            borderRadius: BorderRadius.circular(dimensWidth() * 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: color1F1F1F,
                    radius: dimensIcon() * .5,
                    child: FaIcon(
                      FontAwesomeIcons.circleExclamation,
                      color: white,
                      size: dimensIcon() * .5,
                    ),
                  ),
                  SizedBox(
                    width: dimensWidth(),
                  ),
                  Expanded(
                    child: Text(
                      translate(context, 'reported'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: dimensHeight() * 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.arrowTrendUp,
                      color: Colors.red,
                      size: dimensIcon(),
                    ),
                    Text(
                      '5',
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontWeight: FontWeight.bold, height: 0),
                    ),
                    SizedBox(
                      width: dimensWidth() * 2,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formatDayMonthYear(context, DateTime.now()),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
