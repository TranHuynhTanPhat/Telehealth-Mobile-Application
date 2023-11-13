import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:healthline/screen/ui_patient/main/home/components/export.dart';

class UpcomingApointment extends StatelessWidget {
  const UpcomingApointment({super.key, required this.appointments});
  final List<Map<String, dynamic>> appointments;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: appointments
          .map((e) => ScheduleCard(
                object: e,
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
