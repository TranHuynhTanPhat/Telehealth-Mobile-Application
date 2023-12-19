import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class GoogleButtonWidget extends StatelessWidget {
  const GoogleButtonWidget({
    super.key, required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(colorF8F9FD),
            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                vertical: dimensHeight(), horizontal: dimensWidth()))),
        onPressed: onPressed,
        icon: Image.asset(
          DImages.logoGoogle,
          height: dimensImage() * 3,
        ),
        label: Text(
          translate(context, 'sign_in_with_google'),
          style: Theme.of(context).textTheme.labelLarge,
        ));
  }
}
