import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';

class SlideMonthsInYear extends StatefulWidget {
  const SlideMonthsInYear(
      {super.key,
      required this.current,
      required this.daySelected,
      required this.callBack});
  final DateTime current;
  final int daySelected;
  final Function(int, DateTime) callBack;

  @override
  State<SlideMonthsInYear> createState() => _SlideMonthsInYearState();
}

class _SlideMonthsInYearState extends State<SlideMonthsInYear> {
  @override
  void initState() {
    super.initState();
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
                  child: InkWell(
                    splashColor: transparent,
                    highlightColor: transparent,
                    onTap: () => widget.callBack(
                      widget.daySelected,
                      DateTime(widget.current.year - 1, 12),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      size: dimensIcon() * .6,
                      color: color1F1F1F,
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
                      widget.current.year.toString(),
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
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: DateTime.now().month <= widget.current.month &&
                            DateTime.now().year <= widget.current.year
                        ? 0
                        : 1,
                    child: DateTime.now().month <= widget.current.month &&
                            DateTime.now().year <= widget.current.year
                        ? null
                        : InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            onTap: () {
                              DateTime current;

                              if (widget.current.year + 1 ==
                                  DateTime.now().year) {
                                current = DateTime.now();
                              } else {
                                current = DateTime(widget.current.year + 1, 12);
                              }
                              widget.callBack(0, current);
                            },
                            child: FaIcon(
                              FontAwesomeIcons.chevronRight,
                              size: dimensIcon() * .6,
                              color: color1F1F1F,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: dimensHeight(), bottom: dimensHeight()),
          height: dimensWidth() * 10,
          child: ListView.builder(
            reverse: true,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.current.month,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: transparent,
                highlightColor: transparent,
                onTap: () => widget.callBack(index, widget.current),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: dimensWidth() * 2,
                      horizontal: dimensWidth() * 2.5),
                  margin: EdgeInsets.only(
                      right:
                          index == 0 ? dimensWidth() * 3 : dimensWidth() * .2,
                      left: index == 11 - 1
                          ? dimensWidth() * 3
                          : dimensWidth() * .2),
                  decoration: BoxDecoration(
                    color: widget.daySelected == index ? colorCDDEFF : white,
                    borderRadius: BorderRadius.circular(dimensWidth() * 2.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            formatMonth(
                                context,
                                DateTime(widget.current.year,
                                    widget.current.month - index)),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: widget.daySelected == index
                                        ? color1F1F1F
                                        : color1F1F1F,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
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
