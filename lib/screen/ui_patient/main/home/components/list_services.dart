import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        'name': 'wish_list',
        'color': colorDF9F1E,
        'icon': FontAwesomeIcons.bookmark,
      },
      {
        'name': 'doctor',
        'color': color1C6AA3,
        'icon': FontAwesomeIcons.userDoctor,
      },
      {
        'name': 'vaccination',
        'color': color009DC7,
        'icon': FontAwesomeIcons.syringe,
      },
      {
        'name': 'news',
        'color': color9D4B6C,
        'icon': FontAwesomeIcons.virusCovid,
      },
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ServiceCard(
            services: services,
            index: 0,
            press: () {
              Navigator.pushNamed(context, wishListName);
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
        ],
      ),
    );
  }
}
