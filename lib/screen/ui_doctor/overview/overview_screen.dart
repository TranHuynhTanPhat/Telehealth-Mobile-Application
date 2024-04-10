// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/responses/doctor_dasboard_response.dart';
import 'package:healthline/data/api/models/responses/money_chart_response.dart';
import 'package:healthline/data/api/models/responses/statistic_response.dart';
import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_doctor/overview/components/export.dart';
import 'package:healthline/utils/translate.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key, required this.callBack});
  final Function(DrawerMenu) callBack;


  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  DoctorDasboardResponse? dashboard;
  MoneyChartResponse? moneyChartResponse;
  StatisticResponse? statisticResponse;
  List<UserResponse>? familiarCus;
  List<UserResponse>? newCus;

  @override
  void initState() {
    if (!mounted) return;
    context.read<ConsultationCubit>().fetchConsultation();
    context.read<ConsultationCubit>().getDasboard();
    context.read<ConsultationCubit>().fetchStatisticTable();
    context.read<ConsultationCubit>().moneyChart(year: DateTime.now().year);
    context.read<ConsultationCubit>().getFamiliarCustomer();
    context.read<ConsultationCubit>().getNewCustomer();

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
        } else if (state is FetchStatisticTableState &&
            state.blocState == BlocState.Successed) {
          setState(() {
            statisticResponse = state.data;
          });
        } else if (state is FetchMoneyChartState &&
            state.blocState == BlocState.Successed) {
          setState(() {
            moneyChartResponse = state.data;
          });
        } else if (state is GetFamiliarCustomer &&
            state.blocState == BlocState.Successed) {
          setState(() {
            familiarCus = state.data;
          });
        } else if (state is GetNewCustomer &&
            state.blocState == BlocState.Successed) {
          setState(() {
            newCus = state.data;
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
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(bottom: dimensHeight() * 10),
              children: [
                 UpCommingAppointment(callBack: widget.callBack,),
                Overview(
                  dashboard: dashboard,
                ),

                if (statisticResponse != null)
                  StatisticTable(statisticResponse: statisticResponse!),

                if (moneyChartResponse != null)
                  RevenueChart(moneyChartResponse: moneyChartResponse!),

                if (familiarCus != null) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 3,
                        vertical: dimensHeight() * 2),
                    child: Text(
                      translate(context, 'loyal_customer'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: dimensHeight() * 2,
                    ),
                    child: CarouselSlider(
                      items: [
                        ...familiarCus!.map(
                          (e) => ShortPatient(
                            fullName:
                                e.fullName ?? translate(context, 'undefine'),
                            email: 'tranhuynhtanphat9380@gmail.com',
                            phone: '+84389052819',
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 4,
                          enlargeCenterPage: true,
                          enableInfiniteScroll: false,
                          viewportFraction: 0.8,
                          reverse: false,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale),
                    ),
                  ),
                ],

                if (newCus != null) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 3,
                        vertical: dimensHeight() * 2),
                    child: Text(
                      translate(context, 'new_customer'),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  ...newCus!.map((e) => ShortNewPatient(
                      fullName: e.fullName ?? translate(context, 'undefine'))),
                ],
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
