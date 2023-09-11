import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/app/cubits/cubits_export.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/auth/login/components/exports.dart';
import 'package:healthline/screens/widgets/elevated_button_widget.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';
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
      create: (context) => LogInCubit(UserRepository()),
      child: BlocListener<LogInCubit, LogInState>(
        listener: (context, state) {
          if (state is LogInLoadingActionState) {
            EasyLoading.show();
          } else if (state is NavigateToSignUpActionState) {
            EasyLoading.dismiss();
            Navigator.pushReplacementNamed(context, signUpName);
          } else if (state is SignInActionState) {
            EasyLoading.dismiss();
            Navigator.pushReplacementNamed(context, mainScreenName);
          } else if (state is LogInErrorActionState) {
            if (state.message.contains("401")) {
              EasyLoading.dismiss();
              EasyLoading.showToast(AppLocalizations.of(context)
                  .translate("email_or_password_is_invalid"));
            }
          }
        },
        child: BlocBuilder<LogInCubit, LogInState>(
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: dimensHeight() * 2,
                    horizontal: dimensWidth() * 2),
                child: ListView(
                  children: [
                    const HeaderLogIn(),
                    SizedBox(
                      height: dimensHeight() * 10,
                    ),
                    TextFieldWidget(
                      controller: _controllerEmail,
                      label: AppLocalizations.of(context).translate("phone_"),
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
                          style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(0))),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate("forgot_your_password"),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: color6A6E83,
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: dimensHeight(),
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
          },
        ),
      ),
    );
  }
}
