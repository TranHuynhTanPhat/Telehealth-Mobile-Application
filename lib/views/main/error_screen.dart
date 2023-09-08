import 'package:flutter/material.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/res/language/app_localizations.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key, required this.message});
  final String message;
  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: dimensHeight() * 2, horizontal: dimensWidth() * 2),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate(widget.message),
                ),
              ),
            ),
            ElevatedButton(
              child: const Text("Login"),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
