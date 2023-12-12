import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/jitsi_service.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_patient/main/home/components/export.dart';

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
                // EasyLoading.showToast(translate(context, 'coming_soon'));
                JitsiService.instance.join(
                  token:
                      "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InZwYWFzLW1hZ2ljLWNvb2tpZS1mZDA3NDQ4OTRmMTk0ZjNlYTc0ODg4NGY4M2NlYzE5NS85NmUwNTkifQ.eyJhdWQiOiJqaXRzaSIsImlzcyI6ImNoYXQiLCJpYXQiOjE3MDIzNzQyMzgsImV4cCI6MTcwMjM3NzgzOCwibmJmIjoxNzAyMzc0MjMzLCJzdWIiOiJ2cGFhcy1tYWdpYy1jb29raWUtZmQwNzQ0ODk0ZjE5NGYzZWE3NDg4ODRmODNjZWMxOTUiLCJjb250ZXh0Ijp7ImZlYXR1cmVzIjp7ImxpdmVzdHJlYW1pbmciOnRydWUsIm91dGJvdW5kLWNhbGwiOnRydWUsInNpcC1vdXRib3VuZC1jYWxsIjp0cnVlLCJ0cmFuc2NyaXB0aW9uIjp0cnVlLCJyZWNvcmRpbmciOnRydWV9LCJ1c2VyIjp7ImlkIjoiZGM1MTZiOTgtYjBkYi00OTViLTljZmItMGQzNzdhNTM0NmQxIiwibmFtZSI6ImhlYWx0aGxpbmVtYW5hZ2VyMjAyMyIsImF2YXRhciI6IiIsImVtYWlsIjoiaGVhbHRobGluZW1hbmFnZXIyMDIzQGdtYWlsLmNvbSIsIm1vZGVyYXRvciI6ZmFsc2UsImhpZGRlbi1mcm9tLXJlY29yZGVyIjpmYWxzZX19LCJyb29tIjoiKiJ9.SeTy8xwWAtXAc6SB4_9kCMtLW5q4KivnbiMjU5loKI5Gs6ERv7Cvan1L96pKJB17Q9nz1Pcd1Q9ZPEFw-OwQt8IxjXoUisD7NOYMolL8QW1H9R4gmkUrW5gOki2gQamacZEOgqpWe1L8GoC4X4uUohzZx1t6oinJTw3nmMpPcwpZK2Sc4jOY7c30zNolE5gjY667X3E1FLO-9T3307CdOLIl0Ro-ylOy4tX4XYpfnLXYspW1-C-wlOgKIKLi33VMvU5zsW9YqLYong47iaIIIxnvOGkeKzIxyLBCyb23rBR5NBuONUCC9o2vCZLqnYJKQyxMIRy5vmITvj0jv-0bFQ",
                  roomName:
                      "vpaas-magic-cookie-fd0744894f194f3ea748884f83cec195/96e059",
                  displayName: 'Tran Huynh Tan phat',
                  urlAvatar: null,
                  email: null,
                );
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
