import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';
import 'package:lottie/lottie.dart';

class HeartRateCard extends StatelessWidget {
  const HeartRateCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: dimensWidth() * 2.5),
      padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
      decoration: BoxDecoration(
          color: color1C6AA3.withOpacity(.2),
          borderRadius: BorderRadius.circular(dimensWidth() * 3)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translate(context, 'heart_rate'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: dimensHeight() * 3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    translate(context, '96'),
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    translate(context, 'bpm'),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
          LottieBuilder.asset(
            'assets/lotties/heart_rate.json',
            width: dimensWidth() * 25,
          )
        ],
      ),
    );
  }
}
