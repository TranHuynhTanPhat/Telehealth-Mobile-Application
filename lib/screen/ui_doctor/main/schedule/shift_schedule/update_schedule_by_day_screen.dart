import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubit_doctor_schdule/doctor_schedule_cubit.dart';
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
    return BlocListener<DoctorScheduleCubit, DoctorScheduleState>(
      listener: (context, state) {
        if (state is ScheduleByDayUpdating) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
        } else if (state is ScheduleByDayUpdateError) {
          EasyLoading.dismiss();
        } else if (state is ScheduleByDayUpdateSuccessfully) {
          EasyLoading.showToast(translate(context, 'successfully'));
        }
      },
      child: Scaffold(
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
                  context
                      .read<DoctorScheduleCubit>()
                      .updateScheduleByDay(workingTimes);
                },
                child: saveButton(context),
              ),
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
              vertical: dimensHeight() * 2, horizontal: dimensWidth() * 3),
          children: [
            BaseGridview(radio: 3.2, children: [
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
          ],
        ),
      ),
    );
  }
}
