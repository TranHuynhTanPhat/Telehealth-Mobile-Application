// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class UpcomingCard extends StatefulWidget {
  const UpcomingCard({super.key, required this.coming});
  final ConsultationResponse coming;

  @override
  State<UpcomingCard> createState() => _UpcomingCardState();
}

class _UpcomingCardState extends State<UpcomingCard> {
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
      if (widget.coming.doctor?.avatar != null &&
          widget.coming.doctor?.avatar != 'default' &&
          widget.coming.doctor?.avatar != '') {
        image = image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget.coming.doctor?.avatar ?? '')
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
      time = widget.coming.expectedTime
              ?.split('-')
              .map((e) => int.parse(e))
              .toList() ??
          [int.parse(widget.coming.expectedTime!)];
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
        color: widget.coming.status == 'pending'
            ? colorDF9F1E.withOpacity(.2)
            : colorCDDEFF,
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: dimensImage() * 5,
                    height: dimensImage() * 5,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          100,
                        ),
                      ),
                      image: DecorationImage(
                        image: image,
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          logPrint(exception);
                          setState(() {
                            image = AssetImage(DImages.placeholder);
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: dimensWidth() * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate(
                              context,
                              widget.coming.doctor?.fullName ??
                                  translate(context, 'undefine')),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: color1F1F1F,
                                  fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          width: dimensWidth() * 30,
                          child: Text(
                            translate(context,
                                widget.coming.doctor?.specialty ?? 'undefine'),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: color1F1F1F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.coming.status == "pending")
                InkWell(
                  splashColor: transparent,
                  highlightColor: transparent,
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: [
                              InkWell(
                                splashColor: transparent,
                                highlightColor: transparent,
                                onTap: () => Navigator.pop(context),
                                child: Text(
                                  translate(context, 'back'),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              InkWell(
                                splashColor: transparent,
                                highlightColor: transparent,
                                onTap: () {
                                  try {
                                    AppController().authState ==
                                            AuthState.PatientAuthorized
                                        ? context
                                            .read<ConsultationCubit>()
                                            .cancelConsultation(
                                                consultationId:
                                                    widget.coming.id!)
                                        : context
                                            .read<ConsultationCubit>()
                                            .denyConsultation(
                                                consultationId:
                                                    widget.coming.id!);
                                  } catch (e) {
                                    EasyLoading.showToast(
                                        translate(context, 'failure'));
                                  }
                                },
                                child: Text(
                                  translate(context, 'confirm'),
                                  style:
                                      const TextStyle(color: Colors.redAccent),
                                ),
                              )
                            ],
                            title: Text(
                                '${translate(context, 'cancel')} ${translate(context, 'appointment').toLowerCase()}'),
                            titleTextStyle:
                                Theme.of(context).textTheme.labelLarge,
                          );
                        });
                  },
                  child: FaIcon(
                    FontAwesomeIcons.xmark,
                    size: dimensWidth() * 2.5,
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: dimensHeight() * 2),
            child: SizedBox(
              width: dimensWidth() * 30,
              child: Text(
                "${translate(context, 'patient')}: ${widget.coming.medical?.fullName}",
                overflow: TextOverflow.visible,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: color1F1F1F,
                    ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: dimensHeight() * 2),
            child: Text(
              formatFullDate(
                  context,
                  DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                      .parse(widget.coming.date!)),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: color1F1F1F,
                  ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.clock,
                    color: color1F1F1F,
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
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translate(context, widget.coming.status),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color1F1F1F, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth(),
                  ),
                  widget.coming.status == 'confirmed'
                      ? FaIcon(
                          FontAwesomeIcons.check,
                          color: color1F1F1F,
                          size: dimensWidth() * 2,
                        )
                      : FaIcon(
                          FontAwesomeIcons.arrowsRotate,
                          color: color1F1F1F,
                          size: dimensWidth() * 2,
                        ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
