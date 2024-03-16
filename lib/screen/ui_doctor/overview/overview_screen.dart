// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/responses/doctor_dasboard_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_doctor/overview/components/export.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  DoctorDasboardResponse? dashboard;
  @override
  void initState() {
    if (!mounted) return;
    context.read<ConsultationCubit>().fetchConsultation();
    context.read<ConsultationCubit>().getDasboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConsultationCubit, ConsultationState>(
      listener: (context, state) {
        if (state is GetDasboardState &&
            state.blocState == BlocState.Successed) {
          setState(() {
            dashboard = state.dashboard;
          });
        } else if (state is CancelConsultationState ||
            state is ConfirmConsultationState ||
            state is DenyConsultationState) {
          if (state.blocState == BlocState.Pending) {
            EasyLoading.show(maskType: EasyLoadingMaskType.black);
          } else if (state.blocState == BlocState.Failed) {
            EasyLoading.showToast(translate(context, state.error));
          } else {
            EasyLoading.showToast(translate(context, 'successfully'));
            context.read<ConsultationCubit>().fetchConsultation();
            Navigator.pop(context);
          }
        }
      },
      child: BlocBuilder<ConsultationCubit, ConsultationState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            backgroundColor: white,
            body: ListView(
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(bottom: dimensHeight() * 10),
              children: [
                if (dashboard != null) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 3,
                        vertical: dimensHeight() * 2),
                    child: Text(
                      translate(context, 'statistics'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: dimensHeight() * 2,
                    ),
                    child: CarouselSlider(
                      items: [
                        RevenueCard(money: dashboard!.money!),
                        AppointmentCard(countConsul: dashboard!.countConsul!),
                        ReportCard(badFeedback: dashboard!.badFeedback!),
                      ],
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.2,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                          reverse: false,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale),
                    ),
                  ),
                ],
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensWidth() * 3,
                      vertical: dimensHeight() * 2),
                  child: Text(
                    translate(context, 'upcoming_appointments'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                if (state.consultations != null &&
                    state.consultations!.coming.isNotEmpty)
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

                          DateTime from =
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
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
                          '${convertIntToTime(time.first)} - ${convertIntToTime(time.last + 1)}';
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
                                onBackgroundImageError:
                                    (exception, stackTrace) =>
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
                                    translate(
                                        context, cons.status ?? 'undefine'),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                else
                  Container(
                    margin: EdgeInsets.only(top: dimensHeight() * 10),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                translate(context, 'empty'),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: color1F1F1F.withOpacity(.05),
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: dimensHeight() * 3,
                        // ),
                        FaIcon(
                          FontAwesomeIcons.boxOpen,
                          color: color1F1F1F.withOpacity(.05),
                          size: dimensWidth() * 30,
                        ),
                      ],
                    ),
                  )
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: dimensWidth() * 3,
                //       vertical: dimensHeight() * 2),
                //   child: Text(
                //     translate(context, 'next_patient_profile'),
                //     style: Theme.of(context).textTheme.titleLarge,
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                //   child: Text(
                //     translate(context, 'images'),
                //     style: Theme.of(context).textTheme.titleMedium,
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     bottom: dimensHeight() * 2,
                //   ),
                //   child: CarouselSlider(
                //     items: [
                //       Container(
                //         margin: EdgeInsets.only(top: dimensHeight()),
                //         height: dimensHeight() * 35,
                //         width: double.maxFinite,
                //         decoration: BoxDecoration(
                //           color: color1F1F1F,
                //           borderRadius:
                //               BorderRadius.circular(dimensWidth() * 2),
                //           image: DecorationImage(
                //               alignment: Alignment.topCenter,
                //               image: AssetImage(DImages.placeholder),
                //               fit: BoxFit.fitWidth),
                //         ),
                //       )
                //     ],
                //     options: CarouselOptions(
                //         autoPlay: false,
                //         aspectRatio: 2,
                //         enlargeCenterPage: true,
                //         viewportFraction: 0.8,
                //         reverse: false,
                //         enlargeStrategy: CenterPageEnlargeStrategy.scale),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                //   child: Text(
                //     translate(context, 'file'),
                //     style: Theme.of(context).textTheme.titleMedium,
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       left: dimensWidth() * 3, right: dimensWidth() * 3),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       const FileWidget(
                //         title: 'cam',
                //         extension: 'doc',
                //       ),
                //       const Divider(),
                //       FileWidget(
                //         title: translate(context, 'cam'),
                //         extension: 'xls',
                //       ),
                //       const Divider(),
                //       const FileWidget(
                //         title: 'cam',
                //         extension: 'jpg',
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
