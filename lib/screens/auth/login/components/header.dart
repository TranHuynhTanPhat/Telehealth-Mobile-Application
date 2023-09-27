import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

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
               translate(context, 'greeting'),
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: secondary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                translate(context, 'content_login'),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: colorA8B1CE.withOpacity(.5),
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
