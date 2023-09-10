import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class GoogleButtonWidget extends StatelessWidget {
  const GoogleButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(colorF8F9FD),
            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                vertical: dimensHeight(), horizontal: dimensWidth()))),
        onPressed: null,
        icon: Image.asset(
          DImages.logoGoogle,
          height: dimensImage() * 3,
        ),
        label: Text(
          AppLocalizations.of(context).translate("sign_in_with_google"),
          style: Theme.of(context).textTheme.labelLarge,
        ));
  }
}
