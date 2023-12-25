// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class CompletedCard extends StatefulWidget {
  const CompletedCard({super.key, required this.finish});
  final ConsultationResponse finish;

  @override
  State<CompletedCard> createState() => _CompletedCardState();
}

class _CompletedCardState extends State<CompletedCard> {
  var image;
  List<int> time = [];
  @override
  void initState() {
    image = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (widget.finish.doctor?.avatar != null &&
          widget.finish.doctor?.avatar != 'default' &&
          widget.finish.doctor?.avatar != '') {
        image = image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget.finish.doctor?.avatar ?? '')
                  .toString(),
            );
      } else {
        image = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      image = AssetImage(DImages.placeholder);
    }
    try {
      time = widget.finish.expectedTime
              ?.split('-')
              .map((e) => int.parse(e))
              .toList() ??
          [int.parse(widget.finish.expectedTime!)];
    } catch (e) {
      EasyLoading.showToast(translate(context, 'failure'));
    }
    String expectedTime =
        '${convertIntToTime(time.first - 1)} - ${convertIntToTime(time.last)}';

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
                            "${translate(context, 'dr')}. ${translate(context, widget.finish.doctor?.fullName)}",
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
                            translate(context, widget.finish.doctor?.specialty),
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
                              "${translate(context, 'patient')}: ${widget.finish.medical?.fullName ?? translate(context, 'undefine')}",
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
                    formatDayMonthYear(
                        context,
                        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                            .parse(widget.finish.date!)),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.clock,
                color: color6A6E83,
                size: dimensWidth() * 2,
              ),
              SizedBox(
                width: dimensWidth(),
              ),
              Text(
                expectedTime,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: color1F1F1F, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    translate(context, widget.finish.status),
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
