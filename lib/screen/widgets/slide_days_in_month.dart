import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/date_slide.dart';
import 'package:healthline/utils/date_util.dart';

class SlideDaysInMonth extends StatefulWidget {
  const SlideDaysInMonth({
    super.key,
  });

  @override
  State<SlideDaysInMonth> createState() => _SlideDaysInMonthState();
}

class _SlideDaysInMonthState extends State<SlideDaysInMonth> {
  late int _daySelected;
  late DateTime _current;
  @override
  void initState() {
    _daySelected = 0;
    _current = DateTime.now();
    super.initState();
  }

  int daysLeft() {
    return DateTimeRange(
            start: DateTime(_current.year, _current.month, _current.day),
            end: DateTime(_current.year, _current.month + 1))
        .duration
        .inDays;
  }

  void dayPressed(int index, DateTime dateTime) {
    setState(() {
      _daySelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    opacity: DateTime.now().month >= _current.month &&
                            DateTime.now().year >= _current.year
                        ? 0
                        : 1,
                    child: DateTime.now().month >= _current.month &&
                            DateTime.now().year >= _current.year
                        ? null
                        : InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
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
                              size: dimensIcon() * .6,
                              color: color1F1F1F,
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
                      formatDateToMonthYear(context, _current),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900, color: color1F1F1F),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    splashColor: transparent,
                    highlightColor: transparent,
                    onTap: () => setState(() {
                      _current = DateTime(_current.year, _current.month + 1);
                      _daySelected = 0;
                    }),
                    child: FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: dimensIcon() * .6,
                      color: color1F1F1F,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        DateSlide(
            daysLeft: daysLeft(),
            dayPressed: dayPressed,
            daySelected: _daySelected,
            dateStart: _current),
        const Divider(
          thickness: 3,
        ),
      ],
    );
  }
}

