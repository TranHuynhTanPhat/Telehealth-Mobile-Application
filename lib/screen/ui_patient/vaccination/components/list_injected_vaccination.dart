import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_pages.dart';

class ListInjectedVaccination extends StatelessWidget {
  const ListInjectedVaccination({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vaccineRecordCubit = context.read<VaccineRecordCubit>();
    return BlocListener<VaccineRecordCubit, VaccineRecordState>(
        listener: (context, state) {
      if (state is DeleteInjectedVaccinationLoading) {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
      } else if (state is DeleteInjectedVaccinationLoaded) {
        EasyLoading.showToast(translate(context, 'delete_successfully'));
      } else if (state is DeleteInjectedVaccinationError) {
        EasyLoading.showToast(translate(context, state.message.toLowerCase()));
      }
    }, child: BlocBuilder<VaccineRecordCubit, VaccineRecordState>(
      builder: (context, state) {
        if (state is! FetchInjectedVaccinationLoading &&
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
                SizedBox(
                  width: dimensWidth() * 25,
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
                    onPressed: () async {
                      await Navigator.pushNamed(context, addVaccinationName);
                      // if (result == true) {
                      //   setState(() {});
                      // }
                    },
                  ),
                )
              ],
            ),
          );
        } else {
          return AbsorbPointer(
            absorbing: state is DeleteInjectedVaccinationLoading,
            child: ListView(
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3,
                vertical: dimensHeight(),
              ),
              children: [
                if (state is FetchInjectedVaccinationLoading ||
                    state is FetchVaccination)
                  const BuildShimmer()
                else
                  Column(
                      children: state.injectedVaccinations
                          .map(
                            (e) => Container(
                              margin:
                                  EdgeInsets.only(bottom: dimensWidth() * 2),
                              child: Slidable(
                                startActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        vaccineRecordCubit
                                            .deleteInjectedVaccination(e.id!);
                                      },
                                      backgroundColor: transparent,
                                      foregroundColor: color9D4B6C,
                                      icon: FontAwesomeIcons.trash,
                                      label: translate(context, 'delete'),
                                      borderRadius: BorderRadius.circular(
                                          dimensWidth() * 1.8),
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        // Navigator.pushNamed(
                                        //     context, updateVaccinationName);
                                      },
                                      backgroundColor: transparent,
                                      foregroundColor: primary,
                                      icon: FontAwesomeIcons.solidPenToSquare,
                                      label: translate(context, 'update'),
                                      borderRadius: BorderRadius.circular(
                                          dimensWidth() * 1.8),
                                    )
                                  ],
                                ),
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
                                  child: InkWell(
                                    splashColor: transparent,
                                    highlightColor: transparent,
                                    onTap: null,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: dimensWidth()),
                                          child: Row(
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
                                          height: dimensHeight() * 13,
                                          child: Stepper(
                                            key: ValueKey(e),
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
                                                    state: StepState.complete),
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
                                                    "${translate(context, 'day_of_last_dose')}: ${formatDayMonthYear(context, DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(e.updatedAt!))}"),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList())
              ],
            ),
          );
        }
      },
    ));
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
              child: ShimmerWidget.retangular(
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
            child: ShimmerWidget.retangular(
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
              child: ShimmerWidget.retangular(
                height: dimensWidth() * 2,
                width: dimensWidth() * 30,
              ))
        ],
      ),
    );
  }
}
