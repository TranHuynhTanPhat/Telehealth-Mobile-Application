import 'package:flutter/material.dart';
import 'package:healthline/utils/translate.dart';

class VaccinationScreen extends StatelessWidget {
  const VaccinationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(translate(context, 'vaccination_record'))),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: const [
          
        ],
      ),
    );
  }
}
