import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/app/cubits/cubit_signup/sign_up_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/ui/auth/signup/components/exports.dart';
import 'package:healthline/ui/widgets/elevated_button_widget.dart';
import 'package:healthline/ui/widgets/text_field_widget.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/validate.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _controllerFullName;
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerConfirmPassword;

  bool agreeTermsAndConditions = false;

  String? errorFullName;
  String? errorEmail;
  String? errorPassword;
  String? errorConfirmPassword;
  bool? errorCheckTermsAndConditons;
  bool showPassword = false;

  @override
  void initState() {
    _controllerFullName = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void deactivate() {
    _controllerFullName.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Builder(builder: (context) {
        return BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (previous, current) => current is SignUpActionState,
          listener: (context, state) {
            if (state is NavigateToLogInActionState) {
              Navigator.pushReplacementNamed(context, logInName);
            } else if (state is RegisterAccountActionState) {
              logPrint("CHECKK");
            } else if (state is SignUpErrorActionState) {}
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: dimensHeight() * 2, horizontal: dimensWidth() * 2),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderSignUp(),
                  SizedBox(
                    height: dimensHeight() * 3,
                  ),
                  TextFieldWidget(
                    controller: _controllerFullName,
                    label: AppLocalizations.of(context).translate('full_name'),
                    hint:
                        AppLocalizations.of(context).translate('ex_full_name'),
                    error: errorFullName,
                  ),
                  SizedBox(
                    height: dimensHeight() * 3,
                  ),
                  TextFieldWidget(
                    controller: _controllerEmail,
                    label: AppLocalizations.of(context).translate('email'),
                    hint: AppLocalizations.of(context).translate('ex_email'),
                    textInputType: TextInputType.emailAddress,
                    error: errorEmail,
                  ),
                  SizedBox(
                    height: dimensHeight() * 3,
                  ),
                  TextFieldWidget(
                    controller: _controllerPassword,
                    label: AppLocalizations.of(context).translate('password'),
                    obscureText: !showPassword,
                    error: errorPassword,
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
                  SizedBox(
                    height: dimensHeight() * 3,
                  ),
                  TextFieldWidget(
                    controller: _controllerConfirmPassword,
                    label: AppLocalizations.of(context)
                        .translate('confirm_password'),
                    obscureText: !showPassword,
                    error: errorConfirmPassword,
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
                  SizedBox(
                    height: dimensHeight() * 2,
                  ),
                  Row(
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
                        " ${AppLocalizations.of(context).translate("i_agree_with")} ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.all(0),
                          ),
                        ),
                        onPressed: null,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("terms_and_conditions"),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: secondary,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dimensHeight() * 3,
                  ),
                  ElevatedButtonWidget(
                    text: AppLocalizations.of(context)
                        .translate("create_account"),
                    onPressed: () {
                      setState(() {
                        _controllerFullName.text == ''
                            ? errorFullName = AppLocalizations.of(context)
                                .translate("please_enter_fulname")
                            : null;
                        errorEmail = Validate()
                            .validateEmail(context, _controllerEmail.text);
                        errorPassword = Validate().validatePassword(
                            context, _controllerPassword.text);
                        errorConfirmPassword = _controllerConfirmPassword
                                    .text ==
                                _controllerPassword.text
                            ? null
                            : AppLocalizations.of(context)
                                .translate("password_must_be_same_as_above");
                        errorCheckTermsAndConditons = agreeTermsAndConditions;
                      });
                      if (errorConfirmPassword == null &&
                          errorFullName == null &&
                          errorEmail == null &&
                          errorPassword == null &&
                          agreeTermsAndConditions == true) {
                        context.read<SignUpCubit>().registerAccount(
                            _controllerFullName.text,
                            _controllerEmail.text,
                            _controllerPassword.text);
                      }
                    },
                  ),
                  const OptionSignUp(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
