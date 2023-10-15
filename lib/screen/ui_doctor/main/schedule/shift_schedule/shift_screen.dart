import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_doctor/main/schedule/shift_schedule/components/export.dart';

import 'package:intl/intl.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/schedule_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/bases/base_gridview.dart';
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

  @override
  void initState() {
    _currentDate = DateTime.now();
    context.read<DoctorScheduleCubit>().fetchSchedule();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorScheduleCubit, DoctorScheduleState>(
      listenWhen: (previous, current) => current is FetchScheduleState,
      listener: (context, state) {
        if (state is FetchScheduleLoading || state is CronScheduleLoading) {
          EasyLoading.show();
        } else if (state is FetchScheduleSuccessfully ||
            state is CronScheduleSuccessfully) {
          EasyLoading.dismiss();
        } else if (state is FetchScheduleError) {
          EasyLoading.showToast(state.message);
        } else if (state is CronScheduleError) {
          EasyLoading.showToast(state.message);
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<DoctorScheduleCubit, DoctorScheduleState>(
        buildWhen: (previous, current) => current is FetchScheduleState,
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: white,
            appBar: AppBar(
              title: Text(
                translate(context, 'your_shift'),
              ),
              actions: [
                PopupMenuButton(
                  shadowColor: black26,
                  offset: Offset.zero,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        Navigator.pushNamed(
                            context, updateDefaultScheduleDoctorName);
                      },
                      child: Text(
                        translate(context, 'update_fixed_schedule'),
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        if (state.scheduleId != null) {
                          Navigator.pushNamed(
                              context, updateScheduleByDayDoctorName);
                        }
                      },
                      child: Text(
                        translate(context, 'update_schedule_by_day'),
                      ),
                    )
                  ],
                ),
                // Padding(
                //   padding: EdgeInsets.only(right: dimensWidth() * 3),
                //   child: AbsorbPointer(
                //     absorbing: state is FetchInjectedVaccinationLoading,
                //     child: InkWell(
                //       onTap: () async {
                //         // await Navigator.pushNamed(context, addVaccinationName);
                //       },
                //       splashColor: transparent,
                //       highlightColor: transparent,
                //       child: FaIcon(
                //         FontAwesomeIcons.pen,
                //         color: color1F1F1F,
                //         size: dimensIcon() * .7,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            body: AbsorbPointer(
              absorbing:
                  state is FetchScheduleLoading || state is CronScheduleLoading,
              child: NestedScrollView(
                body: SafeArea(
                  child: ListView(
                    padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                    children: [
                      CalendarDatePicker(
                        initialDate: _currentDate,
                        firstDate: DateTime.now(), // Ngày tạo tk cho bác sĩ
                        lastDate: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day + 13),
                        currentDate: _currentDate,
                        onDateChanged: (value) {
                          setState(() {
                            _currentDate = value;
                            String? id = state.schedules.firstWhere(
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
                                workingTimes: [],
                              ),
                            ).id;
                            context
                                .read<DoctorScheduleCubit>()
                                .updateScheduleId(id);
                          });
                        },
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: dimensWidth() * 3,
                            vertical: dimensHeight()),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: colorCDDEFF,
                                  ),
                                  Text(
                                    translate(context, 'available'),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor:
                                        colorDF9F1E.withOpacity(.2),
                                  ),
                                  Text(
                                    translate(context, 'booked'),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: colorCDDEFF,
                                    child: CircleAvatar(
                                      radius: 9,
                                      backgroundColor: white,
                                    ),
                                  ),
                                  Text(
                                    translate(context, 'empty'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: dimensWidth() * 3,
                            vertical: dimensHeight()),
                        child: BaseGridview(radio: 3.2, children: [
                          ...time.map(
                            (e) => state.schedules
                                    .firstWhere(
                                      (element) {
                                        DateTime dateTime =
                                            DateFormat('dd/MM/yyyy')
                                                .parse(element.date!);
                                        if (dateTime.day == _currentDate.day &&
                                            dateTime.month ==
                                                _currentDate.month &&
                                            dateTime.year ==
                                                _currentDate.year) {
                                          return true;
                                        } else {
                                          return false;
                                        }
                                      },
                                      orElse: () => ScheduleResponse(
                                        date: _currentDate.toString(),
                                        workingTimes: [],
                                      ),
                                    )
                                    .workingTimes!
                                    .contains(e)
                                ? ValidShift(
                                    time: convertIntToTime(e),
                                  )
                                : InvalidShift(
                                    time: convertIntToTime(e),
                                  ),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      centerTitle: false,
                      snap: false,
                      pinned: true,
                      floating: false,
                      leading: const SizedBox(),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: dimensWidth() * 3),
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
                      ),
                    ),
                  ];
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class BookedShift extends StatelessWidget {
  const BookedShift({
    super.key,
    required this.time,
  });
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: dimensWidth(),
      padding: EdgeInsets.all(
        dimensWidth(),
      ),
      decoration: BoxDecoration(
          color: colorDF9F1E.withOpacity(.2),
          borderRadius: BorderRadius.circular(dimensWidth())),
      alignment: Alignment.center,
      child: Text(
        time,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
