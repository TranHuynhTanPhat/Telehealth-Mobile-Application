import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';

class DateSlide extends StatefulWidget {
  const DateSlide(
      {super.key,
      required this.daysLeft,
      required this.dayPressed,
      required this.daySelected,
      required this.dateStart,});
  final int daysLeft;
  final int daySelected;
  final DateTime dateStart;
  final Function(int, DateTime) dayPressed;

  @override
  State<DateSlide> createState() => _DateSlideState();
}

class _DateSlideState extends State<DateSlide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: dimensHeight(), bottom: dimensHeight()),
      height: dimensWidth() * 14,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.daysLeft,
        itemBuilder: (context, index) {
          DateTime dateTime = DateTime(widget.dateStart.year,
              widget.dateStart.month, widget.dateStart.day + index);
          String date = formatToDate(context, dateTime);
          String day = formatDay(context, dateTime);
          return InkWell(
            splashColor: transparent,
            highlightColor: transparent,
            onTap: () => widget.dayPressed(index, dateTime),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: dimensWidth() * 3, horizontal: dimensWidth() * 3.5),
              margin: EdgeInsets.only(
                  left: index == 0 ? dimensWidth() * 3 : dimensWidth() * .75,
                  right: index == widget.daysLeft - 1
                      ? dimensWidth() * 3
                      : dimensWidth() * .75),
              decoration: BoxDecoration(
                color: widget.daySelected == index ? colorCDDEFF : white,
                borderRadius: BorderRadius.circular(dimensWidth() * 2.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      day,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: widget.daySelected == index
                              ? color1F1F1F
                              : color1F1F1F,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      date,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: widget.daySelected == index
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
    );
  }
}
