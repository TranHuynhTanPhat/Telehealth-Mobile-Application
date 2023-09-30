import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/main/health_info/components/export.dart';

class ListRecord extends StatelessWidget {
  const ListRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RecordCard(
          name: 'head_circumference',
          unit: 'cm',
          color: colorDF9F1E,
          iconData: FontAwesomeIcons.ruler,
          press: () {},
        ),
        RecordCard(
          name: 'vaccination',
          unit: 'types',
          color: color9D4B6C,
          iconData: FontAwesomeIcons.syringe,
          press: () {
            Navigator.pushNamed(context, vaccinationName);
          },
        ),
        RecordCard(
          name: 'medical_record',
          unit: 'records',
          color: color009DC7,
          iconData: FontAwesomeIcons.solidFolder,
          press: () {},
        ),
        RecordCard(
          name: 'prescription',
          unit: 'cm',
          color: color1C6AA3,
          iconData: FontAwesomeIcons.prescription,
          press: () {},
        ),
      ],
    );
  }
}
