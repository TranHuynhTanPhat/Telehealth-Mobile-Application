// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  bool agreeTermsAndConditions = false;

  String? errorFullName;
  String? errorPhone;
  String? errorPassword;
  String? errorConfirmPassword;
  bool? errorCheckTermsAndConditons;
  bool showPassword = false;
  List<String> genders = ['male', 'female', 'undefine'];

  @override
  void initState() {
    _controllerFullName = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerPassword = TextEditingController();
    _controllerConfirmPassword = TextEditingController();
    _controllerBirthday = TextEditingController();
    _controllerGender = TextEditingController();

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
    return Form(
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
                return Validate().validatePhone(context, _controllerPhone.text);
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
              error: errorPhone,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 3),
            child: TextFieldWidget(
              onTap: () async {
                DateTime? date = await showDatePicker(
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
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
              // hint: translate(context, 'ex_full_name'),
              controller: _controllerBirthday,
              validate: (value) => value!.isEmpty
                  ? translate(context, 'please_enter_fulname')
                  : null,
              suffixIcon: const IconButton(
                  onPressed: null, icon: FaIcon(FontAwesomeIcons.calendar)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 3),
            child: MenuAnchor(
              style: MenuStyle(
                elevation: const MaterialStatePropertyAll(10),
                // shadowColor: MaterialStatePropertyAll(black26),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(dimensWidth() * 3),
                  ),
                ),
                backgroundColor: const MaterialStatePropertyAll(white),
                surfaceTintColor: const MaterialStatePropertyAll(white),
                padding: MaterialStatePropertyAll(
                    EdgeInsets.only(right: dimensWidth() * 30)),
              ),
              builder: (BuildContext context, MenuController controller,
                  Widget? child) {
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
                  // hint: translate(context, 'ex_full_name'),
                  controller: _controllerGender,
                  validate: (value) => value!.isEmpty
                      ? translate(context, 'invalid_Gender')
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
                          backgroundColor: MaterialStatePropertyAll(white)),
                      onPressed: () => setState(() {
                        _controllerGender.text = e;
                      }),
                      child: Text(
                        translate(context, e),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 3),
            child: TextFieldWidget(
              validate: (value) {
                return Validate()
                    .validatePassword(context, _controllerPassword.text);
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
              validate: (value) =>
                  _controllerPassword.text == _controllerConfirmPassword.text
                      ? null
                      : translate(context, 'password_must_be_same_as_above'),
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
                  onPressed: null,
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
              text: translate(context, 'create_account'),
              onPressed: () {
                setState(() {
                  errorCheckTermsAndConditons = agreeTermsAndConditions;
                });

                if (_formKey.currentState!.validate() &&
                    errorCheckTermsAndConditons == true) {
                  _formKey.currentState!.save();
                  context.read<SignUpCubit>().registerAccount(
                      _controllerFullName.text,
                      Validate().changePhoneFormat(_controllerPhone.text),
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
