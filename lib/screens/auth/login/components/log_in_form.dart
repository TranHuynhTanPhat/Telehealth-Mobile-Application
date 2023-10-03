import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/app/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/widgets/elevated_button_widget.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerPassword;
  final _formKey = GlobalKey<FormState>();
  bool? errorCheckTermsAndConditons;
  bool agreeTermsAndConditions = false;

  String? errorPhone;
  String? errorPassword;

  bool showPassword = false;

  @override
  void initState() {
    _controllerPhone = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  void deactivate() {
    _controllerPhone.dispose();
    _controllerPassword.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: dimensHeight() * 3,
            ),
            child: TextFieldWidget(
              validate: (value) {
                String? error = Validate().validatePhone(context, value!);
                return error;
              },
              controller: _controllerPhone,
              prefix: Padding(
                padding: EdgeInsets.only(right: dimensWidth() * .5),
                child: Text(
                  '+84',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              label: translate(context, 'phone'),
              textInputType: TextInputType.phone,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: dimensHeight() * 3,
            ),
            child: TextFieldWidget(
              validate: (value) {
                try {
                  if (value!.isEmpty) {
                    return translate(context, 'please_enter_password');
                  }
                  return null;
                } catch (e) {
                  return translate(context, 'please_enter_password');
                }
              },
              controller: _controllerPassword,
              label: translate(context, 'password'),
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
            padding: EdgeInsets.only(bottom: dimensHeight() * 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    side: errorCheckTermsAndConditons == true ||
                            errorCheckTermsAndConditons == null
                        ? const BorderSide(width: .5)
                        : BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.error),
                    value: agreeTermsAndConditions,
                    onChanged: (value) => setState(
                      () {
                        agreeTermsAndConditions = value!;
                      },
                    ),
                  ),
                ),
                Text(
                  " ${translate(context, 'i_agree_with')} ",
                  style: Theme.of(context).textTheme.bodySmall,
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
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: secondary, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButtonWidget(
              text: translate(context, 'log_in'),
              onPressed: () {
                setState(() {
                  errorCheckTermsAndConditons = agreeTermsAndConditions;
                });
                if (_formKey.currentState!.validate() &&
                    errorCheckTermsAndConditons == true) {
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  context.read<LogInCubit>().signIn(
                      Validate().changePhoneFormat(_controllerPhone.text),
                      _controllerPassword.text);
                }
              },
            ),
          ),
          TextButton(
            onPressed: () {
              KeyboardUtil.hideKeyboard(context);
            },
            style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.all(0))),
            child: Text(
              translate(context, 'forgot_your_password'),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: color6A6E83,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
