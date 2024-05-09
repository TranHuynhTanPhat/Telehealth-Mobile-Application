// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:intl/intl.dart';

import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class UpCommingAppointment extends StatefulWidget {
  const UpCommingAppointment({super.key, required this.callBack});
  final Function(DrawerMenu) callBack;

  @override
  State<UpCommingAppointment> createState() => _UpCommingAppointmentState();
}

class _UpCommingAppointmentState extends State<UpCommingAppointment> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationCubit, ConsultationState>(
        builder: (context, state) {
      if (state.consultations != null &&
          state.consultations!.coming.isNotEmpty) {
        List<ConsultationResponse> consultations =
            state.consultations!.coming.where(
          (element) {
            List<int> time = [];
            try {
              time = element.expectedTime
                      ?.split('-')
                      .map((e) => int.parse(e))
                      .toList() ??
                  [int.parse(element.expectedTime!)];
            } catch (e) {
              logPrint(e);
            }
            DateTime to =
                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(element.date!);
            to = DateTime(to.year, to.month, to.day, (time.first) ~/ 2,
                (time.first) % 2 == 1 ? 30 : 0);

            return to.isAfter(DateTime.now());
          },
        ).toList();
        consultations.sort((a, b) {
          List<int> aTimes = [];
          try {
            aTimes =
                a.expectedTime?.split('-').map((e) => int.parse(e)).toList() ??
                    [int.parse(a.expectedTime!)];
          } catch (e) {
            logPrint(e);
          }
          DateTime at =
              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(a.date!);
          at = DateTime(at.year, at.month, at.day, (aTimes.first) ~/ 2,
              (aTimes.first) % 2 == 1 ? 30 : 0);
          List<int> bTimes = [];
          try {
            bTimes =
                b.expectedTime?.split('-').map((e) => int.parse(e)).toList() ??
                    [int.parse(b.expectedTime!)];
          } catch (e) {
            logPrint(e);
          }
          DateTime bt =
              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(a.date!);
          bt = DateTime(bt.year, bt.month, bt.day, (bTimes.first) ~/ 2,
              (bTimes.first) % 2 == 1 ? 30 : 0);
          return at.compareTo(bt);
        });
        if (consultations.length > 5) {
          consultations = consultations.getRange(0, 5).toList();
        }
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensWidth() * 3,
                      vertical: dimensHeight() * 2),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          translate(context, 'upcoming_appointments'),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      InkWell(
                        highlightColor: transparent,
                        splashColor: transparent,
                        onTap: () {
                          widget.callBack(DrawerMenu.Schedule);
                        },
                        child: Text(
                          translate(context, 'see_all'),
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: dimensWidth(),
                    right: dimensWidth(),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: consultations.map((cons) {
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

                        DateTime to = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                            .parse(cons.date!);
                        to = DateTime(to.year, to.month, to.day,
                            (time.first) ~/ 2, (time.first) % 2 == 1 ? 30 : 0);
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
                              timeComing(
                                context,
                                to,
                                DateTime.now(),
                              ),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        );
                      }).toList()),
                )
              ],
            ]);
      }
      return const SizedBox.shrink();
    });
  }
}
