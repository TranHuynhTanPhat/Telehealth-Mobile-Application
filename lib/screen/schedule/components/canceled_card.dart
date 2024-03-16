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

class CanceledCard extends StatefulWidget {
  const CanceledCard({super.key, required this.cancel});

  final ConsultationResponse cancel;

  @override
  State<CanceledCard> createState() => _CanceledCardState();
}

class _CanceledCardState extends State<CanceledCard> {
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
      if (widget.cancel.doctor?.avatar != null &&
          widget.cancel.doctor?.avatar != 'default' &&
          widget.cancel.doctor?.avatar != '') {
        image = image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget.cancel.doctor?.avatar ?? '')
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
      time = widget.cancel.expectedTime
              ?.split('-')
              .map((e) => int.parse(e))
              .toList() ??
          [int.parse(widget.cancel.expectedTime!)];
    } catch (e) {
      EasyLoading.showToast(translate(context, 'failure'));
    }
    String expectedTime =
        '${convertIntToTime(time.first)} - ${convertIntToTime(time.last + 1)}';

    return Container(
      margin: EdgeInsets.only(top: dimensHeight() * 2),
      padding: EdgeInsets.symmetric(
          horizontal: dimensWidth() * 2, vertical: dimensWidth() * 2),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: color6A6E83.withOpacity(.2),
                style: BorderStyle.solid,
                width: 2,
                strokeAlign: BorderSide.strokeAlignInside)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: dimensWidth() * 32,
                    child: Text(
                      "${translate(context, 'dr')}. ${translate(context, widget.cancel.doctor?.fullName)}",
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: color6A6E83, fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    width: dimensWidth() * 32,
                    child: Text(
                      translate(context, widget.cancel.doctor?.specialty),
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: color6A6E83, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Text(
                    "${translate(context, 'patient')}: ${widget.cancel.medical?.fullName}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: color6A6E83),
                  ),
                ],
              ),
              // InkWell(
              //   splashColor: transparent,
              //   highlightColor: transparent,
              //   onTap: () {},
              //   child: Text(
              //     translate(context, 'detail'),
              //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              //         color: primary,
              //         fontWeight: FontWeight.normal,
              //         fontStyle: FontStyle.italic),
              //   ),
              // ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color1F1F1F, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth()*2,
                  ),
                  Text(
                    formatDayMonthYear(
                        context,
                        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                            .parse(widget.cancel.date!)),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    translate(context, widget.cancel.status),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth(),
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
