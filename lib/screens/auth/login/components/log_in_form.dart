import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/widgets/elevated_button_widget.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';
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
                                String? error =
                                    Validate().validatePhone(context, value!);
                                return error;
                              },
                              controller: _controllerPhone,
                              prefix: Padding(
                                padding:
                                    EdgeInsets.only(right: dimensWidth() * .5),
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
                                    return translate(
                                        context, 'please_enter_password');
                                  }
                                  return null;
                                } catch (e) {
                                  return translate(
                                      context, 'please_enter_password');
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
                          TextButton(
                            onPressed: null,
                            style: const ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(0))),
                            child: Text(
                              translate(context, 'forgot_your_password'),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: color6A6E83,
                                  ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButtonWidget(
                              text: translate(context, 'log_in'),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  context.read<LogInCubit>().signIn(
                                      Validate().changePhoneFormat(
                                          _controllerPhone.text),
                                      _controllerPassword.text);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
  }
}