import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:lottie/lottie.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: dimensWidth() * 20,
          width: dimensWidth() * 50,
          padding: EdgeInsets.only(
              top: dimensWidth() * 4,
              left: dimensWidth() * 2,
              right: dimensWidth() * 20),
          decoration: BoxDecoration(
              color: colorCDDEFF,
              borderRadius: BorderRadius.circular(dimensWidth() * 3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).translate('consult_doctors'),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: secondary, fontWeight: FontWeight.bold),
              ),
              Text(
                AppLocalizations.of(context).translate('get_expert_advice_form_specialist_doctors'),

                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: color6A6E83),
              )
            ],
          ),
        ),
        Positioned(
          right: -dimensWidth() * 10,
          top: -dimensWidth(),
          child: LottieBuilder.asset(
            'assets/lotties/doctor.json',
            width: dimensWidth() * 40,
          ),
        ),
      ],
    );
  }
}
