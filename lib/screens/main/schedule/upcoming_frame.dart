// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/bases/base_listview_horizontal.dart';
import 'package:healthline/screens/main/schedule/components/export.dart';
import 'package:healthline/utils/date_util.dart';

class UpcomingFrame extends StatefulWidget {
  const UpcomingFrame({super.key});

  @override
  State<UpcomingFrame> createState() => _UpcomingFrameState();
}

class _UpcomingFrameState extends State<UpcomingFrame> {
  late DateTime _current;
  late int _daySelected;
  final List<Map<String, dynamic>> appointments = [
    {
      'dr': 'Dr. Phat',
      'description': 'depression',
      'image': DImages.anhthe,
      'date': DateTime.now(),
      'time': TimeOfDay.now()
    },
    {
      'dr': 'Dr. Truong',
      'description': 'cardiologist',
      'image': DImages.logoGoogle,
      'date': DateTime.now(),
      'time': TimeOfDay.now()
    },
    {
      'dr': 'Dr. Chien',
      'description': 'general_examination',
      'image': DImages.anhthe,
      'date': DateTime.now(),
      'time': TimeOfDay.now()
    },
    {
      'dr': 'Dr. Dang',
      'description': 'depression',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'time': TimeOfDay.now()
    },
    {
      'dr': 'Dr. Chien',
      'description': 'general_examination',
      'image': DImages.anhthe,
      'date': DateTime.now(),
      'time': const TimeOfDay(hour: 10, minute: 1)
    },
    {
      'dr': 'Dr. Chien',
      'description': 'general_examination',
      'image': DImages.anhthe,
      'date': DateTime.now(),
      'time': TimeOfDay.now()
    },
    {
      'dr': 'Dr. Chien',
      'description': 'general_examination',
      'image': DImages.anhthe,
      'date': DateTime.now(),
      'time': const TimeOfDay(hour: 12, minute: 1)
    },
    {
      'dr': 'Dr. Chien',
      'description': 'general_examination',
      'image': DImages.anhthe,
      'date': DateTime.now(),
      'time': TimeOfDay.now()
    },
    {
      'dr': 'Dr. Chien',
      'description': 'general_examination',
      'image': DImages.anhthe,
      'date': DateTime.now(),
      'time': const TimeOfDay(hour: 5, minute: 1)
    },
  ];

  @override
  void initState() {
    _current = DateTime.now();
    _daySelected = 0;
    super.initState();
  }

  int daysLeft() {
    return DateTimeRange(
            start: DateTime(_current.year, _current.month, _current.day),
            end: DateTime(_current.year, _current.month + 1))
        .duration
        .inDays;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(vertical: dimensWidth()),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: DateTime.now().month >= _current.month ? 0 : 1,
                    child: DateTime.now().month >= _current.month
                        ? null
                        : InkWell(
                            onTap: () => setState(() {
                              if (_current.month - 1 == DateTime.now().month) {
                                _current = DateTime.now();
                              } else {
                                _current =
                                    DateTime(_current.year, _current.month - 1);
                              }
                              _daySelected = 0;
                            }),
                            child: FaIcon(
                              FontAwesomeIcons.chevronLeft,
                              size: dimensIcon() * .8,
                              color: primary,
                            ),
                          ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Align(
                  alignment: Alignment.center,
                  child: Chip(
                    padding: const EdgeInsets.all(0),
                    side: BorderSide.none,
                    backgroundColor: colorCDDEFF,
                    label: Text(
                      formatDateToMonthYear(_current),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900, color: primary),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () => setState(() {
                      _current = DateTime(_current.year, _current.month + 1);
                      _daySelected = 0;
                    }),
                    child: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: dimensIcon() * .8,
                      color: primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: dimensHeight(), bottom: dimensHeight()),
          height: dimensWidth() * 14,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: daysLeft(),
            itemBuilder: (context, index) {
              String date = formatDate(DateTime(
                  _current.year, _current.month, _current.day + index));
              String day = formatDay(DateTime(
                  _current.year, _current.month, _current.day + index));
              return InkWell(
                splashColor: transparent,
                highlightColor: transparent,
                onTap: () => setState(() {
                  _daySelected = index;
                }),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: dimensWidth() * 3,
                      horizontal: dimensWidth() * 3.5),
                  margin: EdgeInsets.only(
                      left:
                          index == 0 ? dimensWidth() * 3 : dimensWidth() * .75,
                      right: index == daysLeft() - 1
                          ? dimensWidth() * 3
                          : dimensWidth() * .75),
                  decoration: BoxDecoration(
                    color: _daySelected == index ? colorCDDEFF : white,
                    borderRadius: BorderRadius.circular(dimensWidth() * 2.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          day,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: _daySelected == index
                                      ? primary
                                      : color1F1F1F,
                                  fontWeight: FontWeight.w900),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          date,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: _daySelected == index
                                      ? primary
                                      : color1F1F1F),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(
          thickness: 3,
        ),
        SizedBox(
          height: dimensHeight() * 5,
        ),
        ...List.generate(24, (index) {
          if (appointments.any((element) => element['time'].hour == index)) {
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
                        .map((e) => e['time'].hour == index
                            ? ScheduleCard(object: e)
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
