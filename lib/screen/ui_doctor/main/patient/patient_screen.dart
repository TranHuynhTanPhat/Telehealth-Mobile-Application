import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: white,
      body: Text("Patient screen"),
    );
  }
}
