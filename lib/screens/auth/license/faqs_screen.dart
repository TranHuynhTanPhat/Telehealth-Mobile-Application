import 'package:flutter/material.dart';
import 'package:healthline/utils/translate.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translate(context, 'FAQs'),
        ),
      ),
    );
  }
}
