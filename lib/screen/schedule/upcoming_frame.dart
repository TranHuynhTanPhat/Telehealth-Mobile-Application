// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/bases/base_listview_horizontal.dart';
import 'package:healthline/screen/widgets/date_slide.dart';
import 'package:intl/intl.dart';

import 'components/upcoming_card.dart';

class UpcomingFrame extends StatefulWidget {
  const UpcomingFrame({super.key});

  @override
  State<UpcomingFrame> createState() => _UpcomingFrameState();
}

class _UpcomingFrameState extends State<UpcomingFrame> {
  final DateTime now = DateTime.now();
  late int _index;
  @override
  void initState() {
    _index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationCubit, ConsultationState>(
      builder: (context, state) {
        if (state.consultations != null &&
            state.consultations!.coming.isNotEmpty) {
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              DateSlide(
                  daysLeft: 7,
                  dayPressed: (index, datetime) {
                    setState(() {
                      _index = index;
                    });
                  },
                  daySelected: _index,
                  dateStart: now),
              SizedBox(
                height: dimensHeight(),
              ),
              ...List.generate(24, (index) {
                if (state.consultations!.coming.any(
                  (element) {
                    List<int> times = element.expectedTime
                            ?.split('-')
                            .map((e) => int.tryParse(e) ?? -1)
                            .toList() ??
                        [-1];

                    DateTime date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                        .parse(element.date!);

                    if ((times.first-1) ~/ 2 == index &&
                        DateTime(date.year, date.month, date.day) ==
                            DateTime(now.year, now.month, now.day + _index)) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                )) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: dimensWidth() * 3,
                        right: dimensWidth() * 3,
                        bottom: dimensHeight() * 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              TimeOfDay(hour: index, minute: 0)
                                  .format(context)
                                  .toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: black26),
                            ),
                            Expanded(
                              child: Text(
                                ' ---------------------------------------------------',
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: black26),
                              ),
                            )
                          ],
                        ),
                        BaseListviewHorizontal(
                          children: state.consultations!.coming.map((e) {
                            List<int> times = e.expectedTime
                                    ?.split('-')
                                    .map((e) => int.tryParse(e) ?? -1)
                                    .toList() ??
                                [-1];
                            DateTime date =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .parse(e.date!);

                            if ((times.first-1) ~/ 2 == index &&
                                DateTime(date.year, date.month, date.day) ==
                                    DateTime(now.year, now.month,
                                        now.day + _index)) {
                              return InkWell(
                                splashColor: transparent,
                                highlightColor: transparent,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  detailConsultationName,
                                  arguments: e.toJson(),
                                ),
                                child: UpcomingCard(coming: e),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }).toList(),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              }),
              SizedBox(
                height: dimensHeight() * 10,
              )
            ],
          );
        }
        return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: dimensHeight() * 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.boxOpen,
                color: color1F1F1F.withOpacity(.05),
                size: dimensWidth() * 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
