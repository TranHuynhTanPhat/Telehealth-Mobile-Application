import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthline/data/api/models/responses/doctor_dasboard_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_doctor/overview/components/export.dart';
import 'package:healthline/utils/translate.dart';

class Overview extends StatelessWidget {
  const Overview({super.key, this.dashboard});
  final DoctorDasboardResponse? dashboard;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (dashboard != null) ...[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
            child: Text(
              translate(context, 'overview'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: dimensHeight() * 2,
            ),
            child: CarouselSlider(
              items: [
                RevenueCard(money: dashboard!.money!),
                AppointmentCard(countConsul: dashboard!.countConsul!),
                ReportCard(badFeedback: dashboard!.badFeedback!),
              ],
              options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.2,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  reverse: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale),
            ),
          ),
        ],
      ],
    );
  }
}
