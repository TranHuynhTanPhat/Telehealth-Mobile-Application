import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/res/colors.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_patient/main/home/components/export.dart';

class UpcomingApointment extends StatelessWidget {
  const UpcomingApointment({super.key, required this.appointments});
  final List<ConsultationResponse> appointments;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: appointments
          .map((e) => InkWell(
                splashColor: transparent,
                highlightColor: transparent,
                onTap: () => Navigator.pushNamed(
                    context, detailConsultationName,
                    arguments: e.toJson()),
                child: ScheduleCard(
                  consultation: e,
                ),
              ))
          .toList(),
      options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 3,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
          reverse: false,
          enlargeStrategy: CenterPageEnlargeStrategy.scale),
    );
  }
}
