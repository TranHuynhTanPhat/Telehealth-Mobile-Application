import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/auth/forget_password/components/export.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key, required this.isDoctor});
  final bool isDoctor;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool inputEmail = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is SendOTPState) {
          if (state.blocState == BlocState.Successed) {
            EasyLoading.dismiss();
            setState(() {
              inputEmail = false;
            });
          } else if (state.blocState == BlocState.Failed) {
            EasyLoading.showToast(translate(context, state.error));
          } else if (state.blocState == BlocState.Pending) {
            EasyLoading.show(maskType: EasyLoadingMaskType.black);
          }
        } else if (state is ResetPasswordState) {
          if (state.blocState == BlocState.Failed) {
            EasyLoading.showToast(translate(context, state.error));
          } else if (state.blocState == BlocState.Successed) {
            EasyLoading.dismiss();
            Navigator.pushReplacementNamed(context, logInName);
          }else if(state.blocState==BlocState.Pending){
            EasyLoading.show(maskType: EasyLoadingMaskType.black);
          }
        }
      },
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          return PopScope(
            canPop: inputEmail,
            onPopInvoked: (didPop) => setState(() {
              inputEmail = true;
            }),
            child: AbsorbPointer(
              absorbing: state.blocState == BlocState.Pending,
              child: GestureDetector(
                onTap: () => KeyboardUtil.hideKeyboard(context),
                child: Scaffold(
                  extendBody: true,
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    title: Text(
                      translate(context, 'forgot_your_password'),
                    ),
                  ),
                  body: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        vertical: dimensHeight() * 2,
                        horizontal: dimensWidth() * 3),
                    children: [
                      inputEmail
                          ? FormEmail(
                              emailController: emailController, isDoctor:widget.isDoctor
                            )
                          : FormChangePassword(
                              emailController: emailController, isDoctor:widget.isDoctor
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
