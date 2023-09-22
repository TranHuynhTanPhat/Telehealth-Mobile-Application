// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/widgets/elevated_button_widget.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';
import 'package:healthline/utils/validate.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _controllerFullName;
  late TextEditingController _controllerBirthday;
  late TextEditingController _controllerSex;
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerAddress;

  List<String> sexs = ['male', 'female', 'undefine'];

  @override
  void initState() {
    _controllerFullName = TextEditingController();
    _controllerBirthday = TextEditingController();
    _controllerSex = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerAddress = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: white,
      appBar: AppBar(title: Text(translate(context, 'edit_profile'))),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => KeyboardUtil.hideKeyboard(context),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: primary,
                      backgroundImage: AssetImage(
                        DImages.placeholder,
                      ),
                      onBackgroundImageError: (exception, stackTrace) =>
                          AssetImage(DImages.placeholder),
                      radius: dimensWidth() * 15,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: dimensWidth() * 13,
                    child: Container(
                      padding: EdgeInsets.all(dimensWidth() * 1.5),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              color: black26.withOpacity(.1),
                              offset: const Offset(0, 0),
                              blurRadius: 3,
                              spreadRadius: 3)
                        ],
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.pen,
                        color: primary,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: dimensWidth() * 2),
                child: Text(
                  "Tran Huynh Tan Phat",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: dimensWidth() * .5),
                child: Text(
                  "0389052819",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: dimensHeight(), horizontal: dimensWidth() * 3),
                child: TextFieldWidget(
                    label: translate(context, 'full_name'),
                    hint: translate(context, 'ex_full_name'),
                    controller: _controllerFullName,
                    validate: (value) => value!.isEmpty
                        ? translate(context, 'please_enter_fulname')
                        : null),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: dimensHeight(), horizontal: dimensWidth() * 3),
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
                padding: EdgeInsets.symmetric(
                    vertical: dimensHeight(), horizontal: dimensWidth() * 3),
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
                      label: translate(context, 'sex'),
                      // hint: translate(context, 'ex_full_name'),
                      controller: _controllerSex,
                      validate: (value) => value!.isEmpty
                          ? translate(context, 'invalid_sex')
                          : null,
                      suffixIcon: const IconButton(
                          onPressed: null,
                          icon: FaIcon(FontAwesomeIcons.caretDown)),
                    );
                  },
                  menuChildren: sexs
                      .map(
                        (e) => MenuItemButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(white)),
                          onPressed: () => setState(() {
                            _controllerSex.text = e;
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
                padding: EdgeInsets.symmetric(
                    vertical: dimensHeight(), horizontal: dimensWidth() * 3),
                child: TextFieldWidget(
                    label: translate(context, 'email'),
                    hint: translate(context, 'ex_email'),
                    controller: _controllerEmail,
                    validate: (value) =>
                        Validate().validateEmail(context, value)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: dimensHeight(), horizontal: dimensWidth() * 3),
                child: TextFieldWidget(
                    label: translate(context, 'address'),
                    // hint: translate(context, 'ex_email'),
                    controller: _controllerAddress,
                    validate: (value) => value!.isEmpty
                        ? translate(context, 'please_enter_fulname')
                        : null),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: dimensHeight(), horizontal: dimensWidth() * 3),
                  child: ElevatedButtonWidget(
                      text: translate(context, 'update'), onPressed: () {})),
            ],
          ),
        ),
      ),
    );
  }
}
