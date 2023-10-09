import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/main/health_info/components/export.dart';

class ListRecord extends StatelessWidget {
  const ListRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RecordCard(
          name: 'head_circumference',

          color: colorDF9F1E,
          iconData: FontAwesomeIcons.ruler,
          press: () {},
        ),
        RecordCard(
          name: 'vaccination',

          color: color9D4B6C,
          iconData: FontAwesomeIcons.syringe,
          press: () {
            Navigator.pushNamed(context, vaccinationName);
          },
        ),
        RecordCard(
          name: 'medical_record',

          color: color009DC7,
          iconData: FontAwesomeIcons.solidFolder,
          press: () {},
        ),
        RecordCard(
          name: 'prescription',

          color: color1C6AA3,
          iconData: FontAwesomeIcons.prescription,
          press: () {},
        ),
      ],
    );
  }
}
