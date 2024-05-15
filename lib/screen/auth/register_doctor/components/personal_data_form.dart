import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/data/api/models/requests/doctor_detail_request.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/dropdown_button_field.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';
import 'package:intl/intl.dart';

class PersonalDataForm extends StatefulWidget {
  const PersonalDataForm({
    super.key,
    required this.nextPressed,
    required this.updateDoctorDetail,
    required this.doctorDetailRequest,
  });
  final DoctorDetailRequest doctorDetailRequest;
  final Function(int) nextPressed;
  final Function({
    String? id,
    String? fullName,
    String? phone,
    String? gender,
    String? dayOfBirth,
    String? email,
    String? address,
    List<List<int>>? fixedTime,
    double? ratings,
    String? avatar,
    String? biography,
    int? feePerMinutes,
    int? accountBalance,
    int? numberOfConsultation,
    String? updatedAt,
    List<EducationAndCertificationModelRequest>? educationAndCertifications,
    List<SpecialtyModelRequest>? specialties,
    List<CareerModelRequest>? careers,
  }) updateDoctorDetail;

  @override
  State<PersonalDataForm> createState() => _PersonalDataFormState();
}

class _PersonalDataFormState extends State<PersonalDataForm> {
  List<String> genders = Gender.values.map((e) => e.name).toList();
  final _formKeyPersonalData = GlobalKey<FormState>();
  late TextEditingController _controllerFullName;
  late TextEditingController _controllerPhone;
  late TextEditingController _controllerGender;
  late TextEditingController _controllerDayOfBirth;
  late TextEditingController _controllerEmail;
  // late TextEditingController _controllerFixedTime;
  late TextEditingController _controllerBiography;
  late TextEditingController _controllerAddress;
  String? _gender;

  @override
  void initState() {
    _controllerDayOfBirth = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerFullName = TextEditingController();
    _controllerGender = TextEditingController();
    // _controllerFixedTime = TextEditingController();
    _controllerBiography = TextEditingController();
    _controllerPhone = TextEditingController();
    _controllerAddress = TextEditingController();
    if (!mounted) return;
    _controllerFullName.text = widget.doctorDetailRequest.fullName ?? "";
    _controllerDayOfBirth.text = widget.doctorDetailRequest.dayOfBirth ?? "";
    _controllerEmail.text = widget.doctorDetailRequest.email ?? "";

    // _controllerGender.text = translate(context, widget.doctorDetailRequest.gender ?? "");
    _gender = widget.doctorDetailRequest.gender;
    // _controllerFixedTime = TextEditingController();
    _controllerBiography.text = widget.doctorDetailRequest.biography ?? "";
    _controllerPhone.text = widget.doctorDetailRequest.phone ?? "";
    _controllerAddress.text = widget.doctorDetailRequest.address ?? "";
    super.initState();
  }

  void onWillPop(bool didPop) {
    widget.updateDoctorDetail(
      fullName: _controllerFullName.text,
      dayOfBirth: _controllerDayOfBirth.text,
      email: _controllerEmail.text,
      gender: _gender,
      biography: _controllerBiography.text,
      phone: _controllerPhone.text,
      address: _controllerAddress.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: onWillPop,
      child: Form(
        key: _formKeyPersonalData,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * 3),
              child: TextFieldWidget(
                validate: (value) {
                  if (_controllerFullName.text.trim() == '') {
                    return translate(context, 'please_enter_full_name');
                  } else if (_controllerFullName.text.trim().split(' ').length <
                      2) {
                    return translate(context,
                        'full_name_must_be_longer_than_or_equal_to_2_characters');
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.words,
                controller: _controllerFullName,
                label: translate(context, 'full_name'),
                hint: translate(context, 'ex_full_name'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * 3),
              child: DropdownButtonFieldWidget(
                label: translate(context, 'gender'),
                value: _gender,
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
                  _controllerGender.text =
                      translate(context, value?.toLowerCase());
                  _gender = value;
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
              padding: EdgeInsets.only(bottom: dimensHeight() * 3),
              child: TextFieldWidget(
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      initialDatePickerMode: DatePickerMode.day,
                      context: context,
                      initialDate: _controllerDayOfBirth.text.trim().isNotEmpty
                          ? DateFormat('dd/MM/yyyy')
                              .parse(_controllerDayOfBirth.text.trim())
                          : DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());
                  if (date != null) {
                    _controllerDayOfBirth.text =
                        // ignore: use_build_context_synchronously
                        formatDayMonthYear(context, date);
                  }
                },
                readOnly: true,
                label: translate(context, 'birthday'),
                controller: _controllerDayOfBirth,
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
              child: TextFieldWidget(
                validate: (value) {
                  return Validate()
                      .validatePhone(context, _controllerPhone.text.trim());
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * 3),
              child: TextFieldWidget(
                // error: _conflictEmail == _controllerEmail.text.trim()
                //     ? translate(context, 'email_has_been_registered')
                //     : null,
                label: translate(context, 'email'),
                hint: translate(context, 'ex_email'),
                controller: _controllerEmail,
                validate: (value) {
                  return Validate().validateEmail(context, value);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * 3),
              child: TextFieldWidget(
                controller: _controllerAddress,
                label: translate(context, 'address'),
                textCapitalization: TextCapitalization.sentences,
                validate: (value) => value == null || value.isEmpty
                    ? translate(context, 'invalid')
                    : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: dimensHeight() * 3),
              child: TextFieldWidget(
                controller: _controllerBiography,
                label: translate(context, 'biography'),
                validate: (value) => value == null || value.isEmpty
                    ? translate(context, 'invalue')
                    : null,
                maxLine: 10,
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButtonWidget(
                    text: translate(context, 'done'),
                    onPressed: () {
                      if (_formKeyPersonalData.currentState!.validate()) {
                        widget.nextPressed(0);
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
