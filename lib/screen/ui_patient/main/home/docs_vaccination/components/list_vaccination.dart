import 'package:flutter/material.dart';
import 'package:healthline/data/storage/models/vaccination_model.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class ListVaccination extends StatelessWidget {
  const ListVaccination(
      {super.key, required this.diseaseAdult, required this.diseaseChild});
  final List<Disease> diseaseAdult;
  final List<Disease> diseaseChild;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList.radio(
      elevation: 0,
      animationDuration: const Duration(milliseconds: 200),
      children: [
        ExpansionPanelRadio(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  translate(context, 'over_fine_ages'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
            body: ExpansionPanelList.radio(
              animationDuration: const Duration(milliseconds: 200),
              children: [
                ...diseaseAdult.map(
                      (e) => ExpansionPanelRadio(
                    value: e,
                    canTapOnHeader: true,
                    headerBuilder: ((context, isExpanded) => ListTile(
                          title: Text(
                            translate(
                              context,
                              e.disease.toString(),
                            ),
                          ),
                        )),
                    body: Column(
                      children: [
                        ...e.vaccinations.map(
                          (item) => ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${translate(context, 'notice')}: ${translate(context, item.notice.toString())}",
                                ),
                                Text(
                                    "${translate(context, 'doses')}: ${item.dose.toString()}"),
                                Padding(
                                  padding: EdgeInsets.only(top: dimensHeight()),
                                  child: Text(
                                            '${translate(context, 'schedule')}:',
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                        ),
                                        ...item.schedule.map(
                                              (schedule) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${translate(context, 'dose')}: ${schedule.dose.toString()}'),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: dimensWidth()),
                                        child: Text(
                                            '${translate(context, 'time_dose')}: ${translate(context, schedule.timeDose.toString())}'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                                        left: dimensWidth()),
                                                    child: Text(
                                                        '${translate(context, 'days_from_last_dose')}: ${translate(context, schedule.daysFromLastDose.toString())}'),
                                                  ),
                                                ],
                                              ),
                                        ),
                                        const Divider(
                                          color: black26,
                                        )
                                      ],
                                    ),
                                  ),
                            ),
                          ],
                        ),
                      ),
                ),
              ],
            ),
            value: 1),
        ExpansionPanelRadio(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  translate(context, 'under_fine_ages'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
            body: ExpansionPanelList.radio(
              animationDuration: const Duration(milliseconds: 200),
              children: [
                ...diseaseChild.map(
                      (e) => ExpansionPanelRadio(
                    canTapOnHeader: true,
                    value: e,
                    headerBuilder: ((context, isExpanded) => ListTile(
                          title: Text(
                            translate(
                              context,
                              e.disease.toString(),
                            ),
                          ),
                        )),
                    body: Column(
                      children: [
                        ...e.vaccinations.map(
                              (item) => ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${translate(context, 'notice')}: ${translate(context, item.notice.toString())}",
                                ),
                                Text(
                                    "${translate(context, 'doses')}: ${item.dose.toString()}"),
                                Padding(
                                  padding: EdgeInsets.only(top: dimensHeight()),
                                  child: Text(
                                    '${translate(context, 'schedule')}:',
                                    style:
                                    Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                                ...item.schedule.map(
                                      (schedule) => Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${translate(context, 'dose')}: ${schedule.dose.toString()}'),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: dimensWidth()),
                                        child: Text(
                                            '${translate(context, 'time_dose')}: ${translate(context, schedule.timeDose.toString())}'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: dimensWidth()),
                                        child: Text(
                                            '${translate(context, 'days_from_last_dose')}: ${translate(context, schedule.daysFromLastDose.toString())}'),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: black26,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            value: 2),
      ],
    );
  }
}
