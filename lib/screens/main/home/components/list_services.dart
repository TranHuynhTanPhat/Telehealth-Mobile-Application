import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/main/home/components/export.dart';
import 'package:healthline/utils/translate.dart';

class ListServices extends StatefulWidget {
  const ListServices({
    super.key,
  });

  @override
  State<ListServices> createState() => _ListServicesState();
}

class _ListServicesState extends State<ListServices> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        'name': 'general_medical',
        'color': color009DC7,
        'icon': FontAwesomeIcons.briefcaseMedical,
      },
      {
        'name': 'doctor',
        'color': color1C6AA3,
        'icon': FontAwesomeIcons.userDoctor,
      },
      {
        'name': 'vaccination',
        'color': colorDF9F1E,
        'icon': FontAwesomeIcons.syringe,
      },
      {
        'name': 'news',
        'color': color9D4B6C,
        'icon': FontAwesomeIcons.virusCovid,
      },
    ];
    return SizedBox(
      height: dimensWidth() * 12,
      child: ListView(
          padding: EdgeInsets.only(top: dimensHeight()),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            ServiceCard(
              services: services,
              index: 0,
              press: () {
                EasyLoading.showToast(translate(context, 'coming_soon'));
              },
            ),
            ServiceCard(
              services: services,
              index: 1,
              press: () {
                Navigator.pushNamed(context, doctorName);
              },
            ),
            ServiceCard(
              services: services,
              index: 2,
              press: () {
                Navigator.pushNamed(context, refVaccinationName);
              },
            ),
            ServiceCard(
              services: services,
              index: 3,
              press: () {
                EasyLoading.showToast(translate(context, 'coming_soon'));
              },
            ),
          ]),
    );
  }
}
