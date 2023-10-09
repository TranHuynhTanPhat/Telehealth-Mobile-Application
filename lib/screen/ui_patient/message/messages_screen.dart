import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/message/components/exports.dart';
import 'package:healthline/utils/translate.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final List<Map<String, dynamic>> messages = [
    {
      'dr': 'Dr. Phat',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'time': const TimeOfDay(hour: 10, minute: 0),
      "message":
          "Heloo, dfkajiufhsnvusdhfoijwefaskdjflsahdfojweoinjofadfjsdkfjlsadkjflksjdlfjsdkjflasdqiwmdiiowe",
      'unread': 0
    },
    {
      'dr': 'Dr. Truong',
      'image': DImages.logoGoogle,
      'date': DateTime.now(),
      'time': const TimeOfDay(hour: 11, minute: 0),
      'message': "sdafhjsfjlsdfjalsdfj",
      'unread': 1
    },
    {
      'dr': 'Dr. Chien',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'time': const TimeOfDay(hour: 8, minute: 0),
      'end': const TimeOfDay(hour: 8, minute: 30),
      'message': "sdafhjsfjlsdfjalsdfj",
      'unread': 2
    },
    {
      'dr': 'Dr. Dang',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'time': const TimeOfDay(hour: 8, minute: 30),
      'message': "sdafhjsfjlsdfjalsdfj",
      'unread': 0
    },
    {
      'dr': 'Dr. Chien',
      'image': DImages.placeholder,
      'date': DateTime.now(),
      'time': const TimeOfDay(hour: 14, minute: 0),
      'message': "sdafhjsfjlsdfjalsdfj",
      'unread': 3
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Padding(
                padding: EdgeInsets.only(left: dimensWidth()),
                child: Text(
                  translate(context,'messages'),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: color1F1F1F, fontWeight: FontWeight.w900),
                ),
              ),
              centerTitle: false,
              pinned: true,
              floating: true,
              actions: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                  child: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: dimensIcon(),
                    color: color1F1F1F,
                  ),
                )
              ],
            )
          ];
        },
        body: ListView(
          padding: EdgeInsets.symmetric(
              vertical: dimensHeight() * 2, horizontal: dimensWidth() * 3),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            ...messages.map(
              (mess) => MessageCard(mess: mess),
            ),
          ],
        ),
      ),
    );
  }
}
