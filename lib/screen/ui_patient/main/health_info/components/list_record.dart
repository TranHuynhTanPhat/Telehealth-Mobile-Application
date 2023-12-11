import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/main/health_info/components/export.dart';

class ListRecord extends StatelessWidget {
  const ListRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        RecordCard(
          name: 'vaccination',
          color: color9D4B6C,
          iconData: FontAwesomeIcons.syringe,
          press: () {
            Navigator.pushNamed(context, vaccinationName);
          },
        ),
        const Divider(),
        RecordCard(
          name: 'medical_record',
          color: color009DC7,
          iconData: FontAwesomeIcons.solidFolder,
          press: () {
            Navigator.pushNamed(context, patientRecordName);
          },
        ),
        // const Divider(),
        // RecordCard(
        //   name: 'prescription',
        //   color: color1C6AA3,
        //   iconData: FontAwesomeIcons.prescription,
        //   press: () {},
        // ),
      ],
    );
  }
}
