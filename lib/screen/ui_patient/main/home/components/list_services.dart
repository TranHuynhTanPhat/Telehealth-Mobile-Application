import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/jitsi_service.dart';
import 'package:healthline/app/push_notification_manager.dart';

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
              press: () {
                // EasyLoading.showToast(translate(context, 'coming_soon'));
                JitsiService.instance.join(
                  token:
                      "eyJraWQiOiJ2cGFhcy1tYWdpYy1jb29raWUtMGZmNmEwMzgyMzNhNGNiN2I4ODQxNTgzNDVjMjZkMzIvNTM2OGM0LVNBTVBMRV9BUFAiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJqaXRzaSIsImlzcyI6ImNoYXQiLCJpYXQiOjE2OTk4MTMzMTYsImV4cCI6MTY5OTgyMDUxNiwibmJmIjoxNjk5ODEzMzExLCJzdWIiOiJ2cGFhcy1tYWdpYy1jb29raWUtMGZmNmEwMzgyMzNhNGNiN2I4ODQxNTgzNDVjMjZkMzIiLCJjb250ZXh0Ijp7ImZlYXR1cmVzIjp7ImxpdmVzdHJlYW1pbmciOmZhbHNlLCJvdXRib3VuZC1jYWxsIjpmYWxzZSwic2lwLW91dGJvdW5kLWNhbGwiOmZhbHNlLCJ0cmFuc2NyaXB0aW9uIjpmYWxzZSwicmVjb3JkaW5nIjpmYWxzZX0sInVzZXIiOnsiaGlkZGVuLWZyb20tcmVjb3JkZXIiOmZhbHNlLCJtb2RlcmF0b3IiOmZhbHNlLCJuYW1lIjoiIiwiaWQiOiJhdXRoMHw2NTUwYjFiMGQ3ZjA2NTFhYzg2MTA2Y2YiLCJhdmF0YXIiOiIiLCJlbWFpbCI6ImhlYWx0aGxpbmVtYW5hZ2VyMjAyM0BnbWFpbC5jb20ifX0sInJvb20iOiIqIn0.czoB0nMarjqavCG-gv4X5FTKcAdDo6-1GqGFN52LndgJQVGk9DDaA27GfwBd4GaSmBUH_xJH4d0V9W73XxYvThJ1Acx0HWgW8bdY1-aoOZu-T4ruGom4uDloSg090cZPLwDph2aqXeWamGmmXUNwAE_0XoXkQRUpF4AmbtVuOS2dIKHL57KXxsWWrXN3nCyee6DcBQm0ADlPpYEti9vHFz-LyREw-zd7jPAUi9NjbS4ARd-p4ugdpLkkCkdMSBiPtyJQHHGM0GCAHtMesBzGXIL5AbBUnwTNsVtTEll1zMLvw1DBaqDvCBejxHxEcxre56edsH3qIt8tQta9P36aqw",
                  roomName:
                      "vpaas-magic-cookie-0ff6a038233a4cb7b884158345c26d32/test",
                  displayName: 'Tran Huynh Tan phat',
                  urlAvatar: null,
                );
                PushNotificationManager().display(
                  context,
                  RemoteMessage(
                    channelId: 'channelId',
                    channelName: 'channelName',
                    channelDescription: 'channelDescription',
                    notification: ReceivedNotification(
                        title: 'title', body: 'body', payload: updateName),
                  ),
                );
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
