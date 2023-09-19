import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/app/cubits/cubit_signup/sign_up_cubit.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/auth/signup/components/exports.dart';
import 'package:healthline/screens/widgets/elevated_button_widget.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _controllerFullName;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerConfirmPassword;
  final _formKey = GlobalKey<FormState>();

  bool agreeTermsAndConditions = false;

  String? errorFullName;
  String? errorPhone;
  String? errorPassword;
  String? errorConfirmPassword;
  bool? errorCheckTermsAndConditons;
  bool showPassword = false;

  @override
  void initState() {
    _controllerFullName = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void deactivate() {
    _controllerFullName.dispose();
    _controllerPhone.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(UserRepository()),
      child: Builder(builder: (context) {
        return BlocListener<SignUpCubit, SignUpState>(
          listenWhen: (previous, current) => current is SignUpActionState,
          listener: (context, state) {
            if (state is SignUpLoadingActionState) {
              EasyLoading.show();
            } else if (state is NavigateToLogInActionState) {
              EasyLoading.dismiss();
              Navigator.pushReplacementNamed(context, logInName);
            } else if (state is RegisterAccountActionState) {
              EasyLoading.dismiss();
            } else if (state is SignUpErrorActionState) {
              // if (state.message.contains('409')) {
              //   EasyLoading.showToast(
              //     AppLocalizations.of(context)
              //         .translate("phone_already_existed"),
              //   );
              // }
              EasyLoading.dismiss();
              EasyLoading.showToast(state.message);
            }
          },
          child: GestureDetector(
            onTap: () => KeyboardUtil.hideKeyboard(context),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                padding: EdgeInsets.symmetric(
                    vertical: dimensHeight() * 10,
                    horizontal: dimensWidth() * 3),
                children: [
                  const HeaderSignUp(),
                  SizedBox(
                    height: dimensHeight() * 5,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                          child: TextFieldWidget(
                            validate: (value) {
                              return _controllerFullName.text == ''
                                  ? translate(context, 'please_enter_fulname')
                                  : null;
                            },
                            controller: _controllerFullName,
                            label: translate(context, 'full_name'),
                            hint: translate(context, 'ex_full_name'),
                            error: errorFullName,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                          child: TextFieldWidget(
                            validate: (value) {
                              return Validate().validatePhone(
                                  context, _controllerPhone.text);
                            },
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
                            controller: _controllerPhone,
                            label: translate(context, 'phone'),
                            textInputType: TextInputType.phone,
                            error: errorPhone,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                          child: TextFieldWidget(
                            validate: (value) {
                              return Validate().validatePassword(
                                  context, _controllerPassword.text);
                            },
                            controller: _controllerPassword,
                            label: translate(context, 'password'),
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: dimensHeight() * 2),
                          child: TextFieldWidget(
                            validate: (value) => _controllerPassword.text ==
                                    _controllerConfirmPassword.text
                                ? null
                                : translate(
                                    context, 'password_must_be_same_as_above'),
                            controller: _controllerConfirmPassword,
                            label: translate(context, 'confirm_password'),
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
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
                                onPressed: null,
                                child: Text(
                                  translate(context, 'terms_and_conditions'),
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
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButtonWidget(
                            text: translate(context, 'create_account'),
                            onPressed: () {
                              setState(() {
                                errorCheckTermsAndConditons =
                                    agreeTermsAndConditions;
                              });

                              if (_formKey.currentState!.validate() &&
                                  errorCheckTermsAndConditons == true) {
                                _formKey.currentState!.save();
                                context.read<SignUpCubit>().registerAccount(
                                    _controllerFullName.text,
                                    Validate().changePhoneFormat(
                                        _controllerPhone.text),
                                    _controllerPassword.text);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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
