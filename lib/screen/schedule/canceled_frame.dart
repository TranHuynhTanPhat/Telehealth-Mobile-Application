import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/bases/base_listview_horizontal.dart';
import 'package:healthline/screen/components/slide_months_in_year.dart';
import 'package:healthline/screen/schedule/components/export.dart';
import 'package:intl/intl.dart';

class CanceledFrame extends StatefulWidget {
  const CanceledFrame({super.key});

  @override
  State<CanceledFrame> createState() => _CanceledFrameState();
}

class _CanceledFrameState extends State<CanceledFrame> {
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
            state.consultations!.cancel.isNotEmpty) {
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
                  children: state.consultations!.cancel.map((e) {
                    DateTime date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                        .parse(e.date!);
                    if (DateTime(date.year, date.month) ==
                        DateTime(
                          current.year,
                          current.month - monthSelected,
                        )) {
                      return CanceledCard(cancel: e);
                    } else {
                      return const SizedBox();
                    }
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
