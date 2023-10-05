import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: white,
      body: Text('Schedule screen'),
    );
  }
}
