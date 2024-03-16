import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:intl/intl.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/schedule_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/bases/base_gridview.dart';
import 'package:healthline/screen/ui_doctor/shift_schedule/components/export.dart';
import 'package:healthline/screen/widgets/date_slide.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';

class ShiftScreen extends StatefulWidget {
  const ShiftScreen({super.key});

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  late DateTime _currentDate;
  List<int> time = List<int>.generate(48, (i) => i + 1);

  late int _daySelected;

  void dayPressed(int index, DateTime dateTime) {
    setState(() {
      _daySelected = index;
      _currentDate = dateTime;
    });
  }

  @override
  void initState() {
    _currentDate = DateTime.now();
    _daySelected = 0;
    context.read<DoctorScheduleCubit>().fetchSchedule();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorScheduleCubit, DoctorScheduleState>(
      builder: (context, state) {
        if (state.schedules.isNotEmpty) {
          String? currentMedicalId = state.schedules.firstWhere((element) {
            DateTime dateTime = DateFormat('dd/MM/yyyy').parse(element.date!);
            if (dateTime.day == _currentDate.day &&
                dateTime.month == _currentDate.month &&
                dateTime.year == _currentDate.year) {
              return true;
            } else {
              return false;
            }
          }).id;
          if (state.scheduleId != currentMedicalId) {
            context
                .read<DoctorScheduleCubit>()
                .updateScheduleId(currentMedicalId);
          }
        }
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          extendBody: true,
          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(
                dimensWidth() * 10, 0, dimensWidth() * 10, dimensHeight() * 3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.0), white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ElevatedButtonWidget(
                text: translate(context, 'update_fixed_schedule'),
                onPressed: () {
                  Navigator.pushNamed(context, updateDefaultScheduleDoctorName)
                      .then((value) => {
                            if (value == true)
                              {
                                context
                                    .read<DoctorScheduleCubit>()
                                    .fetchSchedule(),
                              }
                          });
                }),
          ),
          body: AbsorbPointer(
            absorbing:
                state.blocState == BlocState.Pending && state.schedules.isEmpty,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    centerTitle: false,
                    snap: false,
                    pinned: true,
                    floating: false,
                    leading: const SizedBox(),
                    // expandedHeight: dimensHeight()*10,
                    collapsedHeight: dimensHeight() * 10,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: dimensWidth() * 3),
                                child: Text(
                                  translate(context, 'schedule'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: dimensWidth() * 3),
                                child: Text(
                                  formatyMMMMd(context, _currentDate),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: color1F1F1F.withOpacity(.3),
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: dimensWidth() * 3),
                            child: TextButton(
                                onPressed: () {
                                  if (state.scheduleId != null) {
                                    Navigator.pushNamed(context,
                                            updateScheduleByDayDoctorName)
                                        .then((value) => context
                                            .read<DoctorScheduleCubit>()
                                            .fetchSchedule());
                                  }
                                },
                                child: Text(translate(context, 'update'))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: ListView(
                padding: EdgeInsets.only(bottom: dimensHeight() * 15),
                children: [
                  DateSlide(
                    daysLeft: 7,
                    dayPressed: dayPressed,
                    daySelected: _daySelected,
                    dateStart: DateTime.now(),
                  ),

                  const Divider(
                    thickness: 2,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(
                  //       horizontal: dimensWidth() * 3,
                  //       vertical: dimensHeight()),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Expanded(
                  //         child: Row(
                  //           children: [
                  //             const CircleAvatar(
                  //               radius: 10,
                  //               backgroundColor: colorCDDEFF,
                  //             ),
                  //             Text(
                  //               translate(context, 'available'),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             CircleAvatar(
                  //               radius: 10,
                  //               backgroundColor: colorDF9F1E.withOpacity(.2),
                  //             ),
                  //             Text(
                  //               translate(context, 'booked'),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             const CircleAvatar(
                  //               radius: 10,
                  //               backgroundColor: colorCDDEFF,
                  //               child: CircleAvatar(
                  //                 radius: 9,
                  //                 backgroundColor: white,
                  //               ),
                  //             ),
                  //             Text(
                  //               translate(context, 'empty'),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  if (state.schedules.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: dimensWidth() * 3,
                          vertical: dimensHeight()),
                      child: BaseGridview(
                        radio: 3.2,
                        children: [
                          ...state.schedules
                              .firstWhere(
                                (element) {
                                  DateTime dateTime = DateFormat('dd/MM/yyyy')
                                      .parse(element.date!);
                                  if (dateTime.day == _currentDate.day &&
                                      dateTime.month == _currentDate.month &&
                                      dateTime.year == _currentDate.year) {
                                    return true;
                                  } else {
                                    return false;
                                  }
                                },
                                orElse: () => ScheduleResponse(
                                    date: _currentDate.toString(),
                                    workingTimes: []),
                              )
                              .workingTimes!
                              .map(
                                (e) => ValidShift(
                                  time: convertIntToTime(((e) ?? 0)),
                                ),
                              ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// class BookedShift extends StatelessWidget {
//   const BookedShift({
//     super.key,
//     required this.time,
//   });
//   final String time;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       height: dimensWidth(),
//       padding: EdgeInsets.all(
//         dimensWidth(),
//       ),
//       decoration: BoxDecoration(
//           color: colorDF9F1E.withOpacity(.2),
//           borderRadius: BorderRadius.circular(dimensWidth())),
//       alignment: Alignment.center,
//       child: Text(
//         time,
//         style: Theme.of(context).textTheme.labelLarge,
//       ),
//     );
//   }
// }
