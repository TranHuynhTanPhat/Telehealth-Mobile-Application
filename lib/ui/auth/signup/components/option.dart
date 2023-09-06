import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class OptionSignUp extends StatelessWidget {
  const OptionSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: dimensHeight() * 4,
              right: dimensWidth() * 3,
              left: dimensWidth() * 3),
          child: const Divider(),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 9),
          child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(colorF8F9FD),
                  padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                      vertical: dimensHeight(), horizontal: 0))),
              onPressed: null,
              icon: Image.asset(
                DImages.logoGoogle,
                height: dimensImage() * 5,
              ),
              label: Text(
                'Google',
                style: Theme.of(context).textTheme.labelLarge,
              )),
        ),
        const Divider(),
      ],
    );
  }
}
