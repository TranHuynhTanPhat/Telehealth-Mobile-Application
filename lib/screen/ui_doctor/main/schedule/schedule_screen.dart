import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/translate.dart';

import './canceled_frame.dart';
import './completed_frame.dart';
import './upcoming_frame.dart';

class ScheduleDoctorScreen extends StatefulWidget {
  const ScheduleDoctorScreen({super.key});

  @override
  State<ScheduleDoctorScreen> createState() => _ScheduleDoctorScreenState();
}

class _ScheduleDoctorScreenState extends State<ScheduleDoctorScreen>
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
