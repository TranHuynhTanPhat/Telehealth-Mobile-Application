import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';
import 'package:lottie/lottie.dart';

class ForumCard extends StatelessWidget {
  const ForumCard({
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
              right: dimensWidth() * 22),
          decoration: BoxDecoration(
              color: colorCDDEFF,
              borderRadius: BorderRadius.circular(dimensWidth() * 3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate(context, 'forum'),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: secondary, fontWeight: FontWeight.bold),
              ),
              Text(
                translate(context,
                    'share_experiences_and_get_advice_from_healthLines_community'),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: color6A6E83, fontWeight: FontWeight.w600),
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
