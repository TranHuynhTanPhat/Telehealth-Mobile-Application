// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';

import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:intl/intl.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/file_picker.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class UpdateSubUserInputDialog extends StatefulWidget {
  const UpdateSubUserInputDialog({
    super.key,
    required UserResponse userResponse,
  }) : _subUser = userResponse;

  final UserResponse _subUser;

  @override
  State<UpdateSubUserInputDialog> createState() =>
      _UpdateSubUserInputDialogState();
}

class _UpdateSubUserInputDialogState extends State<UpdateSubUserInputDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String> genders = Gender.values.map((e) => e.name).toList();
  List<String> relationships = Relationship.values.map((e) => e.name).toList();

  late TextEditingController _controllerRelationship;
  late TextEditingController _controllerFullname;
  late TextEditingController _controllerBirthday;
  late TextEditingController _controllerGender;
  late TextEditingController _controllerAddress;

  late File? _file;
  var _image;

  String? gender;
  String? relationship;

  @override
  void initState() {
    _controllerGender = TextEditingController();
    _controllerRelationship = TextEditingController();
    _controllerFullname = TextEditingController();
    _controllerBirthday = TextEditingController();
    _controllerAddress = TextEditingController();

    _file = null;
    _image = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _image = widget._subUser.avatar != 'default'
        ? _image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget._subUser.avatar ?? '')
                  .toString(),
            )
        : AssetImage(DImages.placeholder);
    _controllerFullname.text = _controllerFullname.text == ''
        ? translate(context, widget._subUser.fullName!)
        : _controllerFullname.text;
    _controllerRelationship.text = _controllerRelationship.text == '' &&
            widget._subUser.relationship != null
        ? translate(context, widget._subUser.relationship!.name.toLowerCase())
        : _controllerRelationship.text;
    _controllerGender.text = _controllerGender.text == ''
        ? translate(context, widget._subUser.gender!.toLowerCase())
        : _controllerGender.text;
    if (_controllerBirthday.text == '') {
      DateTime date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .parse(widget._subUser.dateOfBirth!);
      _controllerBirthday.text = formatDayMonthYear(context, date);
    }
    _controllerAddress.text = _controllerAddress.text == ''
        ? widget._subUser.address!
        : _controllerAddress.text;
    gender = gender ?? widget._subUser.gender!;
    if (widget._subUser.relationship != null) {
      relationship = relationship ?? widget._subUser.relationship!.name;
    }
    return BlocProvider(
      create: (context) => SubUserCubit(),
      child: BlocListener<SubUserCubit, SubUserState>(
        listenWhen: (previous, current) => current is UpdateUser,
        listener: (context, state) {
          if (state is UpdateUserLoading) {
            EasyLoading.show();
          } else if (state is UpdateUserSuccessfully) {
            EasyLoading.showToast(translate(context, state.message));
            Navigator.pop(context, true);
          } else if (state is UpdateUserFailure) {
            EasyLoading.showToast(translate(context, state.message));
          } else if (state is DeleteUserLoading) {
            EasyLoading.show();
          } else if (state is DeleteUserSuccessfully) {
            EasyLoading.showToast(translate(context, state.message));
            Navigator.pop(context, true);
          } else if (state is DeleteUserFailure) {
            EasyLoading.showToast(translate(context, state.message));
          }
        },
        child: BlocBuilder<SubUserCubit, SubUserState>(
          buildWhen: (previous, current) => current is UpdateUser,
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
              },
              child: AbsorbPointer(
                absorbing:
                    state is UpdateUserLoading || state is DeleteUserLoading,
                child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(dimensWidth() * 3),
                  ),
                  elevation: 0,
                  backgroundColor: white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: dimensHeight() * 3,
                        horizontal: dimensWidth() * 3),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Form(
                            key: _formKey,
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
                                          onBackgroundImageError: (exception,
                                                  stackTrace) =>
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
                                          backgroundImage: _image,
                                          onBackgroundImageError:
                                              (exception, stackTrace) =>
                                                  setState(() {
                                            _image =
                                                AssetImage(DImages.placeholder);
                                          }),
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
                                          return translate(context,
                                              'please_enter_full_name');
                                        }
                                        return null;
                                      } catch (e) {
                                        return translate(
                                            context, 'please_enter_full_name');
                                      }
                                    },
                                    controller: _controllerFullname,
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
                                          initialDatePickerMode:
                                              DatePickerMode.day,
                                          context: context,
                                          initialDate: _controllerBirthday
                                                  .text.isNotEmpty
                                              ? DateFormat("dd/MM/yyyy").parse(
                                                  _controllerBirthday.text)
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
                                        ? translate(context,
                                            'please_choose_day_of_birth')
                                        : null,
                                    suffixIcon: const IconButton(
                                        onPressed: null,
                                        icon:
                                            FaIcon(FontAwesomeIcons.calendar)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dimensHeight()),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: MenuAnchor(
                                          style: MenuStyle(
                                            elevation:
                                                const MaterialStatePropertyAll(
                                                    10),
                                            // shadowColor: MaterialStatePropertyAll(black26),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
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
                                                    horizontal:
                                                        dimensWidth() * 2,
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
                                              label:
                                                  translate(context, 'gender'),
                                              // hint: translate(context, 'ex_full_name'),
                                              controller: _controllerGender,
                                              validate: (value) => value!
                                                      .isEmpty
                                                  ? translate(
                                                      context, 'please_choose')
                                                  : null,
                                              suffixIcon: const IconButton(
                                                  onPressed: null,
                                                  icon: FaIcon(FontAwesomeIcons
                                                      .caretDown)),
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
                                                    translate(context,
                                                        e.toLowerCase()),
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
                                                const MaterialStatePropertyAll(
                                                    10),
                                            // shadowColor: MaterialStatePropertyAll(black26),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
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
                                                    horizontal:
                                                        dimensWidth() * 2,
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
                                              controller:
                                                  _controllerRelationship,
                                              validate: (value) => value!
                                                      .isEmpty
                                                  ? translate(
                                                      context, 'please_choose')
                                                  : null,
                                              suffixIcon: const IconButton(
                                                  onPressed: null,
                                                  icon: FaIcon(FontAwesomeIcons
                                                      .caretDown)),
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
                                                    _controllerRelationship
                                                            .text =
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
                                  padding: EdgeInsets.symmetric(
                                      vertical: dimensHeight()),
                                  child: TextFieldWidget(
                                    validate: (value) => null,
                                    controller: _controllerAddress,
                                    label: translate(context, 'address'),
                                    textInputType: TextInputType.text,
                                  ),
                                ),
                                Row(
                                  children: [
                                    widget._subUser.isMainProfile == false
                                        ? Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: TextButton(
                                                child: Text(
                                                    translate(context,
                                                        'delete_record'),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                            color: color9D4B6C,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            decorationColor:
                                                                color9D4B6C)),
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _formKey.currentState!
                                                        .save();
                                                    context
                                                        .read<SubUserCubit>()
                                                        .deleteUser(widget
                                                            ._subUser.id!);
                                                  }
                                                },
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ElevatedButtonWidget(
                                          text: translate(context, 'update'),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              context
                                                  .read<SubUserCubit>()
                                                  .updateUser(
                                                      _file,
                                                      _controllerFullname.text,
                                                      _controllerBirthday.text,
                                                      gender!,
                                                      relationship!,
                                                      _controllerAddress.text);
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
