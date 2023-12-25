import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:intl/intl.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/file_picker.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

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
  List<String> genders = Gender.values.map((e) => e.name).toList();
  List<String> relationships = Relationship.values.map((e) => e.name).toList();

  late TextEditingController _controllerRelationship;
  late TextEditingController _controllerFullName;
  late TextEditingController _controllerBirthday;
  late TextEditingController _controllerGender;
  late TextEditingController _controllerAddress;

  late File? _file;

  String gender = '';
  String relationship = '';

  @override
  void initState() {
    _controllerGender = TextEditingController();
    _controllerRelationship = TextEditingController();
    _controllerFullName = TextEditingController();
    _controllerBirthday = TextEditingController();
    _controllerAddress = TextEditingController();

    _file = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        BlocListener<MedicalRecordCubit, MedicalRecordState>(
          listener: (context, state) {
            if (state is AddSubUserLoading) {
              EasyLoading.show(maskType: EasyLoadingMaskType.black);
            } else if (state is AddSubUserSuccessfully) {
              EasyLoading.showToast(translate(context, 'successfully'));
              Navigator.pop(context, true);
            } else if (state is AddSubUserFailure) {
              EasyLoading.showToast(translate(context, state.message));
            }
          },
          child: BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
            // buildWhen: (previous, current) => current is AddSubUserState,
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  KeyboardUtil.hideKeyboard(context);
                },
                child: AbsorbPointer(
                  absorbing: state is AddSubUserLoading,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(dimensWidth() * 3)),
                    padding: EdgeInsets.only(
                        top: dimensHeight() * 3,
                        left: dimensWidth() * 3,
                        right: dimensWidth() * 3,
                        bottom: MediaQuery.of(context).viewInsets.bottom +
                            dimensHeight()*3),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: widget._formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dimensHeight()),
                                  child: _file != null
                                      ? CircleAvatar(
                                          radius: dimensWidth() * 5,
                                          backgroundColor: primary,
                                          backgroundImage: FileImage(_file!),
                                          onBackgroundImageError:
                                              (exception, stackTrace) =>
                                                  AssetImage(DImages.placeholder),
                                          child: InkWell(
                                            splashColor: transparent,
                                            highlightColor: transparent,
                                            onTap: () async {
                                              _file = await FilePickerCustom()
                                                  .getImage();
                                              setState(() {});
                                            },
                                            child: FaIcon(
                                              FontAwesomeIcons.circlePlus,
                                              color: black26,
                                              size: dimensIcon(),
                                            ),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: dimensWidth() * 5,
                                          backgroundColor: primary,
                                          backgroundImage:
                                              AssetImage(DImages.placeholder),
                                          onBackgroundImageError:
                                              (exception, stackTrace) =>
                                                  AssetImage(DImages.placeholder),
                                          child: InkWell(
                                            splashColor: transparent,
                                            highlightColor: transparent,
                                            onTap: () async {
                                              _file = await FilePickerCustom()
                                                  .getImage();
                                              setState(() {});
                                            },
                                            child: FaIcon(
                                              FontAwesomeIcons.circlePlus,
                                              color: black26,
                                              size: dimensIcon(),
                                            ),
                                          ),
                                        ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dimensHeight()),
                                  child: TextFieldWidget(
                                    validate: (value) {
                                      try {
                                        if (value!.isEmpty) {
                                          return translate(
                                              context, 'please_enter_full_name');
                                        }
                                        return null;
                                      } catch (e) {
                                        return translate(
                                            context, 'please_enter_full_name');
                                      }
                                    },
                                    controller: _controllerFullName,
                                    label: translate(context, 'full_name'),
                                    textInputType: TextInputType.text,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dimensHeight()),
                                  child: TextFieldWidget(
                                    onTap: () async {
                                      DateTime? date = await showDatePicker(
                                          initialEntryMode:
                                              DatePickerEntryMode.calendarOnly,
                                          initialDatePickerMode: DatePickerMode.day,
                                          context: context,
                                          initialDate: _controllerBirthday
                                                  .text.isNotEmpty
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
                                        ? translate(
                                            context, 'please_choose_day_of_birth')
                                        : null,
                                    suffixIcon: const IconButton(
                                        onPressed: null,
                                        icon: FaIcon(FontAwesomeIcons.calendar)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dimensHeight()),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: MenuAnchor(
                                          style: MenuStyle(
                                            elevation:
                                                const MaterialStatePropertyAll(10),
                                            // shadowColor: MaterialStatePropertyAll(black26),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    dimensWidth() * 3),
                                              ),
                                            ),
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    white),
                                            surfaceTintColor:
                                                const MaterialStatePropertyAll(
                                                    white),
                                            padding: MaterialStatePropertyAll(
                                                EdgeInsets.symmetric(
                                                    horizontal: dimensWidth() * 2,
                                                    vertical: dimensHeight())),
                                          ),
                                          builder: (BuildContext context,
                                              MenuController controller,
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
                                                  ? translate(
                                                      context, 'please_choose')
                                                  : null,
                                              suffixIcon: const IconButton(
                                                  onPressed: null,
                                                  icon: FaIcon(
                                                      FontAwesomeIcons.caretDown)),
                                            );
                                          },
                                          menuChildren: genders
                                              .map(
                                                (e) => MenuItemButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              white)),
                                                  onPressed: () => setState(() {
                                                    _controllerGender.text =
                                                        translate(context,
                                                            e.toLowerCase());
                                                    gender = e;
                                                  }),
                                                  child: Text(
                                                    translate(
                                                        context, e.toLowerCase()),
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
                                            elevation:
                                                const MaterialStatePropertyAll(10),
                                            // shadowColor: MaterialStatePropertyAll(black26),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    dimensWidth() * 3),
                                              ),
                                            ),
                                            backgroundColor:
                                                const MaterialStatePropertyAll(
                                                    white),
                                            surfaceTintColor:
                                                const MaterialStatePropertyAll(
                                                    white),
                                            padding: MaterialStatePropertyAll(
                                                EdgeInsets.symmetric(
                                                    horizontal: dimensWidth() * 2,
                                                    vertical: dimensHeight())),
                                          ),
                                          builder: (BuildContext context,
                                              MenuController controller,
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
                                              label: translate(
                                                  context, 'relationship'),
                                              // hint: translate(context, 'ex_full_name'),
                                              controller: _controllerRelationship,
                                              validate: (value) => value!.isEmpty
                                                  ? translate(
                                                      context, 'please_choose')
                                                  : null,
                                              suffixIcon: const IconButton(
                                                  onPressed: null,
                                                  icon: FaIcon(
                                                      FontAwesomeIcons.caretDown)),
                                            );
                                          },
                                          menuChildren: relationships
                                              .map(
                                                (e) => MenuItemButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              white)),
                                                  onPressed: () => setState(() {
                                                    _controllerRelationship.text =
                                                        translate(context,
                                                            e.toLowerCase());
                                                    relationship = e;
                                                  }),
                                                  child: Text(
                                                    translate(
                                                        context,
                                                        translate(context,
                                                            e.toLowerCase())),
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
                                  padding: EdgeInsets.only(
                                      top: dimensHeight(),
                                      bottom: dimensHeight() * 3),
                                  child: TextFieldWidget(
                                    validate: (value) => null,
                                    controller: _controllerAddress,
                                    label: translate(context, 'address'),
                                    textInputType: TextInputType.text,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ElevatedButtonWidget(
                                          text: translate(context, 'add_member'),
                                          onPressed: () {
                                            if (widget._formKey.currentState!
                                                .validate()) {
                                              KeyboardUtil.hideKeyboard(context);
                                              widget._formKey.currentState!.save();
                                              context
                                                  .read<MedicalRecordCubit>()
                                                  .addSubUser(
                                                      _file?.path.trim(),
                                                      _controllerFullName.text
                                                          .trim(),
                                                      _controllerBirthday.text
                                                          .trim(),
                                                      gender.trim(),
                                                      relationship.trim(),
                                                      _controllerAddress.text
                                                          .trim());
                                            }
                                            // else if (_file == null) {
                                            //   EasyLoading.showToast(
                                            //       'please_choose_image');
                                            // }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
