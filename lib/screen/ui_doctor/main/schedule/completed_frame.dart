import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/bases/base_listview_horizontal.dart';
import './components/export.dart';

class CompletedFrame extends StatefulWidget {
  const CompletedFrame({super.key});

  @override
  State<CompletedFrame> createState() => _CompletedFrameState();
}

class _CompletedFrameState extends State<CompletedFrame> {
  final List<Map<String, dynamic>> appointments = [
    {
      'dr': 'Dr. Phat',
      'specialist': 'traumatologist',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 10, minute: 0),
      'end': const TimeOfDay(hour: 10, minute: 30),
      'status': 'finished'
    },
    {
      'dr': 'Dr. Truong',
      'specialist': 'obstetrician',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.logoGoogle,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 11, minute: 0),
      'end': const TimeOfDay(hour: 11, minute: 30),
      'status': 'finished'
    },
    {
      'dr': 'Dr. Chien',
      'specialist': 'general_examination',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 8, minute: 0),
      'end': const TimeOfDay(hour: 8, minute: 30),
      'status': 'finished'
    },
    {
      'dr': 'Dr. Dang',
      'specialist': 'paeditrician',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 8, minute: 30),
      'end': const TimeOfDay(hour: 9, minute: 30),
      'status': 'finished'
    },
    {
      'dr': 'Dr. Chien',
      'specialist': 'dermatologist',
      'patient': 'Tran Huynh Tan Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'begin': const TimeOfDay(hour: 14, minute: 0),
      'end': const TimeOfDay(hour: 14, minute: 30),
      'status': 'finished'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(vertical: dimensWidth()),
      children: [
        const SlideMonthsInYear(),
        Padding(
          padding: EdgeInsets.only(
              top: 0,
              right: dimensWidth() * 3,
              left: dimensWidth() * 3,
              bottom: dimensHeight() * 10),
          child: BaseListviewHorizontal(
            children:
                appointments.map((e) => CompletedCard(object: e)).toList(),
          ),
        ),
      ],
    );
  }
}
