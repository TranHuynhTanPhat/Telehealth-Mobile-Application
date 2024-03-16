import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/bases/base_gridview.dart';
import 'package:healthline/screen/ui_doctor/shift_schedule/components/valid_shift.dart';
import 'package:healthline/screen/widgets/date_slide.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';

class TimelineDoctorScreen extends StatefulWidget {
  const TimelineDoctorScreen({
    super.key,
    required this.doctor,
    required this.callback,
    required this.nextPage,
  });
  final DoctorResponse doctor;
  final VoidCallback nextPage;
  final Function({
    String? doctorId,
    String? medicalRecord,
    String? date,
    List<int>? expectedTime,
    String? discountCode,
    String? patientName,
    String? doctorName,
    String? symptoms,
    String? medicalHistory,
    List<String>? patientRecords,
  }) callback;

  @override
  State<TimelineDoctorScreen> createState() => _TimelineDoctorScreenState();
}

class _TimelineDoctorScreenState extends State<TimelineDoctorScreen> {
  // final List<int> time = List<int>.generate(48, (i) => i + 1);

  late int _daySelected;
  final List<int> _timeSelected = [];

  late DateTime now;

  // List<int> timeline = [];

  void dayPressed(int index, DateTime dateTime) {
    context.read<ConsultationCubit>().fetchTimeline(
        doctorId: widget.doctor.id!,
        date: '${dateTime.day}/${dateTime.month}/${dateTime.year}');
    setState(() {
      _daySelected = index;
      _timeSelected.clear();
      now = dateTime;
    });
  }

  @override
  void initState() {
    _daySelected = 0;
    now = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationCubit, ConsultationState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          extendBody: true,
          bottomNavigationBar: _timeSelected.isNotEmpty &&
                  _timeSelected
                      .every((element) => state.timeline.contains(element))
              ? Container(
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
                      widget.callback(
                          date: '${now.day}/${now.month}/${now.year}',
                          expectedTime: _timeSelected,
                          discountCode: "");
                      widget.nextPage();
                    },
                  ),
                )
              : null,
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
                  dateStart: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day + 1),
                ),
                const Divider(
                  thickness: 2,
                ),
                if (state.timeline.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 3,
                        vertical: dimensHeight()),
                    child: BaseGridview(
                      radio: 3.2,
                      children: [
                        ...state.timeline.map((e) {
                          return InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            onTap: () {
                              setState(() {
                                if (_timeSelected.length == 2) {
                                  _timeSelected.clear();
                                }
                                if (_timeSelected.isEmpty ||
                                    (_timeSelected.last - e).abs() == 1) {
                                  if (!_timeSelected.contains(e)) {
                                    _timeSelected.add(e);
                                  } else {
                                    _timeSelected.remove(e);
                                  }
                                } else {
                                  _timeSelected.clear();
                                  _timeSelected.add(e);
                                }
                              });
                            },
                            child: ValidShift(
                              time: convertIntToTime(e),
                              choosed: _timeSelected.contains(e),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
