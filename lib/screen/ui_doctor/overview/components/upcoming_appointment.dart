// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class UpCommingAppointment extends StatefulWidget {
  const UpCommingAppointment({super.key});

  @override
  State<UpCommingAppointment> createState() => _UpCommingAppointmentState();
}

class _UpCommingAppointmentState extends State<UpCommingAppointment> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationCubit, ConsultationState>(
        builder: (context, state) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (state.consultations != null &&
                state.consultations!.coming.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: dimensWidth() * 3,
                    vertical: dimensHeight() * 2),
                child: Text(
                  translate(context, 'upcoming_appointments'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: dimensWidth(),
                  right: dimensWidth(),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.consultations!.coming.map((cons) {
                      List<int> time = [];
                      var imagePatient;
                      try {
                        time = cons.expectedTime
                                ?.split('-')
                                .map((e) => int.parse(e))
                                .toList() ??
                            [int.parse(cons.expectedTime!)];
                      } catch (e) {
                        logPrint(e);
                      }
                      try {
                        if (cons.medical?.avatar != null &&
                            cons.medical?.avatar != 'default' &&
                            cons.medical?.avatar != '') {
                          imagePatient = imagePatient ??
                              NetworkImage(
                                CloudinaryContext.cloudinary
                                    .image(cons.medical?.avatar ?? '')
                                    .toString(),
                              );
                        } else {
                          imagePatient = AssetImage(DImages.placeholder);
                        }
                      } catch (e) {
                        logPrint(e);
                        imagePatient = AssetImage(DImages.placeholder);
                      }

                      DateTime from = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                          .parse(cons.date!);
                      from = DateTime(
                          from.year,
                          from.month,
                          from.day,
                          (time.first - 1) ~/ 2,
                          (time.first - 1) % 2 == 1 ? 30 : 0);
                      // String? expectedTime;
                      // try {
                      //   expectedTime =
                      // '${convertIntToTime(time.first)} - ${convertIntToTime(time.last + 1)}';
                      // } catch (e) {
                      //   logPrint(e);
                      // }
                      return Padding(
                        padding: EdgeInsets.only(bottom: dimensHeight()),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              detailConsultationName,
                              arguments: cons.toJson(),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              dimensWidth(),
                            ),
                          ),
                          dense: true,
                          visualDensity: const VisualDensity(vertical: 0),
                          leading: CircleAvatar(
                            backgroundImage: imagePatient,
                            onBackgroundImageError: (exception, stackTrace) =>
                                logPrint(exception),
                            radius: dimensWidth() * 3,
                          ),
                          title: Text(
                            cons.medical!.fullName ??
                                translate(context, 'undefine'),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translate(context, cons.status ?? 'undefine'),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          trailing: Text(
                            // expectedTime ?? "--:--",
                            daysBetween(
                              context,
                              DateTime.now(),
                              from,
                            ),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      );
                    }).toList()),
              )
            ],
          ]);
    });
  }
}
