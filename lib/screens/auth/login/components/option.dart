import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/cubits/cubit_login/log_in_cubit.dart';
import 'package:healthline/res/style.dart';

class OptionLogIn extends StatelessWidget {
  const OptionLogIn({super.key});

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
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 9),
        //   child: const GoogleButtonWidget(),
        // ),
        // const Divider(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " ${AppLocalizations.of(context).translate("don't_have_an_account_yet")} ",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.all(0),
                ),
              ),
              onPressed: () => context.read<LogInCubit>().navigateToSignIn(),
              child: Text(
                AppLocalizations.of(context).translate("sign_up"),
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


