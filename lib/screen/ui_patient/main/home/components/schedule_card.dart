import 'package:flutter/material.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/time_util.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.consultation});

  final ConsultationResponse consultation;

  @override
  Widget build(BuildContext context) {
    DateTime? date;
    List<int> time = [];
    try {
      date =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(consultation.date!);
    } catch (e) {
      logPrint(e);
    }
    try {
      time = consultation.expectedTime
              ?.split('-')
              .map((e) => int.parse(e))
              .toList() ??
          [int.parse(consultation.expectedTime!)];
    } catch (e) {
      logPrint(e);
    }
    String expectedTime =
        '${convertIntToTime(time.first)} - ${convertIntToTime(time.last + 1)}';
    return Container(
      padding: EdgeInsets.all(dimensWidth() * 2),
      decoration: BoxDecoration(
          color: colorCDDEFF,
          borderRadius: BorderRadius.circular(dimensWidth() * 2.5)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: white.withOpacity(.5),
                borderRadius: BorderRadius.circular(
                  dimensWidth() * 1.5,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Text(
                      date?.day.toString() ?? '--',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: secondary, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      date?.month.toString() ?? '--',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: secondary, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            )),
        Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.only(
                  left: dimensWidth() * 2,
                  top: dimensWidth(),
                  bottom: dimensWidth() * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      expectedTime,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: secondary),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      consultation.doctor?.fullName??translate(context, 'undefine'),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: secondary, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      translate(context,consultation.doctor?.specialty??'undefine'),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: secondary),
                    ),
                  )
                ],
              ),
            ))
      ]),
    );
  }
}
