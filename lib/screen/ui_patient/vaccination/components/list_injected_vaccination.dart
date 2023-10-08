import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class ListInjectedVaccination extends StatelessWidget {
  const ListInjectedVaccination({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VaccinationCubit, VaccinationState>(
      builder: (context, state) {
        return ListView(
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(
            horizontal: dimensWidth() * 3,
            vertical: dimensHeight(),
          ),
          children: [
            state is FetchInjectedVaccinationLoading ||
                    state is VaccinationLoading
                ? const BuildShimmer()
                : state.injectedVaccination.isNotEmpty
                    ? Column(
                        children: state.injectedVaccination
                            .map(
                              (e) => Container(
                                margin:
                                    EdgeInsets.only(bottom: dimensWidth() * 2),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                    e.vaccine!.disease
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
                                        height: dimensHeight() * 10,
                                        child: Stepper(
                                          elevation: 0,
                                          margin: const EdgeInsets.all(0),
                                          connectorColor:
                                              const MaterialStatePropertyAll(
                                                  secondary),
                                          steps: [
                                            ...List.generate(e.doseNumber ?? 1,
                                                (i) => i + 1).map(
                                              (e) => const Step(
                                                  title: SizedBox(),
                                                  content: SizedBox(),
                                                  state: StepState.complete),
                                            ),
                                          ],
                                          controlsBuilder: (context, details) =>
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
                            )
                            .toList())
                    : const SizedBox()
          ],
        );
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
            height: dimensHeight() * 10,
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
