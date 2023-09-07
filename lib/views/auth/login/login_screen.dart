import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/app/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/config_loading.dart';
import 'package:healthline/views/auth/login/components/exports.dart';
import 'package:healthline/views/widgets/elevated_button_widget.dart';
import 'package:healthline/views/widgets/text_field_widget.dart';
import 'package:healthline/utils/validate.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;

  String? errorEmail;
  String? errorPassword;

  bool showPassword = false;

  @override
  void initState() {
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    super.initState();
  }

  @override
  void deactivate() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(),
      child: BlocListener<LogInCubit, LogInState>(
        listener: (context, state) {
          if (state is NavigateToSignUpActionState) {
            Navigator.pushReplacementNamed(context, signUpName);
          } else if (state is SignInActionState) {
            configLoading();
          } else if (state is LogInErrorActionState) {}
        },
        child: Builder(builder: (context) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: dimensHeight() * 2, horizontal: dimensWidth() * 2),
              child: ListView(
                children: [
                  const HeaderLogIn(),
                  SizedBox(
                    height: dimensHeight() * 10,
                  ),
                  TextFieldWidget(
                    controller: _controllerEmail,
                    label: AppLocalizations.of(context).translate("email"),
                    hint: AppLocalizations.of(context).translate("ex_email"),
                    textInputType: TextInputType.emailAddress,
                    error: errorEmail,
                  ),
                  SizedBox(
                    height: dimensHeight() * 3,
                  ),
                  TextFieldWidget(
                    controller: _controllerPassword,
                    label: AppLocalizations.of(context).translate("password"),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: null,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("forgot_your_password"),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: color6A6E83),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dimensHeight() * 3,
                  ),
                  ElevatedButtonWidget(
                      text: AppLocalizations.of(context).translate('log_in'),
                      onPressed: () {
                        setState(() {
                          errorEmail = Validate()
                              .validateEmail(context, _controllerEmail.text);
                          errorPassword = _controllerPassword.text.isEmpty
                              ? AppLocalizations.of(context)
                                  .translate('please_enter_password')
                              : null;

                          if (errorEmail == null && errorPassword == null) {
                            context.read<LogInCubit>().signIn(
                                _controllerEmail.text,
                                _controllerPassword.text);
                          }
                        });
                      }),
                  const OptionLogIn()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
