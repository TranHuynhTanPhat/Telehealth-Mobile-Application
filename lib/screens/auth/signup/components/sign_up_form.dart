// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/app/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/widgets/elevated_button_widget.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';
import 'package:intl/intl.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controllerFullName;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerPassword;
  late TextEditingController _controllerConfirmPassword;
  late TextEditingController _controllerGender;
  late TextEditingController _controllerBirthday;
  late TextEditingController _controllerAddress;
  late TextEditingController _controllerEmail;

  bool agreeTermsAndConditions = false;

  bool? errorCheckTermsAndConditons;
  late bool errorProfile;
  late bool errorContact;
  late bool errorPassword;
  bool showPassword = false;
  String? gender;
  int _currentStep = 0;
  List<String> genders = ['Male', 'Female'];

  @override
  void initState() {
    _controllerFullName = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    _controllerBirthday = TextEditingController();
    _controllerGender = TextEditingController();
    _controllerAddress = TextEditingController();
    _controllerEmail = TextEditingController();

    errorProfile = false;
    errorContact = false;
    errorPassword = false;

    super.initState();
  }

  @override
  void deactivate() {
    _controllerFullName.dispose();
    _controllerPhone.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    _controllerBirthday.dispose();
    _controllerGender.dispose();
    _controllerAddress.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpErrorActionState) {
          setState(() {
            state.code == 409 ? errorContact = true : null;
            _currentStep = 1;
          });
        }
      },
      child: Form(
        key: _formKey,
        child: SizedBox(
          height: dimensHeight() *
              (_currentStep == 0
                  ? 65
                  : _currentStep == 1
                      ? 45
                      : 55),
          child: Stepper(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            controlsBuilder: (context, details) {
              return const SizedBox();
            },
            physics: const AlwaysScrollableScrollPhysics(),
            type: StepperType.horizontal,
            currentStep: _currentStep,
            connectorColor: const MaterialStatePropertyAll(secondary),
            onStepTapped: (step) => setState(() => _currentStep = step),
            onStepContinue: () {
              setState(() {
                if (_currentStep < 2) {
                  _currentStep += 1;
                }
              });
            },
            // _currentStep < 2 ? () => setState(() => _currentStep += 1) : null,
            onStepCancel: _currentStep > 0
                ? () => setState(() => _currentStep -= 1)
                : null,
            steps: [
              Step(
                label: _currentStep == 0
                    ? Text(translate(context, 'profile'))
                    : null,
                title: const SizedBox(),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                      child: TextFieldWidget(
                        validate: (value) {
                          return _controllerFullName.text == ''
                              ? translate(context, 'please_enter_full_name')
                              : null;
                        },
                        controller: _controllerFullName,
                        label: translate(context, 'full_name'),
                        hint: translate(context, 'ex_full_name'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                      child: TextFieldWidget(
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              initialDatePickerMode: DatePickerMode.day,
                              context: context,
                              initialDate: _controllerBirthday.text.isNotEmpty
                                  ? DateFormat('dd/MM/yyyy')
                                      .parse(_controllerBirthday.text)
                                  : DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now());
                          if (date != null) {
                            _controllerBirthday.text =
                                // ignore: use_build_context_synchronously
                                formatDayMonthYear(context, date);
                          }
                        },
                        readOnly: true,
                        label: translate(context, 'birthday'),
                        controller: _controllerBirthday,
                        validate: (value) => value!.isEmpty
                            ? translate(context, 'please_choose_day_of_birth')
                            : null,
                        suffixIcon: const IconButton(
                            onPressed: null,
                            icon: FaIcon(FontAwesomeIcons.calendar)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                      child: MenuAnchor(
                        style: MenuStyle(
                          elevation: const MaterialStatePropertyAll(10),
                          // shadowColor: MaterialStatePropertyAll(black26),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(dimensWidth() * 3),
                            ),
                          ),
                          backgroundColor:
                              const MaterialStatePropertyAll(white),
                          surfaceTintColor:
                              const MaterialStatePropertyAll(white),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: dimensWidth() * 2,
                                  vertical: dimensHeight())),
                        ),
                        builder: (BuildContext context,
                            MenuController controller, Widget? child) {
                          return TextFieldWidget(
                            onTap: () {
                              if (controller.isOpen) {
                                controller.close();
                              } else {
                                controller.open();
                              }
                            },
                            readOnly: true,
                            label: translate(context, 'gender'),
                            controller: _controllerGender,
                            validate: (value) => value!.isEmpty
                                ? translate(context, 'please_choose_gender')
                                : null,
                            suffixIcon: const IconButton(
                                onPressed: null,
                                icon: FaIcon(FontAwesomeIcons.caretDown)),
                          );
                        },
                        menuChildren: genders
                            .map(
                              (e) => MenuItemButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(white)),
                                onPressed: () => setState(() {
                                  _controllerGender.text =
                                      translate(context, e.toLowerCase());
                                  gender = e;
                                }),
                                child: Text(
                                  translate(context, e.toLowerCase()),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: dimensHeight() * 2),
                      child: TextFieldWidget(
                        controller: _controllerAddress,
                        label: translate(context, 'address'),
                        validate: (value) => null,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _currentStep < 2
                          ? () => setState(() {
                                _currentStep += 1;
                              })
                          : null,
                      child: Text(
                        translate(context, 'next'),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: secondary),
                      ),
                    ),
                  ],
                ),
                state: errorProfile
                    ? StepState.error
                    : _currentStep == 0
                        ? StepState.editing
                        : _currentStep > 0
                            ? StepState.complete
                            : StepState.disabled,
                isActive: _currentStep == 0,
              ),
              Step(
                label: _currentStep == 1
                    ? Text(translate(context, 'contact'))
                    : null,
                title: const SizedBox(),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                      child: TextFieldWidget(
                          label: translate(context, 'email'),
                          hint: translate(context, 'ex_email'),
                          controller: _controllerEmail,
                          validate: (value) =>
                              Validate().validateEmail(context, value)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: dimensHeight() * 2),
                      child: TextFieldWidget(
                        validate: (value) {
                          return Validate()
                              .validatePhone(context, _controllerPhone.text);
                        },
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
                        controller: _controllerPhone,
                        label: translate(context, 'phone'),
                        textInputType: TextInputType.phone,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _currentStep < 2
                          ? () => setState(() {
                                _currentStep += 1;
                              })
                          : null,
                      child: Text(
                        translate(context, 'next'),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: secondary),
                      ),
                    ),
                  ],
                ),
                state: errorContact
                    ? StepState.error
                    : _currentStep == 1
                        ? StepState.editing
                        : _currentStep > 1
                            ? StepState.complete
                            : StepState.disabled,
                isActive: _currentStep == 1,
              ),
              Step(
                label: _currentStep == 2
                    ? Text(translate(context, 'security'))
                    : null,
                title: const SizedBox(),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                                      color:
                                          Theme.of(context).colorScheme.error),
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
                            onPressed: () => Navigator.pushNamed(
                                context, termsAndConditionsName),
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

                          errorProfile = false;
                          errorContact = false;
                          errorPassword = false;

                          if (_formKey.currentState!.validate() &&
                              errorCheckTermsAndConditons == true) {
                            _formKey.currentState!.save();
                            context.read<SignUpCubit>().registerAccount(
                                  _controllerFullName.text,
                                  Validate()
                                      .changePhoneFormat(_controllerPhone.text),
                                  _controllerEmail.text,
                                  _controllerPassword.text,
                                  _controllerConfirmPassword.text,
                                  gender!,
                                  _controllerBirthday.text,
                                  _controllerAddress.text,
                                );
                          } else {
                            if (!(Validate().validatePassword(
                                        context, _controllerPassword.text) ==
                                    null &&
                                _controllerPassword.text ==
                                    _controllerConfirmPassword.text)) {
                              errorPassword = true;
                              _currentStep = 2;
                            }
                            if (!(Validate().validateEmail(
                                        context, _controllerEmail.text) ==
                                    null &&
                                Validate().validatePhone(
                                        context, _controllerPhone.text) ==
                                    null)) {
                              errorContact = true;
                              _currentStep = 1;
                            }
                            if (_controllerFullName.text.isEmpty ||
                                _controllerBirthday.text.isEmpty ||
                                _controllerGender.text.isEmpty) {
                              errorProfile = true;
                              _currentStep = 0;
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
                state: errorPassword
                    ? StepState.error
                    : _currentStep == 2
                        ? StepState.editing
                        : _currentStep > 2
                            ? StepState.complete
                            : StepState.disabled,
                isActive: _currentStep == 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
