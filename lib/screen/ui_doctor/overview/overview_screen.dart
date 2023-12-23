import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/responses/doctor_dasboard_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_doctor/overview/components/export.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  DoctorDasboardResponse? dashboard;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ConsultationCubit, ConsultationState>(
      listener: (context, state) {
        if (state is GetDasboardState &&
            state.blocState == BlocState.Successed) {
          setState(() {
            dashboard = state.dashboard;
          });
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
                        // ReportCard(),
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
                        left: dimensWidth() * 3, right: dimensWidth() * 3),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: state.consultations!.coming.map((cons) {
                          List<int> time = [];
                          try {
                            time = cons.expectedTime
                                    ?.split('-')
                                    .map((e) => int.parse(e))
                                    .toList() ??
                                [int.parse(cons.expectedTime!)];
                          } catch (e) {
                            logPrint(e);
                          }
                          String? expectedTime;
                          try {
                            expectedTime =
                                '${convertIntToTime(time.first - 1)} - ${convertIntToTime(time.last)}';
                          } catch (e) {
                            logPrint(e);
                          }
                          return ListTile(
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
                              backgroundImage: AssetImage(DImages.placeholder),
                              radius: dimensWidth() * 3,
                            ),
                            title: Text(
                              '${translate(context, "symptoms")}: ${translate(context, cons.symptoms ?? "undefine")}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cons.medical!.fullName ??
                                      translate(context, 'undefine'),
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ],
                            ),
                            trailing: Text(
                              expectedTime ?? "--:--",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          );
                        }).toList()),
                  ),
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
