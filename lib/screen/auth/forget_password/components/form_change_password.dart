import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';

class FormChangePassword extends StatefulWidget {
  const FormChangePassword({
    super.key,
    required this.emailController, required this.isDoctor,
  });
  // final VoidCallback callback;
  final TextEditingController emailController;
  final bool isDoctor;

  @override
  State<FormChangePassword> createState() => _FormChangePasswordState();
}

class _FormChangePasswordState extends State<FormChangePassword> {
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool showPassword = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(bottom: dimensHeight() * 3),
          //   child: TextFieldWidget(
          //     controller: emailController,
          //     label: translate(context, 'email'),
          //     hint: 'example@gmail.com',
          //     validate: (value) => Validate().validateEmail(context, value),
          //     autovalidateMode: AutovalidateMode.onUserInteraction,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 3),
            child: TextFieldWidget(
                controller: otpController,
                textInputType: const TextInputType.numberWithOptions(),
                label: translate(context, 'OTP'),
                validate: (value) {
                  if (value!.length < 6) {
                    return translate(context, 'invalid');
                  } else {
                    return null;
                  }
                }),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 3),
            child: TextFieldWidget(
              validate: (value) {
                return Validate()
                    .validatePassword(context, passwordController.text);
              },
              controller: passwordController,
              label: translate(context, 'password'),
              obscureText: !showPassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              suffixIcon: IconButton(
                icon: Icon(showPassword
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded),
                onPressed: () {
                  setState(
                    () {
                      showPassword = !showPassword;
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 3),
            child: TextFieldWidget(
              validate: (value) =>
                  confirmPasswordController.text == passwordController.text
                      ? null
                      : translate(context, 'password_must_be_same_as_above'),
              controller: confirmPasswordController,
              label: translate(context, 'confirm_password'),
              obscureText: !showPassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              suffixIcon: IconButton(
                icon: Icon(showPassword
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded),
                onPressed: () {
                  setState(
                    () {
                      showPassword = !showPassword;
                    },
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButtonWidget(
              text: translate(context, 'change_password'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthenticationCubit>().resetPassword(isDoctor: widget.isDoctor,
                      email: widget.emailController.text.trim(),
                      otp: otpController.text.trim(),
                      password: passwordController.text,
                      confirmPassword: confirmPasswordController.text);
                }
              },
            ),
          ),
          // TextButton.icon(
          //     onPressed: widget.callback,
          //     icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          //     label: Text(translate(context, 'back')))
        ],
      ),
    );
  }
}
