// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/bases/base_listview_horizontal.dart';
import 'package:healthline/screen/components/slide_days_in_month.dart';
import './components/export.dart';

class UpcomingFrame extends StatefulWidget {
  const UpcomingFrame({super.key});

  @override
  State<UpcomingFrame> createState() => _UpcomingFrameState();
}

class _UpcomingFrameState extends State<UpcomingFrame> {
  final List<Map<String, dynamic>> appointments = [
    {
      'dr': 'Dr. Phat',
      'specialist': 'traumatologist',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 10, minute: 0),
      'end': const TimeOfDay(hour: 10, minute: 30),
      'status': 'pending'
    },
    {
      'dr': 'Dr. Truong',
      'specialist': 'obstetrician',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.logoGoogle,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 11, minute: 0),
      'end': const TimeOfDay(hour: 11, minute: 30),
      'status': 'confirmed'
    },
    {
      'dr': 'Dr. Chien',
      'specialist': 'obstetrician',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 8, minute: 0),
      'end': const TimeOfDay(hour: 8, minute: 30),
      'status': 'confirmed'
    },
    {
      'dr': 'Dr. Dang',
      'specialist': 'paeditrician',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 8, minute: 30),
      'end': const TimeOfDay(hour: 9, minute: 30),
      'status': 'confirmed'
    },
    {
      'dr': 'Dr. Chien',
      'specialist': 'dermatologist',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 14, minute: 0),
      'end': const TimeOfDay(hour: 14, minute: 30),
      'status': 'pending'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(vertical: dimensWidth()),
      children: [
        const SlideDaysInMonth(),
        SizedBox(
          height: dimensHeight(),
        ),
        ...List.generate(24, (index) {
          if (appointments.any((element) => element['begin'].hour == index)) {
            return Padding(
              padding: EdgeInsets.only(
                  left: dimensWidth() * 3,
                  right: dimensWidth() * 3,
                  bottom: dimensHeight() * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        TimeOfDay(hour: index, minute: 0)
                            .format(context)
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: black26),
                      ),
                      Expanded(
                        child: Text(
                          ' ---------------------------------------------------',
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: black26),
                        ),
                      )
                    ],
                  ),
                  BaseListviewHorizontal(
                    children: appointments
                        .map((e) => e['begin'].hour == index
                            ? UpcomingCard(object: e)
                            : const SizedBox())
                        .toList(),
                  ),
                ],
              ),
            );
          }
          return Container();
        }),
        SizedBox(
          height: dimensHeight() * 10,
        )
      ],
    );
  }
}
