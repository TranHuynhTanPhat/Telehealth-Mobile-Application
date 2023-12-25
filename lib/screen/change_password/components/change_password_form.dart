import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({
    super.key,
  });

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  late TextEditingController _controllerOldPassword;
  late TextEditingController _controllerNewPassword;
  late TextEditingController _controllerConfirmNewPassword;

  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  @override
  void initState() {
    _controllerOldPassword = TextEditingController();
    _controllerNewPassword = TextEditingController();
    _controllerConfirmNewPassword = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: dimensHeight() * 3, top: dimensHeight() * 2),
            child:
            TextFieldWidget(
              validate: (value) {
                return null;
              },
              controller: _controllerOldPassword,
              label: translate(context, 'old_password'),
              obscureText: !showPassword,
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
            padding: EdgeInsets.only(bottom: dimensHeight() * 3, ),
            child: TextFieldWidget(
              validate: (value) {
                return Validate().validatePassword(
                    context, _controllerNewPassword.text.trim());
              },
              // onChanged: (value) => _controllerNewPassword.text =
              //     _controllerNewPassword.text.trim(),
              controller: _controllerNewPassword,
              label: translate(context, 'new_password'),
              obscureText: !showPassword,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 2),
            child: TextFieldWidget(
              validate: (value) => _controllerNewPassword.text.trim() ==
                      _controllerConfirmNewPassword.text.trim()
                  ? null
                  : translate(context, 'password_must_be_same_as_above'),
              controller: _controllerConfirmNewPassword,
              // onChanged: (value) => _controllerConfirmNewPassword.text =
              //     _controllerConfirmNewPassword.text.trim(),
              label: translate(context, 'confirm_new_password'),
              obscureText: !showPassword,
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: dimensHeight()),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButtonWidget(
                text: translate(context, 'update_information'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    context.read<AuthenticationCubit>().changePassword(
                          password: _controllerOldPassword.text.trim(),
                          newPassword:
                              _controllerNewPassword.text.trim(),
                        );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
