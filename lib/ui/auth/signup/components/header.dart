import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class HeaderSignUp extends StatelessWidget {
  const HeaderSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context).translate("title_signup"),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: secondary,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: dimensHeight() * 3,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context).translate('content_signup'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colorA8B1CE.withOpacity(.5),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
