import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
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

  void dayPressed(value) {
    setState(() {
      _daySelected = value;
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
        Container(
          padding: EdgeInsets.only(top: dimensHeight(), bottom: dimensHeight()),
          height: dimensWidth() * 14,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: daysLeft(),
            itemBuilder: (context, index) {
              String date = formatToDate(
                  context,
                  DateTime(
                      _current.year, _current.month, _current.day + index));
              String day = formatDay(
                  context,
                  DateTime(
                      _current.year, _current.month, _current.day + index));
              return InkWell(
                splashColor: transparent,
                highlightColor: transparent,
                onTap: () => dayPressed(index),
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
                                      ? color1F1F1F
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
                                      ? color1F1F1F
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
      ],
    );
  }
}
