import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/bases/base_gridview.dart';
import 'package:healthline/screen/ui_doctor/main/schedule/shift_schedule/components/export.dart';
import 'package:healthline/screen/widgets/save_button.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';

class UpdateDefaultScheduleScreen extends StatefulWidget {
  const UpdateDefaultScheduleScreen({super.key});

  @override
  State<UpdateDefaultScheduleScreen> createState() =>
      _UpdateDefaultScheduleScreenState();
}

class _UpdateDefaultScheduleScreenState
    extends State<UpdateDefaultScheduleScreen> {
  List<List<int>> schedules = List.generate(14, (index) => []);
  List<int> time = List<int>.generate(48, (i) => i + 1);
  int _currentStep = 0;

  void updateFixedSchedule() {
    context.read<DoctorScheduleCubit>().updateFixedSchedule(schedules);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorScheduleCubit, DoctorScheduleState>(
      listener: (context, state) {
        if (state is FixedScheduleUpdating) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
        } else if (state is FixedScheduleUpdateError) {
          EasyLoading.showToast(translate(context, state.message));
        } else if (state is FixedScheduleUpdateSuccessfully) {
          EasyLoading.showToast(translate(context, 'successfully'));
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            translate(context, 'update_fixed_schedule'),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: dimensWidth() * 2),
              child: InkWell(
                splashColor: transparent,
                highlightColor: transparent,
                onTap: () {
                  updateFixedSchedule();
                },
                child: saveButton(context),
              ),
            )
          ],
        ),
        body: BlocBuilder<DoctorScheduleCubit, DoctorScheduleState>(
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is FixedScheduleUpdating,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Stepper(
                    currentStep: _currentStep,
                    physics: const NeverScrollableScrollPhysics(),
                    connectorColor: const MaterialStatePropertyAll(secondary),
                    onStepTapped: (value) => setState(() {
                      _currentStep = value;
                    }),
                    onStepContinue: () => setState(() {
                      if (_currentStep < 13) {
                        _currentStep++;
                      } else {
                        updateFixedSchedule();
                      }
                    }),
                    controlsBuilder: (context, details) {
                      if (details.currentStep < 13) {
                        return TextButton(
                          onPressed: details.onStepContinue,
                          child: Text(
                            translate(context, 'continue'),
                          ),
                        );
                      } else {
                        return TextButton(
                          onPressed: details.onStepContinue,
                          child: Text(
                            translate(context, 'save'),
                          ),
                        );
                      }
                    },
                    steps: [
                      ...List.generate(
                        14,
                        (index) => Step(
                            title: Text(
                                '${translate(context, 'day')}: ${index + 1}'),
                            content: _currentStep == index
                                ? BaseGridview(radio: 3.2, children: [
                                    ...time.map(
                                      (e) => InkWell(
                                        splashColor: transparent,
                                        highlightColor: transparent,
                                        onTap: () {
                                          setState(() {
                                            if (schedules[index].contains(e)) {
                                              schedules[index].remove(e);
                                            } else {
                                              schedules[index].add(e);
                                            }
                                          });
                                        },
                                        child: schedules[index].contains(e)
                                            ? ValidShift(
                                                time: convertIntToTime(e))
                                            : InvalidShift(
                                                time: convertIntToTime(e),
                                              ),
                                      ),
                                    )
                                  ])
                                : const SizedBox(),
                            state: _currentStep == index
                                ? StepState.editing
                                : StepState.indexed),
                      ).toList(),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
