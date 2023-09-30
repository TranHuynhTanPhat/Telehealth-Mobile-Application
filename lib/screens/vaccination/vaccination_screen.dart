import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/cubits/cubit_vaccination/vaccination_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class VaccinationScreen extends StatefulWidget {
  const VaccinationScreen({super.key});

  @override
  State<VaccinationScreen> createState() => _VaccinationScreenState();
}

class _VaccinationScreenState extends State<VaccinationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VaccinationCubit(),
      child: Builder(builder: (context) {
        context.read<VaccinationCubit>().fetchData();
        return Scaffold(
          appBar: AppBar(
            elevation: 10,
            title: Text(
              translate(context, 'vaccination'),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: dimensHeight() * 10),
            child: BlocBuilder<VaccinationCubit, VaccinationState>(
              builder: (context, state) {
                if (state is VaccinationError) {
                  return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: dimensHeight() * 3),
                      child: Text(
                        "Can't load data",
                        style: Theme.of(context).textTheme.titleLarge,
                      ));
                } else if (state is VaccinationLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.diseaseAdult.isNotEmpty &&
                    state.diseaseChild.isNotEmpty) {
                  return ExpansionPanelList.radio(
                    elevation: 0,
                    animationDuration: const Duration(milliseconds: 200),
                    children: [
                      ExpansionPanelRadio(
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                translate(context, 'over_fine_ages'),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            );
                          },
                          body: ExpansionPanelList.radio(
                            animationDuration:
                                const Duration(milliseconds: 200),
                            children: [
                              ...state.diseaseAdult.map(
                                (e) => ExpansionPanelRadio(
                                  value: e,
                                  headerBuilder: ((context, isExpanded) =>
                                      ListTile(
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${translate(context, 'notice')}: ${translate(context, item.notice.toString())}",
                                              ),
                                              Text(
                                                  "${translate(context, 'doses')}: ${item.dose.toString()}"),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: dimensHeight()),
                                                child: Text(
                                                  '${translate(context, 'schedule')}:',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
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
                          headerBuilder:
                              (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                translate(context, 'under_fine_ages'),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            );
                          },
                          body: ExpansionPanelList.radio(
                            animationDuration:
                                const Duration(milliseconds: 200),
                            children: [
                              ...state.diseaseChild.map(
                                (e) => ExpansionPanelRadio(
                                  value: e,
                                  headerBuilder: ((context, isExpanded) =>
                                      ListTile(
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${translate(context, 'notice')}: ${translate(context, item.notice.toString())}",
                                              ),
                                              Text(
                                                  "${translate(context, 'doses')}: ${item.dose.toString()}"),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: dimensHeight()),
                                                child: Text(
                                                  '${translate(context, 'schedule')}:',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge,
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
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
