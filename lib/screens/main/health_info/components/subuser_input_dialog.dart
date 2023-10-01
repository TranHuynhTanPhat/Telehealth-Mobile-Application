import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class SubUserInputDialog extends StatefulWidget {
  const SubUserInputDialog({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  State<SubUserInputDialog> createState() => _SubUserInputDialogState();
}

class _SubUserInputDialogState extends State<SubUserInputDialog> {
  final List<String> bloodGroup = ['a', 'b', 'ab', 'o'];
  List<String> genders = ['Male', 'Female'];
  List<String> relationships = ['Children', 'Parent', 'Grandparent', 'Sibling'];

  late TextEditingController _controllerRelationship;
  late TextEditingController _controllerFullname;
  late TextEditingController _controllerBirthday;
  late TextEditingController _controllerGender;

  @override
  void initState() {
    _controllerGender = TextEditingController();
    _controllerRelationship = TextEditingController();
    _controllerFullname = TextEditingController();
    _controllerBirthday = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(dimensWidth() * 3),
        ),
        elevation: 0,
        backgroundColor: white,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: dimensHeight() * 3, horizontal: dimensWidth() * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: widget._formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                      child: CircleAvatar(
                        radius: dimensWidth() * 5,
                        backgroundColor: primary,
                        backgroundImage: AssetImage(DImages.placeholder),
                        onBackgroundImageError: (exception, stackTrace) =>
                            AssetImage(DImages.placeholder),
                        child: FaIcon(
                          FontAwesomeIcons.circlePlus,
                          color: black26,
                          size: dimensIcon(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                      child: TextFieldWidget(
                        validate: (value) {
                          try {
                            if (value!.isEmpty) {
                              return translate(
                                  context, 'please_enter_full_name');
                            }
                            return null;
                          } catch (e) {
                            return translate(context, 'please_enter_full_name');
                          }
                        },
                        controller: _controllerFullname,
                        label: translate(context, 'full_name'),
                        textInputType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: dimensHeight()),
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
                        // hint: translate(context, 'ex_full_name'),
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
                      padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: MenuAnchor(
                              style: MenuStyle(
                                elevation: const MaterialStatePropertyAll(10),
                                // shadowColor: MaterialStatePropertyAll(black26),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        dimensWidth() * 3),
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
                                  // hint: translate(context, 'ex_full_name'),
                                  controller: _controllerGender,
                                  validate: (value) => value!.isEmpty
                                      ? translate(context, 'please_choose')
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
                                            translate(context, e);
                                      }),
                                      child: Text(
                                        translate(context, e),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          SizedBox(
                            width: dimensWidth() * 1.5,
                          ),
                          Expanded(
                            child: MenuAnchor(
                              style: MenuStyle(
                                elevation: const MaterialStatePropertyAll(10),
                                // shadowColor: MaterialStatePropertyAll(black26),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        dimensWidth() * 3),
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
                                  label: translate(context, 'relationship'),
                                  // hint: translate(context, 'ex_full_name'),
                                  controller: _controllerRelationship,
                                  validate: (value) => value!.isEmpty
                                      ? translate(context, 'please_choose')
                                      : null,
                                  suffixIcon: const IconButton(
                                      onPressed: null,
                                      icon: FaIcon(FontAwesomeIcons.caretDown)),
                                );
                              },
                              menuChildren: relationships
                                  .map(
                                    (e) => MenuItemButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(white)),
                                      onPressed: () => setState(() {
                                        _controllerRelationship.text =
                                            translate(context, e.toLowerCase());
                                      }),
                                      child: Text(
                                        translate(context, translate(context,e.toLowerCase())),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: Text(translate(context, 'add_member')),
                        onPressed: () {
                          if (widget._formKey.currentState!.validate()) {
                            widget._formKey.currentState!.save();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
