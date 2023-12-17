// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/jitsi_service.dart';
import 'package:intl/intl.dart';

import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/time_util.dart';

import '../../../../res/style.dart';
import '../../../../utils/log_data.dart';
import '../../../../utils/translate.dart';

class DetailConsultationScreen extends StatefulWidget {
  const DetailConsultationScreen({super.key, this.args});

  final String? args;

  @override
  State<DetailConsultationScreen> createState() =>
      _DetailConsultationScreenState();
}

class _DetailConsultationScreenState extends State<DetailConsultationScreen> {
  ConsultationResponse? consultation;
  var imageDoctor;
  var imagePatient;
  List<int> time = [];

  @override
  Widget build(BuildContext context) {
    try {
      consultation = ConsultationResponse.fromJson(widget.args!);
    } catch (e) {
      logPrint(e);
      Navigator.pop(context);
    }
    try {
      if (consultation?.doctor?.avatar != null &&
          consultation?.doctor?.avatar != 'default' &&
          consultation?.doctor?.avatar != '') {
        imageDoctor = imageDoctor ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(consultation?.doctor?.avatar ?? '')
                  .toString(),
            );
      } else {
        imageDoctor = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      imageDoctor = AssetImage(DImages.placeholder);
    }
    try {
      if (consultation?.medical?.avatar != null &&
          consultation?.medical?.avatar != 'default' &&
          consultation?.medical?.avatar != '') {
        imagePatient = imagePatient ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(consultation?.medical?.avatar ?? '')
                  .toString(),
            );
      } else {
        imagePatient = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      imagePatient = AssetImage(DImages.placeholder);
    }
    try {
      time = consultation?.expectedTime
              ?.split('-')
              .map((e) => int.parse(e))
              .toList() ??
          [int.parse(consultation!.expectedTime!)];
    } catch (e) {
      logPrint(e);
    }
    String expectedTime =
        '${convertIntToTime(time.first - 1)} - ${convertIntToTime(time.last)}';

    return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        backgroundColor: white,
        appBar: AppBar(
          title: Text(
            translate(context, 'appointment'),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(
              dimensWidth() * 3, 0, dimensWidth() * 3, dimensHeight() * 3),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.0), white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const FaIcon(FontAwesomeIcons.video),
            label: Text(translate(context, 'join_now')),
            style: ButtonStyle(
              foregroundColor: const MaterialStatePropertyAll(white),
              textStyle: MaterialStatePropertyAll(Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: white)),
              padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(
                    vertical: dimensHeight() * 2,
                    horizontal: dimensWidth() * 2.5),
              ),
              backgroundColor: const MaterialStatePropertyAll(primary),
            ),
            onPressed: () {
              JitsiService.instance.join(
                token:
                    "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InZwYWFzLW1hZ2ljLWNvb2tpZS1mZDA3NDQ4OTRmMTk0ZjNlYTc0ODg4NGY4M2NlYzE5NS85NmUwNTkifQ.eyJhdWQiOiJqaXRzaSIsImlzcyI6ImNoYXQiLCJpYXQiOjE3MDIzNzQyMzgsImV4cCI6MTcwMjM3NzgzOCwibmJmIjoxNzAyMzc0MjMzLCJzdWIiOiJ2cGFhcy1tYWdpYy1jb29raWUtZmQwNzQ0ODk0ZjE5NGYzZWE3NDg4ODRmODNjZWMxOTUiLCJjb250ZXh0Ijp7ImZlYXR1cmVzIjp7ImxpdmVzdHJlYW1pbmciOnRydWUsIm91dGJvdW5kLWNhbGwiOnRydWUsInNpcC1vdXRib3VuZC1jYWxsIjp0cnVlLCJ0cmFuc2NyaXB0aW9uIjp0cnVlLCJyZWNvcmRpbmciOnRydWV9LCJ1c2VyIjp7ImlkIjoiZGM1MTZiOTgtYjBkYi00OTViLTljZmItMGQzNzdhNTM0NmQxIiwibmFtZSI6ImhlYWx0aGxpbmVtYW5hZ2VyMjAyMyIsImF2YXRhciI6IiIsImVtYWlsIjoiaGVhbHRobGluZW1hbmFnZXIyMDIzQGdtYWlsLmNvbSIsIm1vZGVyYXRvciI6ZmFsc2UsImhpZGRlbi1mcm9tLXJlY29yZGVyIjpmYWxzZX19LCJyb29tIjoiKiJ9.SeTy8xwWAtXAc6SB4_9kCMtLW5q4KivnbiMjU5loKI5Gs6ERv7Cvan1L96pKJB17Q9nz1Pcd1Q9ZPEFw-OwQt8IxjXoUisD7NOYMolL8QW1H9R4gmkUrW5gOki2gQamacZEOgqpWe1L8GoC4X4uUohzZx1t6oinJTw3nmMpPcwpZK2Sc4jOY7c30zNolE5gjY667X3E1FLO-9T3307CdOLIl0Ro-ylOy4tX4XYpfnLXYspW1-C-wlOgKIKLi33VMvU5zsW9YqLYong47iaIIIxnvOGkeKzIxyLBCyb23rBR5NBuONUCC9o2vCZLqnYJKQyxMIRy5vmITvj0jv-0bFQ",
                roomName:
                    "vpaas-magic-cookie-fd0744894f194f3ea748884f83cec195/96e059",
                displayName: 'Tran Huynh Tan phat',
                urlAvatar: null,
                email: null,
              );
            },
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
          children: [
            Container(
              padding: EdgeInsets.only(bottom: dimensHeight() * 2),
              width: double.infinity,
              child: Text(
                formatFullDate(
                    context,
                    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                        .parse(consultation!.date!)),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: color1F1F1F, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * 2),
              child: Row(
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
                        translate(context, consultation?.status),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: color1F1F1F, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: dimensWidth(),
                      ),
                      consultation?.status == 'confirmed'
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
              ),
            ),
            Row(
              children: [
                Text(
                  translate(context, 'doctor'),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: dimensImage() * 7,
                  height: dimensImage() * 7,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        100,
                      ),
                    ),
                    image: DecorationImage(
                      image: imageDoctor,
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        logPrint(exception);
                        setState(() {
                          imageDoctor = AssetImage(DImages.placeholder);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: dimensWidth() * 2,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          consultation?.doctor?.fullName ??
                              translate(context, 'undefine'),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: color1F1F1F,
                                  fontWeight: FontWeight.w900),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          translate(context,
                              consultation?.doctor?.specialty ?? 'undefine'),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: color1F1F1F),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: dimensHeight() * 3,
            ),
            Row(
              children: [
                Text(
                  translate(context, 'patient'),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: dimensImage() * 7,
                  height: dimensImage() * 7,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        100,
                      ),
                    ),
                    image: DecorationImage(
                      image: imagePatient,
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        logPrint(exception);
                        setState(() {
                          imagePatient = AssetImage(DImages.placeholder);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: dimensWidth() * 2,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          consultation?.medical?.fullName ??
                              translate(context, 'undefine'),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: color1F1F1F,
                                  fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Padding(
            //   padding: EdgeInsets.only(
            //       bottom: dimensHeight() * 2, top: dimensHeight() * 10),,
            //   child: const Divider(
            //     thickness: 3,
            //     color: color1F1F1F,
            //   ),
            // ),
            // Container(

            //   width: double.infinity,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       Text(
            //         '${translate(context, 'total')}: ',
            //         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            //             color: color1F1F1F, fontWeight: FontWeight.bold),
            //       ),
            //       Text(
            //         convertToVND(consultation?.price ?? 0),
            //         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            //             color: color1F1F1F, fontWeight: FontWeight.bold),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ));
  }
}
