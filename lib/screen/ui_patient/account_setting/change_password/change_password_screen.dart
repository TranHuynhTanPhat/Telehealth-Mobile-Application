import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import './components/export.dart';
import 'package:healthline/screen/widgets/cancel_button.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        backgroundColor: white,
        appBar: AppBar(
          title: Text(
            translate(context, 'change_password'),
          ),
          leadingWidth: dimensWidth() * 10,
          leading: cancelButton(context),
        ),
        body: SafeArea(
          bottom: true,
          child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
              listener: (context, state) {
            if (state is ChangePasswordState) {
              if (state.blocState == BlocState.Pending) {
                EasyLoading.show(maskType: EasyLoadingMaskType.black);
              } else if (state.blocState == BlocState.Successed) {
                EasyLoading.showToast(translate(context, 'successfully'));
              } else if (state.blocState == BlocState.Failed) {
                EasyLoading.showToast(translate(context, state.error));
              }
            }
          }, builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is ChangePasswordState &&
                  state.blocState == BlocState.Pending,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: const [ChangePasswordForm()],
              ),
            );
          }),
        ),
      ),
    );
  }
}
