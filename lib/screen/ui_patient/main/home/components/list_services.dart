import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_patient/main/home/components/export.dart';
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
              press: () async {
                EasyLoading.showToast(translate(context, 'coming_soon'));
                // JitsiService.instance.join(
                //   token:
                //       "eyJraWQiOiJ2cGFhcy1tYWdpYy1jb29raWUtMGZmNmEwMzgyMzNhNGNiN2I4ODQxNTgzNDVjMjZkMzIvNTM2OGM0LVNBTVBMRV9BUFAiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJqaXRzaSIsImlzcyI6ImNoYXQiLCJpYXQiOjE2OTk4ODkzNjEsImV4cCI6MTY5OTg5NjU2MSwibmJmIjoxNjk5ODg5MzU2LCJzdWIiOiJ2cGFhcy1tYWdpYy1jb29raWUtMGZmNmEwMzgyMzNhNGNiN2I4ODQxNTgzNDVjMjZkMzIiLCJjb250ZXh0Ijp7ImZlYXR1cmVzIjp7ImxpdmVzdHJlYW1pbmciOmZhbHNlLCJvdXRib3VuZC1jYWxsIjpmYWxzZSwic2lwLW91dGJvdW5kLWNhbGwiOmZhbHNlLCJ0cmFuc2NyaXB0aW9uIjpmYWxzZSwicmVjb3JkaW5nIjpmYWxzZX0sInVzZXIiOnsiaGlkZGVuLWZyb20tcmVjb3JkZXIiOmZhbHNlLCJtb2RlcmF0b3IiOnRydWUsIm5hbWUiOiIiLCJpZCI6ImF1dGgwfDY1NTBiMWIwZDdmMDY1MWFjODYxMDZjZiIsImF2YXRhciI6IiIsImVtYWlsIjoiaGVhbHRobGluZW1hbmFnZXIyMDIzQGdtYWlsLmNvbSJ9fSwicm9vbSI6IioifQ.fj3wLkMmzUL_LdXdSAldus36lJpBCfBvbYWRd5uw8DF2EIa_KtojWmnAzMbv-4r7kBGny54zER17nZGrpwNjSuuPrpaw1CEDNmm3wJe_rzwsCk3ZOkz3MMIOTeustow5aS_wYHSrjjxC3v12Ti7A4mUp9iXiimJJhC5Kr2hRECEhGGGf9w5hL7-MAzp_6LORo-DIbWThDVgnNpAI4W477e8YprnrZv3uXII2A-rcAXvWlnui8bfaCCk5xaBVFFrrfj8AWJKxmIINkH5tlB--2lphKRYGwXlWEca6rT9kFMfH-tt0p8v18hOOi9vEbi3wTZ8Leh4toEUIeDQDXS1Svw",
                //   roomName:
                //       "vpaas-magic-cookie-0ff6a038233a4cb7b884158345c26d32/test",
                //   displayName: 'Tran Huynh Tan phat',
                //   urlAvatar: null,
                //   email: null,
                // );
                // PushNotificationManager().display(
                //   context,
                //   RemoteMessage(
                //     channelId: 'channelId',
                //     channelName: 'channelName',
                //     channelDescription: 'channelDescription',
                //     notification: ReceivedNotification(
                //         title: 'title', body: 'body', payload: updateName),
                //   ),
                // );
                
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
                Navigator.pushNamed(context, newsName);
              },
            ),
          ]),
    );
  }
}
