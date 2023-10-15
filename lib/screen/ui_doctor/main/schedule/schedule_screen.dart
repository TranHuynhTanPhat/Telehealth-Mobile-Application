import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_doctor_schdule/doctor_schedule_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import './canceled_frame.dart';
import './completed_frame.dart';
import './upcoming_frame.dart';
import 'package:healthline/utils/translate.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if(!mounted)return;
    context.read<DoctorScheduleCubit>().getCron();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: InkWell(
                  splashColor: transparent,
                  highlightColor: transparent,
                  onTap: () {
                    Navigator.pushNamed(context, shiftDoctorName);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: dimensWidth()),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            translate(context, 'your_shift'),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: color1F1F1F),
                          ),
                        ),
                        Container(
                          // padding: EdgeInsets.only(right: dimensWidth() * 3),
                          alignment: Alignment.centerRight,
                          child: FaIcon(
                            FontAwesomeIcons.chevronRight,
                            size: dimensIcon() * .6,
                            color: color1F1F1F,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                centerTitle: false,
                pinned: true,
                floating: true,
                bottom: TabBar(
                  isScrollable: false,
                  splashBorderRadius: BorderRadius.circular(dimensWidth() * 3),
                  splashFactory: InkRipple.splashFactory,
                  indicatorPadding: EdgeInsets.only(bottom: dimensWidth() * .5),
                  indicatorColor: primary,
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  labelColor: primary,
                  unselectedLabelColor: black26,
                  tabs: [
                    Tab(
                      text: '   ${translate(context, 'upcoming')}   ',
                    ),
                    Tab(
                      text: '   ${translate(context, 'completed')}   ',
                    ),
                    Tab(
                      text: '   ${translate(context, 'canceled')}   ',
                    ),
                  ],
                ),
              )
            ];
          },
          body: const TabBarView(
            children: [
              UpcomingFrame(),
              CompletedFrame(),
              CanceledFrame(),
            ],
          ),
        ),
      ),
    );
  }
}
