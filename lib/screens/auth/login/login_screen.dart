// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/app/cubits/cubits_export.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/auth/login/components/exports.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(UserRepository()),
      child: BlocListener<LogInCubit, LogInState>(
        listener: (context, state) {
          if (state is LogInLoadingActionState) {
            EasyLoading.show();
          } else if (state is NavigateToSignUpActionState) {
            EasyLoading.dismiss();
            Navigator.pushReplacementNamed(context, signUpName);
          } else if (state is SignInActionState) {
            EasyLoading.dismiss();
            EasyLoading.showToast(translate(context, 'success_login'));
            Navigator.pushReplacementNamed(context, mainScreenName);
          } else if (state is LogInErrorActionState) {
            EasyLoading.dismiss();
            EasyLoading.showToast(state.message);
          }
        },
        child: BlocBuilder<LogInCubit, LogInState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => KeyboardUtil.hideKeyboard(context),
              child: Scaffold(
                body: ListView(
                  padding: EdgeInsets.symmetric(
                      vertical: dimensHeight() * 10,
                      horizontal: dimensWidth() * 3),
                  children: [
                    const HeaderLogIn(),
                    SizedBox(
                      height: dimensHeight() * 5,
                    ),
                    const LogInForm(),
                    const OptionLogIn()
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


