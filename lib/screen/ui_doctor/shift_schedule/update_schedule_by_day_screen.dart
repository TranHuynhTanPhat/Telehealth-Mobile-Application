import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/menu_anchor_widget.dart';
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
  List<int> time = List<int>.generate(48, (i) => i);
  int countInputTimes = 1;
  List<TextEditingController> controllerBegin = [];
  List<TextEditingController> controllerEnd = [];
  List<int> begin = [];
  List<int> end = [];

  @override
  void initState() {
    controllerBegin.add(TextEditingController());
    controllerEnd.add(TextEditingController());
    begin.add(-1);
    end.add(-1);
    super.initState();
  }

  void addInputTimes() {
    setState(() {
      if (begin.last != -1 && end.last != -1) {
        countInputTimes++;
        controllerBegin.add(TextEditingController());
        controllerEnd.add(TextEditingController());
        begin.add(-1);
        end.add(-1);
      } else {
        EasyLoading.showToast(translate(context, 'please_choose'));
      }
    });
  }

  void removeInputTimes() {
    setState(() {
      countInputTimes--;
      controllerBegin.removeLast();
      controllerEnd.removeLast();
      begin.removeLast();
      end.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorScheduleCubit, DoctorScheduleState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          extendBody: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '${translate(context, 'update_schedule_on')} ${state.schedules.firstWhere((element) => element.id == state.scheduleId).date}',
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: dimensWidth() * 2),
                child: InkWell(
                  borderRadius: BorderRadius.circular(180),
                  onTap: () {
                    workingTimes = [];

                    for (int i = 0; i < countInputTimes; i++) {
                      if (begin[i] != -1 && end[i] != -1) {
                        for (int b = begin[i]; b < end[i]; b++) {
                          workingTimes.add(b);
                        }
                      }
                    }

                    context
                        .read<DoctorScheduleCubit>()
                        .updateScheduleByDay(workingTimes);
                  },
                  child: saveButton(context),
                ),
              )
            ],
          ),
          bottomSheet: Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: countInputTimes <= 24
                      ? () {
                          addInputTimes();
                        }
                      : null,
                  icon: FaIcon(
                    FontAwesomeIcons.plus,
                    // color: color1F1F1F,
                    size: dimensIcon(),
                  ),
                  disabledColor: black26,
                ),
              ),
              Expanded(
                child: IconButton(
                  // style: ButtonStyle(
                  //     iconColor: MaterialStatePropertyAll(
                  //         countInputTimes > 1 ? color1F1F1F : black26)),
                  onPressed: countInputTimes > 1
                      ? () {
                          removeInputTimes();
                        }
                      : null,
                  icon: FaIcon(
                    FontAwesomeIcons.minus,
                    // color: color1F1F1F,
                    size: dimensIcon(),
                  ),
                  disabledColor: black26,
                ),
              ),
            ],
          ),
          body: ListView(
            // shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.fromLTRB(dimensWidth() * 3, dimensHeight() * 2,
                dimensWidth() * 3, dimensHeight() * 15),
            children: [
              Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(
                      countInputTimes,
                      (index) => Padding(
                        padding: EdgeInsets.only(top: dimensHeight() * 2),
                        child: Row(
                          children: [
                            Expanded(
                                child: MenuAnchorWidget(
                              label: 'start',
                              enable: index == countInputTimes - 1,
                              textEditingController: controllerBegin[index],
                              menuChildren: time
                                  .where((element) {
                                    if (index > 0) {
                                      if (end[index - 1] < element) {
                                        return true;
                                      } else {
                                        return false;
                                      }
                                    }
                                    return true;
                                  })
                                  .map(
                                    (e) => MenuItemButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(white),
                                      ),
                                      onPressed: () => setState(() {
                                        controllerBegin[index].text =
                                            convertIntToTime(e);

                                        begin[index] = e;
                                      }),
                                      child: Text(
                                        convertIntToTime(e),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                                // MenuAnchor(
                                //   style: MenuStyle(
                                //     elevation: const MaterialStatePropertyAll(10),
                                //     shape: MaterialStateProperty.all<
                                //         RoundedRectangleBorder>(
                                //       RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(
                                //             dimensWidth() * 3),
                                //       ),
                                //     ),
                                //     backgroundColor:
                                //         const MaterialStatePropertyAll(white),
                                //     surfaceTintColor:
                                //         const MaterialStatePropertyAll(white),
                                //     padding: MaterialStatePropertyAll(
                                //         EdgeInsets.symmetric(
                                //             horizontal: dimensWidth() * 2,
                                //             vertical: dimensHeight())),
                                //   ),
                                //   builder: (BuildContext context,
                                //       MenuController controller, Widget? child) {
                                //     return TextFieldWidget(
                                //       enable: index == countInputTimes - 1,
                                //       onTap: () {
                                //         if (controller.isOpen) {
                                //           controller.close();
                                //         } else {
                                //           controller.open();
                                //         }
                                //       },
                                //       readOnly: true,
                                //       label: translate(context, 'start'),
                                //       controller: controllerBegin[index],
                                //       validate: (value) {
                                //         if (value!.isEmpty) {
                                //           return translate(
                                //               context, 'please_choose');
                                //         }
                                //         return null;
                                //       },
                                //       suffixIcon: const IconButton(
                                //           onPressed: null,
                                //           icon:
                                //               FaIcon(FontAwesomeIcons.caretDown)),
                                //     );
                                //   },
                                //   menuChildren: time
                                //       .where((element) {
                                //         if (index > 0) {
                                //           if (end[index - 1] < element) {
                                //             return true;
                                //           } else {
                                //             return false;
                                //           }
                                //         }
                                //         return true;
                                //       })
                                //       .map(
                                //         (e) => MenuItemButton(
                                //           style: const ButtonStyle(
                                //             backgroundColor:
                                //                 MaterialStatePropertyAll(white),
                                //           ),
                                //           onPressed: () => setState(() {
                                //             controllerBegin[index].text =
                                //                 convertIntToTime(e);

                                //             begin[index] = e;
                                //           }),
                                //           child: Text(
                                //             convertIntToTime(e),
                                //           ),
                                //         ),
                                //       )
                                //       .toList(),
                                // ),
                                ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: FaIcon(
                                FontAwesomeIcons.arrowRight,
                                color: black26,
                                size: dimensIcon() * .7,
                              ),
                            ),
                            Expanded(
                                child: MenuAnchorWidget(
                              label: 'end',
                              enable: index == countInputTimes - 1 &&
                                  begin[index] != -1,
                              textEditingController: controllerEnd[index],
                              menuChildren: time
                                  .where((element) {
                                    if (begin[index] < element) {
                                      return true;
                                    }
                                    return false;
                                  })
                                  .map(
                                    (e) => MenuItemButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(white),
                                      ),
                                      onPressed: () => setState(() {
                                        controllerEnd[index].text =
                                            convertIntToTime(e);

                                        end[index] = e;
                                      }),
                                      child: Text(
                                        convertIntToTime(e),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            )
                                // MenuAnchor(
                                //   style: MenuStyle(
                                //     elevation: const MaterialStatePropertyAll(10),
                                //     shape: MaterialStateProperty.all<
                                //         RoundedRectangleBorder>(
                                //       RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(
                                //             dimensWidth() * 3),
                                //       ),
                                //     ),
                                //     backgroundColor:
                                //         const MaterialStatePropertyAll(white),
                                //     surfaceTintColor:
                                //         const MaterialStatePropertyAll(white),
                                //     padding: MaterialStatePropertyAll(
                                //       EdgeInsets.symmetric(
                                //         horizontal: dimensWidth() * 2,
                                //         vertical: dimensHeight(),
                                //       ),
                                //     ),
                                //   ),
                                //   builder: (BuildContext context,
                                //       MenuController controller, Widget? child) {
                                //     return TextFieldWidget(
                                //       enable: index == countInputTimes - 1 &&
                                //           begin[index] != -1,
                                //       onTap: () {
                                //         if (controller.isOpen) {
                                //           controller.close();
                                //         } else {
                                //           controller.open();
                                //         }
                                //       },
                                //       readOnly: true,
                                //       label: translate(context, 'end'),
                                //       controller: controllerEnd[index],
                                //       validate: (value) {
                                //         if (value!.isEmpty) {
                                //           return translate(
                                //               context, 'please_choose');
                                //         }
                                //         return null;
                                //       },
                                //       suffixIcon: const IconButton(
                                //           onPressed: null,
                                //           icon:
                                //               FaIcon(FontAwesomeIcons.caretDown)),
                                //     );
                                //   },
                                //   menuChildren: time
                                //       .where((element) {
                                //         if (begin[index] < element) {
                                //           return true;
                                //         }
                                //         return false;
                                //       })
                                //       .map(
                                //         (e) => MenuItemButton(
                                //           style: const ButtonStyle(
                                //             backgroundColor:
                                //                 MaterialStatePropertyAll(white),
                                //           ),
                                //           onPressed: () => setState(() {
                                //             controllerEnd[index].text =
                                //                 convertIntToTime(e);

                                //             end[index] = e;
                                //           }),
                                //           child: Text(
                                //             convertIntToTime(e),
                                //           ),
                                //         ),
                                //       )
                                //       .toList(),
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
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
