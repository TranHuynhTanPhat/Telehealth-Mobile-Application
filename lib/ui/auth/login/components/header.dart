import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class HeaderLogIn extends StatelessWidget {
  const HeaderLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Hello",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: secondary,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: dimensHeight()*3,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "HealthLine is happy to see you again. You can continue where you left off by logging in.",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
