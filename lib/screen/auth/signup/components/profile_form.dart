import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/dropdown_button_field.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm(
      {super.key,
      required this.backPressed,
      required this.continuePressed,
      required this.formKey,
      required this.controllerFullName,
      required this.controllerBirthday,
      required this.controllerGender,
      required this.controllerAddress,
      this.gender,
      required this.genderPressed});

  final Function() backPressed;
  final Function() continuePressed;
  final GlobalKey<FormState> formKey;
  final TextEditingController controllerFullName;
  final TextEditingController controllerBirthday;
  final TextEditingController controllerGender;
  final TextEditingController controllerAddress;
  final String? gender;
  final Function(String) genderPressed;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  // final formKey = GlobalKey<FormState>();

  List<String> genders = Gender.values.map((e) => e.name).toList();

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
                if (widget.controllerFullName.text.trim() == '') {
                  return translate(context, 'please_enter_full_name');
                } else if (widget.controllerFullName.text.trim().split(' ').length <
                    2) {
                  return translate(context,
                      'full_name_must_be_longer_than_or_equal_to_2_characters');
                }
                return null;
              },
              controller: widget.controllerFullName,
              label: translate(context, 'full_name'),
              hint: translate(context, 'ex_full_name'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    initialDate: widget.controllerBirthday.text.trim().isNotEmpty
                        ? DateFormat('dd/MM/yyyy')
                            .parse(widget.controllerBirthday.text.trim())
                        : DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now());
                if (date != null) {
                  widget.controllerBirthday.text =
                      // ignore: use_build_context_synchronously
                      formatDayMonthYear(context, date);
                }
              },
              readOnly: true,
              label: translate(context, 'birthday'),
              controller: widget.controllerBirthday,
              validate: (value) => value!.isEmpty
                  ? translate(context, 'please_choose_day_of_birth')
                  : null,
              suffixIcon: const IconButton(
                  onPressed: null, icon: FaIcon(FontAwesomeIcons.calendar)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 3),
            child: DropdownButtonFieldWidget(
              label: translate(context, 'gender'),
              value: widget.gender,
              items: genders
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        translate(context, value.toLowerCase()),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() {
                widget.controllerGender.text =
                    translate(context, value?.toLowerCase());
                widget.genderPressed(value);
              }),
              validator: (value) {
                return value == null || value.isEmpty
                    ? translate(context, 'please_choose_gender')
                    : null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: dimensHeight() * 2),
            child: TextFieldWidget(
              controller: widget.controllerAddress,
              label: translate(context, 'address'),
              validate: (value) => null,
            ),
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
                  text: translate(context, 'continue'),
                  onPressed: () {
                    if (widget.formKey.currentState!.validate()) {
                      widget.formKey.currentState!.save();
                      widget.continuePressed();
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
