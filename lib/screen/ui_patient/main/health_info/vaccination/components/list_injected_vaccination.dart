import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_patient/main/health_info/vaccination/update_vaccination.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/utils/translate.dart';

class ListInjectedVaccination extends StatelessWidget {
  const ListInjectedVaccination({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VaccineRecordCubit, VaccineRecordState>(
      builder: (context, state) {
        if (state is FetchVaccinationRecordState &&
            state.blocState != BlocState.Pending &&
            state.injectedVaccinations.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.boxOpen,
                  color: color1F1F1F.withOpacity(.05),
                  size: dimensWidth() * 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: dimensWidth() * 10),
                  child: TextButton(
                    style: ButtonStyle(
                      iconColor: const MaterialStatePropertyAll(white),
                      iconSize: MaterialStatePropertyAll(dimensIcon() * .5),
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(
                          vertical: dimensHeight() * 2,
                          horizontal: dimensWidth() * 2.5,
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(primary),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(FontAwesomeIcons.plus),
                        SizedBox(
                          width: dimensWidth(),
                        ),
                        Expanded(
                          child: Text(
                            translate(context, 'add_vaccination_record'),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: white),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, addVaccinationName);
                    },
                  ),
                )
              ],
            ),
          );
        } else {
          return AbsorbPointer(
            absorbing: state is FetchVaccinationRecordState &&
                state.blocState == BlocState.Pending,
            child: ListView(
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3,
                vertical: dimensHeight(),
              ),
              children: [
                if (state is FetchVaccinationRecordState && state.blocState==BlocState.Pending)
                  const BuildShimmer()
                else
                  Column(
                    children: state.injectedVaccinations
                        .map(
                          (e) => Slidable(
                            closeOnScroll: true,
                            endActionPane: ActionPane(
                              motion: const BehindMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    context
                                        .read<VaccineRecordCubit>()
                                        .deleteVaccinationRecordState(e.id!);
                                  },
                                  backgroundColor: transparent,
                                  foregroundColor: color9D4B6C,
                                  icon: FontAwesomeIcons.trash,
                                  label: translate(context, 'delete'),
                                ),
                              ],
                            ),
                            child: Container(
                              margin:
                                  EdgeInsets.only(bottom: dimensWidth() * 2),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: dimensHeight(),
                                    horizontal: dimensWidth()),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: color1F1F1F.withOpacity(.1)),
                                  borderRadius: BorderRadius.circular(
                                      dimensWidth() * 1.8),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: dimensWidth(),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    translate(
                                                        context,
                                                        e.vaccine?.disease
                                                            .toString()),
                                                    // maxLines: 1,
                                                    // overflow: TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: dimensWidth(),
                                            ),
                                            child: Text(
                                                '${translate(context, 'doses')}: ${e.vaccine?.maxDose.toString()}'),
                                          ),
                                          SizedBox(
                                            height: dimensHeight() * 11,
                                            child: Stepper(
                                              key: ValueKey(e.toJson() +
                                                  state.toString()),
                                              elevation: 0,
                                              margin: const EdgeInsets.all(0),
                                              currentStep: e.doseNumber! - 1,
                                              connectorColor:
                                                  const MaterialStatePropertyAll(
                                                      secondary),
                                              steps: [
                                                ...List.generate(
                                                    e.vaccine?.maxDose ?? 1,
                                                    (i) => i + 1).map(
                                                  (j) => const Step(
                                                      title: SizedBox(),
                                                      content: SizedBox(),
                                                      state:
                                                          StepState.complete),
                                                ),
                                              ],
                                              stepIconBuilder:
                                                  (index, stepState) {
                                                if (index >= e.doseNumber!) {
                                                  return const SizedBox();
                                                }
                                                return null;
                                              },
                                              controlsBuilder:
                                                  (context, details) =>
                                                      const SizedBox(),
                                              onStepTapped: null,
                                              type: StepperType.horizontal,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: dimensWidth(),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                      "${translate(context, 'day_of_last_dose')}: ${e.date!}"),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: dimensWidth()),
                                      onPressed: () async {
                                        bool? result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => BlocProvider.value(
                                              value: context
                                                  .read<VaccineRecordCubit>(),
                                              child: UpdateVaccinationScreen(
                                                vaccineRecord: e,
                                              ),
                                            ),
                                          ),
                                        ) as bool;
                                        if (result == true) {
                                          // ignore: use_build_context_synchronously
                                          context
                                              .read<VaccineRecordCubit>()
                                              .fetchVaccinationRecord(
                                                  state.medicalRecord);
                                        }
                                      },
                                      icon: FaIcon(
                                        FontAwesomeIcons.solidPenToSquare,
                                        size: dimensIcon() * .6,
                                        color: primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ),
                            ),
                          ),
                        )
                        .toList(),
                  )
              ],
            ),
          );
        }
      },
    );
  }
}

class BuildShimmer extends StatelessWidget {
  const BuildShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: dimensWidth() * 2),
      padding: EdgeInsets.symmetric(
          vertical: dimensHeight(), horizontal: dimensWidth()),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(color: color1F1F1F.withOpacity(.1)),
        borderRadius: BorderRadius.circular(dimensWidth() * 1.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: dimensWidth()),
              child: ShimmerWidget.rectangular(
                height: dimensWidth() * 2.2,
                width: dimensWidth() * 15,
              )),
          SizedBox(
            height: dimensHeight() * .5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dimensWidth(),
            ),
            child: ShimmerWidget.rectangular(
              height: dimensWidth() * 2,
              width: dimensWidth() * 10,
            ),
          ),
          SizedBox(
            height: dimensHeight() * 15,
            child: Stepper(
              elevation: 0,
              margin: const EdgeInsets.all(0),
              connectorColor: MaterialStatePropertyAll(Colors.grey.shade300),
              currentStep: 3,
              stepIconBuilder: (stepIndex, stepState) {
                if (stepState == StepState.disabled) {
                  return const SizedBox();
                }
                return null;
              },
              steps: const [
                Step(
                    title: SizedBox(),
                    content: SizedBox(),
                    state: StepState.disabled),
                Step(
                    title: SizedBox(),
                    content: SizedBox(),
                    state: StepState.disabled),
                Step(
                    title: SizedBox(),
                    content: SizedBox(),
                    state: StepState.disabled),
                Step(
                    title: SizedBox(),
                    content: SizedBox(),
                    state: StepState.disabled)
              ],
              controlsBuilder: (context, details) => const SizedBox(),
              onStepTapped: null,
              type: StepperType.horizontal,
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                horizontal: dimensWidth(),
              ),
              child: ShimmerWidget.rectangular(
                height: dimensWidth() * 2,
                width: dimensWidth() * 30,
              ))
        ],
      ),
    );
  }
}
