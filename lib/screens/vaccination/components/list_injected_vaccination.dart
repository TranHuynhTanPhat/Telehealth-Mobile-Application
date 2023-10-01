import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class ListInjectedVaccination extends StatelessWidget {
  const ListInjectedVaccination({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(
        horizontal: dimensWidth() * 3,
        vertical: dimensHeight(),
      ),
      children: [
        Container(
          margin: EdgeInsets.only(bottom: dimensWidth() * 2),
          padding: EdgeInsets.symmetric(
              vertical: dimensHeight(), horizontal: dimensWidth()),
          width: double.maxFinite,
          decoration: BoxDecoration(
            border: Border.all(color: color1F1F1F.withOpacity(.1)),
            borderRadius: BorderRadius.circular(dimensWidth() * 1.8),
          ),
          child: InkWell(
            splashColor: transparent,
            highlightColor: transparent,
            onTap: null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: dimensWidth()),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'name disease',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: dimensWidth(),
                  ),
                  child: Text('${translate(context, 'doses')}: 4'),
                ),
                SizedBox(
                  height: dimensHeight() * 10,
                  child: Stepper(
                    elevation: 0,
                    margin: const EdgeInsets.all(0),
                    connectorColor: const MaterialStatePropertyAll(secondary),
                    currentStep: 3,
                    steps: const [
                      Step(
                          title: SizedBox(),
                          content: SizedBox(),
                          state: StepState.complete),
                      Step(
                          title: SizedBox(),
                          content: SizedBox(),
                          state: StepState.complete),
                      Step(
                          title: SizedBox(),
                          content: SizedBox(),
                          state: StepState.complete),
                      Step(
                          title: SizedBox(),
                          content: SizedBox(),
                          state: StepState.complete),
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                            "${translate(context, 'day_of_last_dose')}: 10/10/2024"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}