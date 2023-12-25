import 'package:flutter/material.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class OptionLogIn extends StatelessWidget {
  const OptionLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Padding(
        //   padding: EdgeInsets.only(
        //       top: dimensHeight() * 4,
        //       right: dimensWidth() * 3,
        //       left: dimensWidth() * 3),
        //   child: const Divider(),
        // ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 9),
        //   child:  GoogleButtonWidget(onPressed: () {  },),
        // ),
        const Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " ${translate(context, "new_to_healthline")} ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.all(0),
                ),
              ),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, signUpName),
              child: Text(
                translate(context, 'sign_up'),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: secondary, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
