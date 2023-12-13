import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

import 'package:healthline/utils/translate.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});
  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 5),
              child: Center(
                child: Text(
                  translate(context, 'error'),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
