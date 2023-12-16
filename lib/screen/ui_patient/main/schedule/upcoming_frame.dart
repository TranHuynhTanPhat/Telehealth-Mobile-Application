// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/bases/base_listview_horizontal.dart';

import 'components/upcoming_card.dart';


class UpcomingFrame extends StatefulWidget {
  const UpcomingFrame({super.key});

  @override
  State<UpcomingFrame> createState() => _UpcomingFrameState();
}

class _UpcomingFrameState extends State<UpcomingFrame> {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationCubit, ConsultationState>(
      builder: (context, state) {
        if (state is FetchConsultationState &&
            state.consultations.coming.isNotEmpty) {
          return ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // const SlideDaysInMonth(),
              SizedBox(
                height: dimensHeight(),
              ),
              ...List.generate(24, (index) {
                if (state.consultations.coming.any((element) {
                  List<int> times = element.expectedTime
                          ?.split('-')
                          .map((e) => int.tryParse(e) ?? -1)
                          .toList() ??
                      [-1];
                  if (times.first ~/ 2 == index) {
                    return true;
                  } else {
                    return false;
                  }
                })) {
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
                          children: state.consultations.coming.map((e) {
                            List<int> times = e.expectedTime
                                    ?.split('-')
                                    .map((e) => int.tryParse(e) ?? -1)
                                    .toList() ??
                                [-1];
                            if (times.first ~/ 2 == index) {
                              return UpcomingCard(coming: e);
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
              // Padding(
              //   padding: EdgeInsets.only(
              //       top: 0,
              //       right: dimensWidth() * 3,
              //       left: dimensWidth() * 3,
              //       bottom: dimensHeight() * 10),
              //   child: BaseListviewHorizontal(
              //     children: appointments
              //         .map(
              //           (e) => UpcomingCard(coming: e),
              //         )
              //         .toList(),
              //   ),
              // ),
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
