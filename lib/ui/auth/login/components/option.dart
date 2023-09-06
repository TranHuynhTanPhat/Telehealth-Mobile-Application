import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/blocs/blocs_export.dart';
import 'package:healthline/res/style.dart';

class OptionLogIn extends StatelessWidget {
  const OptionLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: dimensHeight() * 10,
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
                      vertical: dimensHeight(), horizontal: dimensWidth()))),
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " ${AppLocalizations.of(context).translate("don't_have_an_account_yet")} ",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.all(0),
                ),
              ),
              onPressed: ()=>context.read<LogInBloc>().add(NavigateToSignUp()),
              child: Text(
                AppLocalizations.of(context).translate("sign_up"),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: secondary, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
