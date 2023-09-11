import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/cubits/cubit_signup/sign_up_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/widgets/google_button_widget.dart';

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
          child: const GoogleButtonWidget()
        ),
        const Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " ${AppLocalizations.of(context).translate("already_have_an_account")} ",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.all(0),
                ),
              ),
              onPressed: () => context.read<SignUpCubit>().navigateToLogIn(),
              child: Text(
                AppLocalizations.of(context).translate("log_in"),
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
