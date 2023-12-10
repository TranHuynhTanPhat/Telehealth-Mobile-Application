// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/auth/login/components/exports.dart';
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
    return BlocListener<LogInCubit, LogInState>(
      listener: (context, state) {
        if (state is LogInLoading) {
          EasyLoading.show();
        } else if (state is LogInSuccessed) {
          EasyLoading.dismiss();
          // if (state.errorDoctor != null) {
          //   EasyLoading.showToast(
          //       translate(context, 'login_to_doctor_account_failed'));
          // }
          // if (state.errorPatient != null) {
          //   print(state.errorPatient);
          //   EasyLoading.showToast(
          //       translate(context, 'login_to_patient_account_failed'));
          // }
          if (AppController.instance.authState == AuthState.DoctorAuthorized) {
            Navigator.pushReplacementNamed(context, mainScreenDoctorName);
          } else {
            Navigator.pushReplacementNamed(context, mainScreenPatientName);
          }
        } else if (state is LogInError) {
          EasyLoading.dismiss();
          EasyLoading.showToast(translate(context, state.error));
        }
      },
      child: BlocBuilder<LogInCubit, LogInState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () => KeyboardUtil.hideKeyboard(context),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: AbsorbPointer(
                absorbing: state is LogInLoading,
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      vertical: dimensHeight() * 10,
                      horizontal: dimensWidth() * 3),
                  children: [
                    const HeaderLogIn(),
                    SizedBox(
                      height: dimensHeight() * 3,
                    ),
                    const LogInForm(),
                    const OptionLogIn()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
