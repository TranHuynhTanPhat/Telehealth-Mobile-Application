import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/bases/base_listview_horizontal.dart';
import 'package:healthline/screen/components/slide_months_in_year.dart';
import 'package:healthline/screen/ui_patient/main/schedule/components/export.dart';

class CanceledFrame extends StatefulWidget {
  const CanceledFrame({super.key});

  @override
  State<CanceledFrame> createState() => _CanceledFrameState();
}

class _CanceledFrameState extends State<CanceledFrame> {
  final List<Map<String, dynamic>> appointments = [
    {
      'dr': 'Dr. Phat',
      'specialist': 'traumatologist',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 10, minute: 0),
      'end': const TimeOfDay(hour: 10, minute: 30),
      'status': 'canceled'
    },
    {
      'dr': 'Dr. Truong',
      'specialist': 'obstetrician',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.logoGoogle,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 11, minute: 0),
      'end': const TimeOfDay(hour: 11, minute: 30),
      'status': 'denied'
    },
    {
      'dr': 'Dr. Chien',
      'specialist': 'general_examination',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 8, minute: 0),
      'end': const TimeOfDay(hour: 8, minute: 30),
      'status': 'denied'
    },
    {
      'dr': 'Dr. Dang',
      'specialist': 'paeditrician',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 8, minute: 30),
      'end': const TimeOfDay(hour: 9, minute: 30),
      'status': 'canceled'
    },
    {
      'dr': 'Dr. Chien',
      'specialist': 'dermatologist',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 14, minute: 0),
      'end': const TimeOfDay(hour: 14, minute: 30),
      'status': 'canceled'
    },
  ];

  DateTime current = DateTime.now();
  late int daySelected;
  @override
  void initState() {
    daySelected = 0;
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
                daySelected: daySelected,
                callBack: (index, date) {
                  setState(() {
                    daySelected = index;
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
                  children:
                      state.consultations!.cancel.map((e) => CanceledCard(cancel:e)).toList(),
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
