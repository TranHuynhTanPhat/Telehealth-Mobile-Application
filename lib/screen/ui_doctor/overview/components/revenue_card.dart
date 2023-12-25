import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';

class RevenueCard extends StatelessWidget {
  const RevenueCard({
    super.key, required this.money,
  });
  final int money;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: dimensHeight() * 8,
          left: dimensWidth() * 2,
          right: dimensWidth() * 2,
          child: FaIcon(
            FontAwesomeIcons.coins,
            color: colorDF9F1E.withOpacity(.5),
            size: dimensWidth() * 20,
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 3,
              vertical: dimensWidth() * 3,
            ),
            decoration: BoxDecoration(
                color: colorDF9F1E.withOpacity(.2),
                borderRadius: BorderRadius.circular(dimensWidth() * 2),),
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
                        FontAwesomeIcons.coins,
                        color: white,
                        size: dimensIcon() * .5,
                      ),
                    ),
                    SizedBox(
                      width: dimensWidth(),
                    ),
                    Expanded(
                      child: Text(
                        translate(context, 'revenue'),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          "$money",
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, height: 0),
                        ),
                      ),
                      SizedBox(
                        width: dimensWidth() * 2,
                      ),
                      Text(
                        'VNĐ',
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.arrowTrendUp,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: dimensWidth(),
                    ),
                    Text(
                      '10%',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    Text(
                      formatDayMonthYear(context, DateTime.now()),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
