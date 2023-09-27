import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/main/schedule/canceled_frame.dart';
import 'package:healthline/screens/main/schedule/completed_frame.dart';
import 'package:healthline/screens/main/schedule/upcoming_frame.dart';
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
                title: Padding(
                  padding: EdgeInsets.only(left: dimensWidth()),
                  child: Text(
                    translate(context, 'my_appointments'),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: color1F1F1F, fontWeight: FontWeight.w900),
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
                actions: [
                  Container(
                    padding: EdgeInsets.only(right: dimensWidth() * 3),
                    alignment: Alignment.center,
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      size: dimensIcon(),
                      color: color1F1F1F,
                    ),
                  )
                ],
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
