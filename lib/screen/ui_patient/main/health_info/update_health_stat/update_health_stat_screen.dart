import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/menu_anchor_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/keyboard.dart';
import '../../../../../utils/translate.dart';
import '../../../../widgets/elevated_button_widget.dart';
import '../../../../widgets/text_field_widget.dart';

class HealthStatUpdateScreen extends StatefulWidget {
  const HealthStatUpdateScreen({super.key});

  @override
  State<HealthStatUpdateScreen> createState() => _HealthStatUpdateScreenState();
}

class _HealthStatUpdateScreenState extends State<HealthStatUpdateScreen> {
  final List<String> bloodGroup = BloodGroup.values.map((e) => e.name).toList();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _controllerHeartRate;
  late TextEditingController _controllerBloodGroup;
  late TextEditingController _controllerHeight;
  late TextEditingController _controllerWeight;
  late TextEditingController _controllerHead;
  late TextEditingController _controllerTemperature;
  int? age;
  num? bloodIndex;

  bool onChange = false;

  @override
  void initState() {
    _controllerBloodGroup = TextEditingController();
    _controllerHeartRate = TextEditingController();
    _controllerHeight = TextEditingController();
    _controllerWeight = TextEditingController();
    _controllerHead = TextEditingController();
    _controllerTemperature = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controllerBloodGroup.dispose();
    _controllerHeartRate.dispose();
    _controllerHeight.dispose();
    _controllerWeight.dispose();
    _controllerHead.dispose();
    _controllerTemperature.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicalRecordCubit, MedicalRecordState>(
      listener: (context, state) {
        if (state is UpdateStatSuccessfully) {
          EasyLoading.showToast(translate(context, 'successfully'));
          onChange = true;
        } else if (state is NoChange) {
          EasyLoading.showToast(translate(context, 'successfully'));
        } else if (state is UpdateStatLoading) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
        }
      },
      child: BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
        builder: (context, state) {
          if (state.subUsers.isNotEmpty) {
            age = calculateAge(DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(
                state.subUsers
                    .firstWhere((element) => element.id == state.currentId)
                    .dateOfBirth!));

            bloodIndex = state.stats
                .firstWhere(
                    (element) => element.type == TypeHealthStat.Blood_group,
                    orElse: () => HealthStatResponse())
                .value;
          }

          _controllerBloodGroup.text = _controllerBloodGroup.text.trim() != ''
              ? _controllerBloodGroup.text
              : bloodIndex == 0
                  ? 'A'
                  : bloodIndex == 1
                      ? 'B'
                      : bloodIndex == 2
                          ? 'O'
                          : bloodIndex == 3
                              ? 'AB'
                              : '--';
          _controllerHeartRate.text = _controllerHeartRate.text.trim() == ''
              ? translate(
                  context,
                  state.stats
                          .firstWhere(
                              (element) =>
                                  element.type == TypeHealthStat.Heart_rate,
                              orElse: () => HealthStatResponse())
                          .value
                          ?.toString() ??
                      '')
              : _controllerHeartRate.text.trim();
          _controllerHeight.text = _controllerHeight.text.trim() == ''
              ? translate(
                  context,
                  state.stats
                          .firstWhere(
                              (element) =>
                                  element.type == TypeHealthStat.Height,
                              orElse: () => HealthStatResponse())
                          .value
                          ?.toString() ??
                      '')
              : _controllerHeight.text.trim();
          _controllerWeight.text = _controllerWeight.text.trim() == ''
              ? translate(
                  context,
                  state.stats
                          .firstWhere(
                              (element) =>
                                  element.type == TypeHealthStat.Weight,
                              orElse: () => HealthStatResponse())
                          .value
                          ?.toString() ??
                      '')
              : _controllerWeight.text.trim();
          _controllerHead.text = _controllerHead.text.trim() == ''
              ? translate(
                  context,
                  state.stats
                          .firstWhere(
                              (element) =>
                                  element.type ==
                                  TypeHealthStat.Head_cricumference,
                              orElse: () => HealthStatResponse())
                          .value
                          ?.toString() ??
                      '')
              : _controllerHead.text.trim();
          _controllerTemperature.text = _controllerTemperature.text.trim() == ''
              ? translate(
                  context,
                  state.stats
                          .firstWhere(
                              (element) =>
                                  element.type == TypeHealthStat.Temperature,
                              orElse: () => HealthStatResponse())
                          .value
                          ?.toString() ??
                      '')
              : _controllerTemperature.text.trim();
          return PopScope(
            canPop: true,
            onPopInvoked: (value) {
              // Navigator.pop(context, onChange);
            },
            child: GestureDetector(
              onTap: () {
                KeyboardUtil.hideKeyboard(context);
              },
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: white,
                extendBody: true,
                appBar: AppBar(
                  leading: Center(
                      child: InkWell(
                    splashColor: transparent,
                    highlightColor: transparent,
                    onTap: () {
                      Navigator.pop(context, onChange);
                    },
                    child: const FaIcon(FontAwesomeIcons.angleLeft),
                  )),
                  title: Text(
                    translate(context, 'update_health_stat'),
                  ),
                  centerTitle: true,
                ),
                body: AbsorbPointer(
                  absorbing: state is MedicalRecordLoadingState,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 3,
                        vertical: dimensHeight() * 3),
                    scrollDirection: Axis.vertical,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: dimensHeight()),
                                child: MenuAnchorWidget(
                                  label: 'blood_group',
                                  textEditingController: _controllerBloodGroup,
                                  menuChildren: bloodGroup
                                      .map(
                                        (e) => MenuItemButton(
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(white),
                                          ),
                                          onPressed: () => setState(() {
                                            _controllerBloodGroup.text =
                                                translate(context, e);
                                          }),
                                          child: Text(
                                            translate(context, e),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: dimensHeight()),
                              child: TextFieldWidget(
                                validate: (value) {
                                  try {
                                    if (value!.isEmpty) {
                                      return translate(
                                          context, 'please_enter_heart_rate');
                                    }
                                    if (num.parse(value) <= 30 ||
                                        num.parse(value) >= 160) {
                                      return translate(
                                          context, 'invalid_heart_rate');
                                    }

                                    return null;
                                  } catch (e) {
                                    return translate(
                                        context, 'invalid_heart_rate');
                                  }
                                },
                                controller: _controllerHeartRate,
                                label: translate(context, 'heart_rate'),
                                suffix: const Text('bpm'),
                                textInputType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            if (age != null && age! <= 3)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: dimensHeight()),
                                child: TextFieldWidget(
                                  validate: (value) {
                                    try {
                                      if (value!.isEmpty) {
                                        return translate(context,
                                            'please_enter_head_circumference');
                                      }
                                      if (num.parse(value) <= 10 ||
                                          num.parse(value) >= 100) {
                                        return translate(context,
                                            'invalid_head_circumference');
                                      }
                                      return null;
                                    } catch (e) {
                                      return translate(context,
                                          'invalid_head_circumference');
                                    }
                                  },
                                  controller: _controllerHead,
                                  label:
                                      translate(context, 'head_circumference'),
                                  suffix: const Text('cm'),
                                  textInputType: TextInputType.number,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                          context, 'please_enter_temperature');
                                    }
                                    if (num.parse(value) <= 36 ||
                                        num.parse(value) > 38) {
                                      return translate(
                                          context, 'invalid_temperature');
                                    }
                                    return null;
                                  } catch (e) {
                                    return translate(
                                        context, 'invalid_temperature');
                                  }
                                },
                                controller: _controllerTemperature,
                                label: translate(context, 'temperature'),
                                suffix: const Text('cm'),
                                textInputType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: dimensHeight()),
                                    child: TextFieldWidget(
                                      validate: (value) {
                                        try {
                                          if (value!.isEmpty) {
                                            return translate(
                                                context, 'please_enter_height');
                                          }
                                          if (num.parse(value) <= 0 ||
                                              num.parse(value) > 300) {
                                            return translate(
                                                context, 'invalid_height');
                                          }
                                          return null;
                                        } catch (e) {
                                          return translate(
                                              context, 'invalid_height');
                                        }
                                      },
                                      controller: _controllerHeight,
                                      label: translate(context, 'height'),
                                      suffix: const Text('cm'),
                                      textInputType: TextInputType.number,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: dimensWidth() * 2,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: dimensHeight()),
                                    child: TextFieldWidget(
                                      validate: (value) {
                                        try {
                                          if (value!.isEmpty) {
                                            return translate(
                                                context, 'please_enter_weight');
                                          }
                                          if (num.parse(value) <= 0 ||
                                              num.parse(value) > 300) {
                                            return translate(
                                                context, 'invalid_weight');
                                          }

                                          return null;
                                        } catch (e) {
                                          return translate(
                                              context, 'invalid_weight');
                                        }
                                      },
                                      controller: _controllerWeight,
                                      label: translate(context, 'weight'),
                                      suffix: const Text('Kg'),
                                      textInputType: TextInputType.number,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: dimensHeight() * 3),
                                    child: ElevatedButtonWidget(
                                      text: translate(
                                          context, 'update_information'),
                                      onPressed: () {
                                        KeyboardUtil.hideKeyboard(context);
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          context
                                              .read<MedicalRecordCubit>()
                                              .updateStats(
                                                  state.subUsers
                                                      .firstWhere((element) =>
                                                          element.id ==
                                                          state.currentId)
                                                      .id!,
                                                  _controllerBloodGroup.text
                                                      .trim(),
                                                  num.tryParse(_controllerHeartRate
                                                          .text
                                                          .trim()) ??
                                                      0,
                                                  num.tryParse(_controllerHeight
                                                          .text
                                                          .trim()) ??
                                                      0,
                                                  num.tryParse(_controllerWeight.text
                                                          .trim()) ??
                                                      0,
                                                  num.tryParse(_controllerHead
                                                          .text
                                                          .trim()) ??
                                                      0,
                                                  num.tryParse(
                                                          _controllerTemperature
                                                              .text
                                                              .trim()) ??
                                                      0);
                                        }
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
    );
  }
}
