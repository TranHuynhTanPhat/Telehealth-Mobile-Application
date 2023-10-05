import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/routes/app_pages.dart';

import 'package:healthline/repository/user_repository.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/auth/signup/components/exports.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(UserRepository()),
      child: Builder(builder: (context) {
        return BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (previous, current) => current is SignUpActionState,
          listener: (context, state) {
            if (state is SignUpLoadingActionState) {
              EasyLoading.show();
            } else if (state is RegisterAccountActionState) {
              EasyLoading.dismiss();
              EasyLoading.showToast(translate(context, 'success_register'));
              Navigator.pushReplacementNamed(context, logInName);
            } else if (state is SignUpErrorActionState) {
              EasyLoading.dismiss();
              EasyLoading.showToast(state.message);
            }
          },
          child: GestureDetector(
            onTap: () => KeyboardUtil.hideKeyboard(context),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // physics: ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: dimensHeight() * 10),
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                    child: const HeaderSignUp(),
                  ),
                  // SizedBox(
                  //   height: dimensHeight() * 3,
                  // ),
                  const SignUpForm(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                    child: const OptionSignUp(),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
