import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/app/blocs/blocs_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/ui/auth/login/components/exports.dart';

import 'package:healthline/ui/widgets/elevated_button_widget.dart';
import 'package:healthline/ui/widgets/text_field_widget.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;

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
      create: (context) => LogInBloc(),
      child: BlocListener<LogInBloc, LogInState>(
        listener: (context, state) {
          if (state is NavigateToSignUpActionState) {
            Navigator.pushReplacementNamed(context, signUpName);
          }
        },
        child: Scaffold(
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
                ),
                SizedBox(
                  height: dimensHeight() * 3,
                ),
                TextFieldWidget(
                  controller: _controllerPassword,
                  label: AppLocalizations.of(context).translate("password"),
                  obscureText: true,
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
                        "Forgot your password!",
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
                    onPressed: null),
                const OptionLogIn()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
