import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Padding(
          padding: EdgeInsets.only(left: dimensWidth()),
          child: Text(
            'my_appointment',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            padding: EdgeInsets.only(right: dimensWidth() * 3),
            alignment: Alignment.center,
            child: FaIcon(
              FontAwesomeIcons.calendarPlus,
              size: dimensIcon(),
            ),
          )
        ],
        bottom: TabBar(tabs: [
          Tab(
            icon: Icon(Icons.chat_bubble),
            text: "Chats",
          ),
          Tab(
            icon: Icon(Icons.video_call),
            text: "Calls",
          ),
          Tab(
            icon: Icon(Icons.settings),
            text: "Settings",
          )
        ]),
      ),
      body: TabBarView(children: [],),
    );
  }
}
