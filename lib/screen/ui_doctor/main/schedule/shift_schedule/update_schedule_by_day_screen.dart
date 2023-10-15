import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/bases/base_gridview.dart';
import 'package:healthline/screen/ui_doctor/main/schedule/shift_schedule/components/invalid_shift.dart';
import 'package:healthline/screen/ui_doctor/main/schedule/shift_schedule/components/valid_shift.dart';
import 'package:healthline/screen/widgets/save_button.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';

class UpdateScheduleByDayScreen extends StatefulWidget {
  const UpdateScheduleByDayScreen({super.key});

  @override
  State<UpdateScheduleByDayScreen> createState() =>
      _UpdateScheduleByDayScreenState();
}

class _UpdateScheduleByDayScreenState extends State<UpdateScheduleByDayScreen> {
  List<int> workingTimes = [];
  List<int> time = List<int>.generate(48, (i) => i + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translate(context, 'update_schedule_by_day'),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: dimensWidth() * 2),
            child: InkWell(
              splashColor: transparent,
              highlightColor: transparent,
              onTap: () {
                // updateFixedSchedule();
              },
              child: saveButton(context),
            ),
          )
        ],
      ),
      body: BaseGridview(radio: 3.2, children: [
        ...time.map(
          (e) => InkWell(
            splashColor: transparent,
            highlightColor: transparent,
            onTap: () {
              setState(() {
                if (workingTimes.contains(e)) {
                  workingTimes.remove(e);
                } else {
                  workingTimes.add(e);
                }
              });
            },
            child: workingTimes.contains(e)
                ? ValidShift(time: convertIntToTime(e))
                : InvalidShift(
                    time: convertIntToTime(e),
                  ),
          ),
        )
      ]),
    );
  }
}
