import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/bases/base_listview_horizontal.dart';
import 'package:healthline/screen/components/slide_months_in_year.dart';
import 'package:healthline/screen/schedule/components/export.dart';
import 'package:healthline/utils/log_data.dart';

class CompletedFrame extends StatefulWidget {
  const CompletedFrame({super.key});

  @override
  State<CompletedFrame> createState() => _CompletedFrameState();
}

class _CompletedFrameState extends State<CompletedFrame> {
  // final List<ConsultationResponse> appointments = [
  //   ConsultationResponse(
  //     id: '',
  //     doctor: null,
  //     medical: null,
  //     date: '2023-12-25T00:00:00.000Z',
  //     expectedTime: '',
  //     jistiToken: '',
  //     feedback: FeedbackResponse(
  //       id: "W5Fm2dAYEJrOBoXxW52Aj",
  //       rated: null,
  //       feedback: null,
  //     ),
  //   )
  // ];

  DateTime current = DateTime.now();
  late int monthSelected;
  @override
  void initState() {
    monthSelected = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationCubit, ConsultationState>(
      builder: (context, state) {
        if (state.consultations != null &&
            state.consultations!.finish.isNotEmpty) {
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SlideMonthsInYear(
                current: current,
                daySelected: monthSelected,
                callBack: (index, date) {
                  setState(() {
                    monthSelected = index;
                    current = date;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 0,
                    right: dimensWidth() * 3,
                    left: dimensWidth() * 3,
                    bottom: dimensHeight() * 10),
                child: BaseListviewHorizontal(
                  children: state.consultations!.finish.map((e) {
                    try {
                      DateTime date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                          .parse(e.date!);

                      if (DateTime(date.year, date.month) ==
                          DateTime(
                              current.year, current.month - monthSelected)) {
                        return CompletedCard(finish: e);
                      } else {
                        return const SizedBox();
                      }
                    } catch (e) {
                      logPrint(e);
                      return const SizedBox();
                    }
                    // => CompletedCard(finish: e)
                  }).toList(),
                ),
              ),
            ],
          );
        } else {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: dimensHeight() * 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.boxOpen,
                  color: color1F1F1F.withOpacity(.05),
                  size: dimensWidth() * 30,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
