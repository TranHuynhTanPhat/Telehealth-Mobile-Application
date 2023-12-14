import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/bases/base_gridview.dart';
import 'package:healthline/screen/ui_doctor/shift_schedule/components/valid_shift.dart';
import 'package:healthline/screen/widgets/date_slide.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';

class TimelineDoctorScreen extends StatefulWidget {
  const TimelineDoctorScreen({super.key, required this.args});
  final String args;

  @override
  State<TimelineDoctorScreen> createState() => _TimelineDoctorScreenState();
}

class _TimelineDoctorScreenState extends State<TimelineDoctorScreen> {
  final List<int> time = List<int>.generate(48, (i) => i + 1);

  late int _daySelected;

  // List<int> timeline = [];

  void dayPressed(int index, DateTime dateTime) {
    context.read<ConsultationCubit>().fetchTimeline(
        doctorId: widget.args,
        date: '${dateTime.day}/${dateTime.month}/${dateTime.year}');
    setState(() {
      _daySelected = index;
    });
  }

  @override
  void initState() {
    _daySelected = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConsultationCubit, ConsultationState>(
      listener: (context, state) {
        if (state is FetchTimelineState) {
          if (state.blocState == BlocState.Failed) {
            Navigator.pop(context);
          }
        }
      },
      child: BlocBuilder<ConsultationCubit, ConsultationState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: white,
            extendBody: true,
            bottomNavigationBar: Container(
              padding: EdgeInsets.fromLTRB(
                dimensWidth() * 10,
                0,
                dimensWidth() * 10,
                dimensHeight() * 3,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.0), white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ElevatedButtonWidget(
                text: translate(context, 'book_appointment_now'),
                onPressed: () {
                  Navigator.pushNamed(context, paymentMethodsName);
                },
              ),
            ),
            appBar: AppBar(
              title: Text(
                translate(context, 'choose_time'),
              ),
            ),
            body: AbsorbPointer(
              absorbing: state is FetchTimelineState &&
                  state.blocState == BlocState.Pending,
              child: ListView(
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
                  if (state.timeline.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: dimensWidth() * 3,
                          vertical: dimensHeight()),
                      child: BaseGridview(
                        radio: 3.2,
                        children: [
                          ...state.timeline.map(
                            (e) => ValidShift(
                              time: convertIntToTime(e),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
