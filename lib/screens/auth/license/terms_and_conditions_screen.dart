import 'package:flutter/material.dart';
import 'package:healthline/utils/translate.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translate(context, 'terms_and_conditions'),
        ),
      ),
    );
  }
}
