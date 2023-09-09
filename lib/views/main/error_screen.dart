import 'package:flutter/material.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/res/language/app_localizations.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});
  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.network(
              "https://lottie.host/6b7b2bed-e528-4ab8-ace6-4b2a1403e54a/U4blv0758V.json",
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 5),
              child: Text(
                AppLocalizations.of(context).translate(""),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.red),
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Color(0xffff9494))),
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
