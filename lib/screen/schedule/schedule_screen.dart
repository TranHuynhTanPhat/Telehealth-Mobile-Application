import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/schedule/canceled_frame.dart';
import 'package:healthline/screen/schedule/completed_frame.dart';
import 'package:healthline/screen/schedule/upcoming_frame.dart';
import 'package:healthline/utils/translate.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late ScheduleTabBar _currentIndex;
  @override
  void initState() {
    _currentIndex = ScheduleTabBar.UpComing;
    if (!mounted) return;
    context.read<ConsultationCubit>().fetchConsultation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConsultationCubit, ConsultationState>(
      listener: (context, state) {
        if (state.blocState == BlocState.Pending) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
        } else if (state.blocState == BlocState.Failed) {
          EasyLoading.showToast(translate(context, state.error));
        } else {
          EasyLoading.dismiss();
          if (state is CancelConsultationState ||
              state is ConfirmConsultationState ||
              state is DenyConsultationState) {
            EasyLoading.showToast(translate(context, 'successfully'));
            context.read<ConsultationCubit>().fetchConsultation();
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        extendBody: true,
        // extendBodyBehindAppBar: true,
        appBar: AppController().authState == AuthState.PatientAuthorized
            ? AppBar(
                surfaceTintColor: transparent,
                scrolledUnderElevation: 0,
                backgroundColor: white,
                title: Padding(
                  padding: EdgeInsets.only(left: dimensWidth()),
                  child: Text(
                    translate(context, 'my_appointments'),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: color1F1F1F, fontWeight: FontWeight.w900),
                  ),
                ),
                centerTitle: false,
              )
            : null,
        body: Stack(
          children: [
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: dimensWidth()),
              children: [
                Container(
                  margin: EdgeInsets.only(top: dimensHeight() * 10),
                ),
                if (_currentIndex == ScheduleTabBar.UpComing)
                  const UpcomingFrame()
                else if (_currentIndex == ScheduleTabBar.Completed)
                  const CompletedFrame()
                else if (_currentIndex == ScheduleTabBar.Canceled)
                  const CanceledFrame()
              ],
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    white,
                    white,
                    white,
                    Colors.white.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Container(
                height: dimensHeight() * 8,
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(dimensWidth() * 3),
                ),
                padding: EdgeInsets.all(
                  dimensWidth(),
                ),
                margin: EdgeInsets.only(
                    left: dimensWidth() * 3,
                    right: dimensWidth() * 3,
                    top: dimensHeight() * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: dimensWidth() * 15,
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              decoration: BoxDecoration(
                                color: _currentIndex == ScheduleTabBar.UpComing
                                    ? primary
                                    : white,
                                borderRadius:
                                    BorderRadius.circular(dimensWidth() * 2),
                              ),
                              curve: Curves.fastLinearToSlowEaseIn,
                              height: _currentIndex == ScheduleTabBar.UpComing
                                  ? dimensWidth() * 6
                                  : 0,
                              width: _currentIndex == ScheduleTabBar.UpComing
                                  ? dimensWidth() * 15
                                  : 0,
                            ),
                          ),
                          SizedBox(
                            height: dimensHeight() * 6,
                            width: double.maxFinite,
                            child: InkWell(
                              splashColor: transparent,
                              highlightColor: transparent,
                              enableFeedback: false,
                              onTap: () {
                                setState(() {
                                  _currentIndex = ScheduleTabBar.UpComing;
                                });
                              },
                              child: Center(
                                child: Text(
                                  translate(context, 'upcoming'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                          color: _currentIndex ==
                                                  ScheduleTabBar.UpComing
                                              ? white
                                              : black26),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: dimensWidth() * 15,
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              decoration: BoxDecoration(
                                color: _currentIndex == ScheduleTabBar.Completed
                                    ? primary
                                    : white,
                                borderRadius:
                                    BorderRadius.circular(dimensWidth() * 2),
                              ),
                              curve: Curves.fastLinearToSlowEaseIn,
                              height: _currentIndex == ScheduleTabBar.Completed
                                  ? dimensWidth() * 6
                                  : 0,
                              width: _currentIndex == ScheduleTabBar.Completed
                                  ? dimensWidth() * 15
                                  : 0,
                            ),
                          ),
                          SizedBox(
                            height: dimensHeight() * 6,
                            width: double.maxFinite,
                            child: InkWell(
                              splashColor: transparent,
                              highlightColor: transparent,
                              enableFeedback: false,
                              onTap: () {
                                setState(() {
                                  _currentIndex = ScheduleTabBar.Completed;
                                });
                              },
                              child: Center(
                                child: Text(
                                  translate(context, 'completed'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                          color: _currentIndex ==
                                                  ScheduleTabBar.Completed
                                              ? white
                                              : black26),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: dimensWidth() * 15,
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              decoration: BoxDecoration(
                                color: _currentIndex == ScheduleTabBar.Canceled
                                    ? primary
                                    : white,
                                borderRadius:
                                    BorderRadius.circular(dimensWidth() * 2),
                              ),
                              curve: Curves.fastLinearToSlowEaseIn,
                              height: _currentIndex == ScheduleTabBar.Canceled
                                  ? dimensWidth() * 6
                                  : 0,
                              width: _currentIndex == ScheduleTabBar.Canceled
                                  ? dimensWidth() * 15
                                  : 0,
                            ),
                          ),
                          SizedBox(
                            height: dimensHeight() * 6,
                            width: double.maxFinite,
                            child: InkWell(
                              splashColor: transparent,
                              highlightColor: transparent,
                              enableFeedback: false,
                              onTap: () {
                                setState(() {
                                  _currentIndex = ScheduleTabBar.Canceled;
                                });
                              },
                              child: Center(
                                child: Text(
                                  translate(context, 'canceled'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                          color: _currentIndex ==
                                                  ScheduleTabBar.Canceled
                                              ? white
                                              : black26),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // const TabBarView(
        //   children: [
        //     UpcomingFrame(),
        //     CompletedFrame(),
        //     CanceledFrame(),
        //   ],
        // ),
        // ),
      ),
    );
  }
}
