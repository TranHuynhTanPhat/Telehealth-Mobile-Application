import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';

class CompletedCard extends StatelessWidget {
  const CompletedCard({super.key, required this.object});
  final Map<String, dynamic> object;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: dimensHeight() * 2),
      padding: EdgeInsets.symmetric(
          horizontal: dimensWidth() * 2, vertical: dimensWidth() * 2),
      decoration: BoxDecoration(
        color: colorA8B1CE.withOpacity(.2),
        borderRadius: BorderRadius.all(
          Radius.circular(dimensWidth() * 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${translate(context, 'dr')}. ${translate(context, object['dr'])}",
                            overflow: TextOverflow.visible,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: color6A6E83,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            translate(context, object['specialist']),
                            overflow: TextOverflow.visible,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: black26,
                                    fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: dimensHeight()),
                            child: Text(
                              "${translate(context, 'patient')}: ${object['patient']}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: color6A6E83),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                splashColor: transparent,
                highlightColor: transparent,
                onTap: () {},
                child: Text(
                  translate(context, 'detail'),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: primary,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: dimensHeight() * 2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    formatDayMonthYear(context, object['date']),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              // FaIcon(
              //   FontAwesomeIcons.clock,
              //   color: color6A6E83,
              //   size: dimensWidth() * 2,
              // ),
              // SizedBox(
              //   width: dimensWidth(),
              // ),
              Text(
                object['begin'].format(context).toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: color6A6E83, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: dimensWidth() * .3,
              ),
              Text(
                "-",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: color6A6E83, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: dimensWidth() * .3,
              ),
              Text(
                object['end'].format(context).toString(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: color6A6E83, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    translate(context, object['status']),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth(),
                  ),
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    color: color6A6E83,
                    size: dimensWidth() * 2,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
