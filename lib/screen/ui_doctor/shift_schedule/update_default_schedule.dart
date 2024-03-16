import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/menu_anchor_widget.dart';
import 'package:healthline/screen/widgets/save_button.dart';
import 'package:healthline/utils/log_data.dart';
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
  List<List<int>> schedules = List.generate(7, (index) => []);
  List<int> time = List<int>.generate(48, (i) => i + 1);
  int _currentStep = 0;

  List<int> countInputTimes = List.generate(7, (index) => 1);
  List<List<TextEditingController>> controllerBegin =
      List.generate(7, (index) => [TextEditingController()]);
  List<List<TextEditingController>> controllerEnd =
      List.generate(7, (index) => [TextEditingController()]);
  List<List<int>> begin = List.generate(7, (index) => [-1]);
  List<List<int>> end = List.generate(7, (index) => [-1]);

  @override
  void initState() {
    super.initState();
  }

  void addInputTimes() {
    setState(() {
      if (begin[_currentStep].last != -1 && end[_currentStep].last != -1) {
        countInputTimes[_currentStep]++;
        controllerBegin[_currentStep].add(TextEditingController());
        controllerEnd[_currentStep].add(TextEditingController());
        begin[_currentStep].add(-1);
        end[_currentStep].add(-1);
      } else {
        EasyLoading.showToast(translate(context, 'please_choose'));
      }
    });
  }

  void removeInputTimes() {
    setState(() {
      countInputTimes[_currentStep]--;
      controllerBegin[_currentStep].removeLast();
      controllerEnd[_currentStep].removeLast();
      begin[_currentStep].removeLast();
      end[_currentStep].removeLast();
    });
  }

  void updateFixedSchedule() {
    context.read<DoctorScheduleCubit>().updateFixedSchedule(schedules);
  }

  void updateWorkingTime() {
    schedules[_currentStep] = [];
    for (int i = 0; i < countInputTimes[_currentStep]; i++) {
      if (begin[_currentStep][i] != -1 && end[_currentStep][i] != -1) {
        for (int b = begin[_currentStep][i]; b <= end[_currentStep][i]; b++) {
          schedules[_currentStep].add(b);
        }
      }
    }
  }

  String changeDate(int num) {
    String locale = Localizations.localeOf(context).languageCode;
    switch (num) {
      case 1:
        if (locale == 'vi') {
          return 'Thứ hai';
        } else {
          return 'Monday';
        }
      case 2:
        if (locale == 'vi') {
          return 'Thứ ba';
        } else {
          return 'Tuesday';
        }
      case 3:
        if (locale == 'vi') {
          return 'Thứ tư';
        } else {
          return 'Wednesday';
        }
      case 4:
        if (locale == 'vi') {
          return 'Thứ năm';
        } else {
          return 'Thursday';
        }
      case 5:
        if (locale == 'vi') {
          return 'Thứ sáu';
        } else {
          return 'Friday';
        }
      case 6:
        if (locale == 'vi') {
          return 'Thứ bảy';
        } else {
          return 'Saturday';
        }
      default:
        if (locale == 'vi') {
          return 'Chủ nhật';
        } else {
          return 'Sunday';
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translate(context, 'update_fixed_schedule'),
        ),
        // leading: Center(
        //     child: InkWell(
        //   splashColor: transparent,
        //   highlightColor: transparent,
        //   onTap: () {
        //     Navigator.pop(context, false);
        //   },
        //   child: const FaIcon(FontAwesomeIcons.angleLeft),
        // )),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: dimensWidth() * 2),
            child: InkWell(
              borderRadius: BorderRadius.circular(180),
              onTap: () {
                updateFixedSchedule();
                // updateWorkingTime();
                // logPrint(begin);
                // logPrint(end);
                // for (var element in schedules) {
                //   logPrint(element);
                // }
              },
              child: saveButton(context),
            ),
          )
        ],
      ),
      body: BlocListener<DoctorScheduleCubit, DoctorScheduleState>(
        listener: (context, state) {
          // if (state is UpdateFixedScheduleState) {
          //   if (state.blocState == BlocState.Successed) {
          //     Navigator.pop(context, true);
          //   }
          // }
        },
        child: BlocBuilder<DoctorScheduleCubit, DoctorScheduleState>(
          builder: (context, state) {
            return AbsorbPointer(
              // absorbing: state.blocState == BlocState.Pending,
              absorbing: false,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Stepper(
                    currentStep: _currentStep,
                    physics: const NeverScrollableScrollPhysics(),
                    connectorColor: const MaterialStatePropertyAll(secondary),
                    onStepTapped: (value) => setState(() {
                      updateWorkingTime();
                      _currentStep = value;
                    }),
                    onStepContinue: () => setState(() {
                      updateWorkingTime();
                      if (_currentStep < 6) {
                        _currentStep++;
                      } else {
                        updateFixedSchedule();
                      }
                    }),
                    controlsBuilder: (context, details) {
                      if (details.currentStep < 6) {
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
                        7,
                        (index) => Step(
                            title: Text(changeDate(index)),
                            content: _currentStep == index
                                ? Form(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ...List.generate(
                                          countInputTimes[_currentStep],
                                          (index) => Padding(
                                            padding: EdgeInsets.only(
                                                top: dimensHeight() * 2),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: MenuAnchorWidget(
                                                  enable: index ==
                                                      countInputTimes[
                                                              _currentStep] -
                                                          1,
                                                  textEditingController:
                                                      controllerBegin[
                                                          _currentStep][index],
                                                  menuChildren: time
                                                      .where((element) {
                                                        if (index > 0) {
                                                          if (end[_currentStep]
                                                                  [index - 1] <
                                                              element - 1) {
                                                            return true;
                                                          } else {
                                                            return false;
                                                          }
                                                        }
                                                        return true;
                                                      })
                                                      .map(
                                                        (e) => MenuItemButton(
                                                          style:
                                                              const ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll(
                                                                    white),
                                                          ),
                                                          onPressed: () =>
                                                              setState(() {
                                                            controllerBegin[_currentStep]
                                                                        [index]
                                                                    .text =
                                                                convertIntToTime(
                                                                    e - 1);

                                                            begin[_currentStep]
                                                                [index] = e - 1;
                                                            logPrint(begin);
                                                            logPrint(end);
                                                          }),
                                                          child: Text(
                                                            convertIntToTime(
                                                                e - 1),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  label: 'start',
                                                )),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.arrowRight,
                                                    color: black26,
                                                    size: dimensIcon() * .7,
                                                  ),
                                                ),
                                                Expanded(
                                                    child: MenuAnchorWidget(
                                                  enable: index ==
                                                          countInputTimes[
                                                                  _currentStep] -
                                                              1 &&
                                                      begin[_currentStep]
                                                              [index] !=
                                                          -1,
                                                  textEditingController:
                                                      controllerEnd[
                                                          _currentStep][index],
                                                  menuChildren: time
                                                      .where((element) {
                                                        if (begin[_currentStep]
                                                                [index] <
                                                            element - 1) {
                                                          return true;
                                                        }
                                                        return false;
                                                      })
                                                      .map(
                                                        (e) => MenuItemButton(
                                                          style:
                                                              const ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStatePropertyAll(
                                                                    white),
                                                          ),
                                                          onPressed: () =>
                                                              setState(() {
                                                            controllerEnd[_currentStep]
                                                                        [index]
                                                                    .text =
                                                                convertIntToTime(
                                                                    e - 1);

                                                            end[_currentStep]
                                                                [index] = e - 1;
                                                          }),
                                                          child: Text(
                                                            convertIntToTime(
                                                                e - 1),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  label: 'end',
                                                )

                                                    // MenuAnchor(
                                                    //   style: MenuStyle(
                                                    //     elevation:
                                                    //         const MaterialStatePropertyAll(
                                                    //             10),
                                                    //     shape: MaterialStateProperty
                                                    //         .all<
                                                    //             RoundedRectangleBorder>(
                                                    //       RoundedRectangleBorder(
                                                    //         borderRadius:
                                                    //             BorderRadius.circular(
                                                    //                 dimensWidth() *
                                                    //                     3),
                                                    //       ),
                                                    //     ),
                                                    //     backgroundColor:
                                                    //         const MaterialStatePropertyAll(
                                                    //             white),
                                                    //     surfaceTintColor:
                                                    //         const MaterialStatePropertyAll(
                                                    //             white),
                                                    //     padding:
                                                    //         MaterialStatePropertyAll(
                                                    //       EdgeInsets.symmetric(
                                                    //         horizontal:
                                                    //             dimensWidth() * 2,
                                                    //         vertical:
                                                    //             dimensHeight(),
                                                    //       ),
                                                    //     ),
                                                    //   ),
                                                    //   builder: (BuildContext
                                                    //           context,
                                                    //       MenuController controller,
                                                    //       Widget? child) {
                                                    //     return TextFieldWidget(
                                                    //       enable: index ==
                                                    //               countInputTimes[
                                                    //                       _currentStep] -
                                                    //                   1 &&
                                                    //           begin[_currentStep]
                                                    //                   [index] !=
                                                    //               -1,
                                                    //       onTap: () {
                                                    //         if (controller.isOpen) {
                                                    //           controller.close();
                                                    //         } else {
                                                    //           controller.open();
                                                    //         }
                                                    //       },
                                                    //       readOnly: true,
                                                    //       label: translate(
                                                    //           context, 'end'),
                                                    //       controller: controllerEnd[
                                                    //           _currentStep][index],
                                                    //       validate: (value) {
                                                    //         if (value!.isEmpty) {
                                                    //           return translate(
                                                    //               context,
                                                    //               'please_choose');
                                                    //         }
                                                    //         return null;
                                                    //       },
                                                    //       suffixIcon: const IconButton(
                                                    //           onPressed: null,
                                                    //           icon: FaIcon(
                                                    //               FontAwesomeIcons
                                                    //                   .caretDown)),
                                                    //     );
                                                    //   },
                                                    // menuChildren: time
                                                    //     .where((element) {
                                                    //       if (begin[_currentStep]
                                                    //               [index] <
                                                    //           element) {
                                                    //         return true;
                                                    //       }
                                                    //       return false;
                                                    //     })
                                                    //     .map(
                                                    //       (e) => MenuItemButton(
                                                    //         style:
                                                    //             const ButtonStyle(
                                                    //           backgroundColor:
                                                    //               MaterialStatePropertyAll(
                                                    //                   white),
                                                    //         ),
                                                    //         onPressed: () =>
                                                    //             setState(() {
                                                    //           controllerEnd[_currentStep]
                                                    //                       [index]
                                                    //                   .text =
                                                    //               convertIntToTime(
                                                    //                   e);

                                                    //           end[_currentStep]
                                                    //               [index] = e;
                                                    //         }),
                                                    //         child: Text(
                                                    //           convertIntToTime(e),
                                                    //         ),
                                                    //       ),
                                                    //     )
                                                    //     .toList(),
                                                    // ),
                                                    ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // BaseGridview(radio: 3.2, children: [
                                        //   ...time.map(
                                        //     (e) => InkWell(
                                        //       splashColor: transparent,
                                        //       highlightColor: transparent,
                                        //       onTap: () {
                                        //         setState(() {
                                        //           if (workingTimes.contains(e)) {
                                        //             workingTimes.remove(e);
                                        //           } else {
                                        //             workingTimes.add(e);
                                        //           }
                                        //         });
                                        //       },
                                        //       child: workingTimes.contains(e)
                                        //           ? ValidShift(time: convertIntToTime(e))
                                        //           : InvalidShift(
                                        //               time: convertIntToTime(e),
                                        //             ),
                                        //     ),
                                        //   )
                                        // ]),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: dimensHeight() * 2),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: IconButton(
                                                  onPressed: countInputTimes[
                                                              _currentStep] <=
                                                          24
                                                      ? () {
                                                          addInputTimes();
                                                        }
                                                      : null,
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.plus,
                                                    // color: color1F1F1F,
                                                    size: dimensIcon() * .5,
                                                  ),
                                                  disabledColor: black26,
                                                ),
                                              ),
                                              Expanded(
                                                child: IconButton(
                                                  // style: ButtonStyle(
                                                  //     iconColor: MaterialStatePropertyAll(
                                                  //         countInputTimes > 1 ? color1F1F1F : black26)),
                                                  onPressed: countInputTimes[
                                                              _currentStep] >
                                                          1
                                                      ? () {
                                                          removeInputTimes();
                                                        }
                                                      : null,
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.minus,
                                                    // color: color1F1F1F,
                                                    size: dimensIcon() * .5,
                                                  ),
                                                  disabledColor: black26,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                // BaseGridview(radio: 3.2, children: [
                                //     ...time.map(
                                //       (e) => InkWell(
                                //         splashColor: transparent,
                                //         highlightColor: transparent,
                                //         onTap: () {
                                //           setState(() {
                                //             if (schedules[index].contains(e)) {
                                //               schedules[index].remove(e);
                                //             } else {
                                //               schedules[index].add(e);
                                //             }
                                //           });
                                //         },
                                //         child: schedules[index].contains(e)
                                //             ? ValidShift(
                                //                 time: convertIntToTime(e))
                                //             : InvalidShift(
                                //                 time: convertIntToTime(e),
                                //               ),
                                //       ),
                                //     )
                                //   ])
                                : const SizedBox(),
                            state: _currentStep == index
                                ? StepState.editing
                                : StepState.indexed),
                      ),
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
