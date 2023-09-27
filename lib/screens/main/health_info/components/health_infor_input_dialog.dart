import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class HealthInforInputDialog extends StatefulWidget {
  const HealthInforInputDialog({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  State<HealthInforInputDialog> createState() => _HealthInforInputDialogState();
}

class _HealthInforInputDialogState extends State<HealthInforInputDialog> {
  final List<String> bloodGroup = ['a', 'b', 'ab', 'o'];

  late TextEditingController _controllerHeartRate;
  late TextEditingController _controllerBloodGroup;
  late TextEditingController _controllerHeight;
  late TextEditingController _controllerWeight;
  late TextEditingController _controllerAge;

  @override
  void initState() {
    _controllerAge = TextEditingController();
    _controllerBloodGroup = TextEditingController();
    _controllerHeartRate = TextEditingController();
    _controllerHeight = TextEditingController();
    _controllerWeight = TextEditingController();
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
        // insetPadding: EdgeInsets.all(dimensWidth() * 2),
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
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFieldWidget(
                              validate: (value) {
                                try {
                                  if (value!.isEmpty) {
                                    return translate(
                                        context, 'please_enter_age');
                                  }
                                  if (int.parse(value) < 0) {
                                    return translate(context, 'invalid_age');
                                  }
                                  return null;
                                } catch (e) {
                                  return translate(context, 'invalid_age');
                                }
                              },
                              controller: _controllerAge,
                              label: translate(context, 'age'),
                              textInputType: TextInputType.number,
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
                                    EdgeInsets.only(
                                        right: dimensWidth() * 25,
                                        left: dimensWidth() * 2,
                                        top: dimensHeight(),
                                        bottom: dimensHeight())),
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
                                  label: translate(context, 'blood_group'),
                                  controller: _controllerBloodGroup,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return translate(
                                          context, 'please_choose');
                                    }
                                    return null;
                                  },
                                  suffixIcon: const IconButton(
                                      onPressed: null,
                                      icon: FaIcon(FontAwesomeIcons.caretDown)),
                                );
                              },
                              menuChildren: bloodGroup
                                  .map(
                                    (e) => MenuItemButton(
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(white)),
                                      onPressed: () => setState(() {
                                        _controllerBloodGroup.text =
                                            translate(context, e).toUpperCase();
                                      }),
                                      child: Text(
                                        translate(context, e).toUpperCase(),
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
                      padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                      child: TextFieldWidget(
                        validate: (value) {
                          try {
                            if (value!.isEmpty) {
                              return translate(context, 'please_enter_height');
                            }
                            if (int.parse(value) <= 0) {
                              return translate(context, 'invalid_height');
                            }
                            return null;
                          } catch (e) {
                            return translate(context, 'invalid_height');
                          }
                        },
                        controller: _controllerHeight,
                        label: translate(context, 'height'),
                        suffix: const Text('cm'),
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                      child: TextFieldWidget(
                        validate: (value) {
                          try {
                            if (value!.isEmpty) {
                              return translate(context, 'please_enter_weight');
                            }
                            if (int.parse(value) <= 0) {
                              return translate(context, 'invalid_weight');
                            }
                            return null;
                          } catch (e) {
                            return translate(context, 'invalid_weight');
                          }
                        },
                        controller: _controllerWeight,
                        label: translate(context, 'weight'),
                        suffix: const Text('Kg'),
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                      child: TextFieldWidget(
                        validate: (value) {
                          try {
                            if (value!.isEmpty) {
                              return translate(context, 'please_enter_weight');
                            }
                            if (int.parse(value) <= 0) {
                              return translate(context, 'invalid_heart_rate');
                            }
                            return null;
                          } catch (e) {
                            return translate(context, 'invalid_heart_rate');
                          }
                        },
                        controller: _controllerHeartRate,
                        label: translate(context, 'heart_rate'),
                        suffix: const Text('bpm'),
                        textInputType: TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: Text(translate(context, 'update_information')),
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
