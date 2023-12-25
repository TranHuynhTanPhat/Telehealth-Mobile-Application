import 'package:flutter/material.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    Key? key,
    required this.backPressed,
    required this.createAccountPressed,
    required this.formKey,
    required this.controllerPassword,
    required this.controllerConfirmPassword,
    required this.agreeTermsAndConditions,
    required this.agreeTermsAndConditionsPressed,
  }) : super(key: key);

  final Function() backPressed;
  final Function() createAccountPressed;
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerPassword;
  final TextEditingController controllerConfirmPassword;
  final bool agreeTermsAndConditions;
  final Function(bool) agreeTermsAndConditionsPressed;

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool showPassword = false;

  bool? errorCheckTermsAndConditions;

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 3),
            child: TextFieldWidget(
              validate: (value) {
                return Validate()
                    .validatePassword(context, widget.controllerPassword.text.trim());
              },
              controller: widget.controllerPassword,
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
            padding: EdgeInsets.only(bottom: dimensHeight() * 2),
            child: TextFieldWidget(
              validate: (value) => widget.controllerPassword.text.trim() ==
                      widget.controllerConfirmPassword.text.trim()
                  ? null
                  : translate(context, 'password_must_be_same_as_above'),
              controller: widget.controllerConfirmPassword,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: Checkbox(
                  side: errorCheckTermsAndConditions == true ||
                          errorCheckTermsAndConditions == null
                      ? const BorderSide(width: .5)
                      : BorderSide(
                          width: 1, color: Theme.of(context).colorScheme.error),
                  value: widget.agreeTermsAndConditions,
                  onChanged: (value) => setState(
                    () {
                      widget.agreeTermsAndConditionsPressed(value!);
                    },
                  ),
                ),
              ),
              InkWell(
                splashColor: transparent,
                highlightColor: transparent,
                onTap: () {
                  setState(() {
                    widget.agreeTermsAndConditionsPressed(
                        !widget.agreeTermsAndConditions);
                  });
                },
                child: Text(
                  " ${translate(context, 'i_agree_with')} ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              TextButton(
                style: const ButtonStyle(
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.all(0),
                  ),
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, termsAndConditionsName),
                child: Text(
                  translate(context, 'terms_and_conditions'),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: secondary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: dimensHeight() * 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: widget.backPressed,
                  child: Text(
                    translate(context, 'back'),
                  ),
                ),
                const Spacer(),
                ElevatedButtonWidget(
                  text: translate(context, 'create_account'),
                  onPressed: () {
                    if (widget.formKey.currentState!.validate() &&
                        widget.agreeTermsAndConditions) {
                      widget.formKey.currentState!.save();
                      widget.createAccountPressed();
                    } else if (!widget.agreeTermsAndConditions) {
                      setState(() {
                        errorCheckTermsAndConditions = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
