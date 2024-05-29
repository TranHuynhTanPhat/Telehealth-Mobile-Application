import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';

class ListHistoryConsultationScreen extends StatefulWidget {
  const ListHistoryConsultationScreen({super.key, required this.medicalId});
  final String? medicalId;

  @override
  State<ListHistoryConsultationScreen> createState() =>
      _ListHistoryConsultationScreenState();
}

class _ListHistoryConsultationScreenState
    extends State<ListHistoryConsultationScreen> {
  List<int> time = [];
  @override
  void initState() {
    if (!mounted) return;
    if (widget.medicalId == null) return;
    context
        .read<ConsultationCubit>()
        .fetchHistoryPatientConsultation(medicalId: widget.medicalId ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: white,
      appBar: AppBar(
        surfaceTintColor: transparent,
        scrolledUnderElevation: 0,
        backgroundColor: white,
        title: Text(
          translate(context, 'medical_examination_history'),
        ),
        centerTitle: false,
      ),
      body: BlocListener<ConsultationCubit, ConsultationState>(
        listener: (context, state) {
          if (state is FetchHistoryPatientConsultationState &&
              state.blocState == BlocState.Failed) {
            EasyLoading.showToast(translate(context, 'cant_load_data'));
          }
        },
        child: BlocBuilder<ConsultationCubit, ConsultationState>(
          builder: (context, state) {
            if (state is FetchHistoryPatientConsultationState) {
              return ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth() * 3,
                ),
                shrinkWrap: true,
                children: state.historyConsultation.map(
                  (e) {
                    String date = "";
                    try {
                      date = formatyMMMMd(
                          context, convertStringToDateTime(e.date)!);
                    } catch (e) {
                      date = "--";
                    }
                    try {
                      time = e.expectedTime
                              ?.split('-')
                              .map((e) => int.parse(e))
                              .toList() ??
                          [int.parse(e.expectedTime!)];
                    } catch (e) {
                      logPrint(e);
                    }
                    String expectedTime =
                        '${convertIntToTime(time.first)} - ${convertIntToTime(time.last + 1)}';
                    return InkWell(
                      hoverColor: transparent,
                      splashColor: transparent,
                      highlightColor: transparent,
                      onTap: () {
                        Navigator.pushNamed(context, detailHistoryConsultation,
                                arguments: e)
                            .then(
                          (value) => context
                              .read<ConsultationCubit>()
                              .fetchHistoryPatientConsultation(
                                  medicalId: widget.medicalId ?? ""),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: dimensWidth() * 2,
                          vertical: dimensHeight(),
                        ),
                        margin: EdgeInsets.symmetric(vertical: dimensHeight()),
                        decoration: BoxDecoration(
                          color: colorCDDEFF,
                          borderRadius: BorderRadius.circular(
                            dimensWidth() * 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "$date $expectedTime",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "${translate(context, "dr")}: ${e.doctor?.fullName ?? translate(context, 'undefine')}",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              "${translate(context, "prescription")}: ${translate(context, e.prescription != null ? 'available' : 'empty')}",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
