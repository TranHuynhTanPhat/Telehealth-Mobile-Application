import 'package:flutter/material.dart';
import 'package:healthline/utils/translate.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(translate(context, 'privacy_policy')),
      ),
    );
  }
}
