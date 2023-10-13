import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/health_stat_response.dart';
import 'package:healthline/res/style.dart';

import '../../../../utils/keyboard.dart';
import '../../../../utils/translate.dart';
import '../../../widgets/elevated_button_widget.dart';
import '../../../widgets/text_field_widget.dart';

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
  void deactivate() {
    EasyLoading.dismiss();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicalRecordCubit, MedicalRecordState>(
      listener: (context, state) {
        if (state is UpdateStatLoading) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
        } else if (state is UpdateStatSuccessfully) {
          EasyLoading.showToast(translate(context, 'successfully'));
        } else if (state is HealthStatError) {
          EasyLoading.showToast(translate(context, state.message));
        }
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
            title: Text(
              translate(context, 'update_health_stat'),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
            builder: (context, state) {
              int? bloodIndex = state.stats
                  .firstWhere(
                      (element) => element.type == TypeHealthStat.Blood_group,
                      orElse: () => HealthStatResponse())
                  .value;
              _controllerBloodGroup.text = _controllerBloodGroup.text != ''
                  ? _controllerBloodGroup.text
                  : bloodIndex == 0
                      ? 'A'
                      : bloodIndex == 1
                          ? 'B'
                          : bloodIndex == 2
                              ? '0'
                              : 'AB';
              _controllerHeartRate.text = _controllerHeartRate.text == ''
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
                  : _controllerHeartRate.text;
              _controllerHeight.text = _controllerHeight.text == ''
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
                  : _controllerHeight.text;
              _controllerWeight.text = _controllerWeight.text == ''
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
                  : _controllerWeight.text;
              _controllerHead.text = _controllerHead.text == ''
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
                  : _controllerHead.text;
              _controllerTemperature.text = _controllerTemperature.text == ''
                  ? translate(
                      context,
                      state.stats
                              .firstWhere(
                                  (element) =>
                                      element.type ==
                                      TypeHealthStat.Temperature,
                                  orElse: () => HealthStatResponse())
                              .value
                              ?.toString() ??
                          '')
                  : _controllerTemperature.text;
              return AbsorbPointer(
                absorbing: state is UpdateStatLoading,
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
                            padding:
                                EdgeInsets.symmetric(vertical: dimensHeight()),
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
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: dimensHeight()),
                            child: TextFieldWidget(
                              validate: (value) {
                                try {
                                  if (value!.isEmpty) {
                                    return translate(
                                        context, 'please_enter_weight');
                                  }
                                  if (int.parse(value) <= 0) {
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
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: dimensHeight()),
                            child: TextFieldWidget(
                              validate: (value) {
                                try {
                                  if (value!.isEmpty) {
                                    return translate(context,
                                        'please_enter_head_circumference');
                                  }
                                  if (int.parse(value) <= 0) {
                                    return translate(
                                        context, 'invalid_head_circumference');
                                  }
                                  return null;
                                } catch (e) {
                                  return translate(
                                      context, 'invalid_head_circumference');
                                }
                              },
                              controller: _controllerHead,
                              label: translate(context, 'head_circumference'),
                              suffix: const Text('cm'),
                              textInputType: TextInputType.number,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: dimensHeight()),
                            child: TextFieldWidget(
                              validate: (value) {
                                try {
                                  if (value!.isEmpty) {
                                    return translate(
                                        context, 'please_enter_temperature');
                                  }
                                  if (int.parse(value) <= 0) {
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
                            ),
                          ),
                          Row(
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
                                        if (int.parse(value) <= 0) {
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
                                        if (int.parse(value) <= 0) {
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: dimensHeight() * 3),
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
                                                state
                                                    .subUsers[state.currentUser]
                                                    .id!,
                                                _controllerBloodGroup.text,
                                                int.tryParse(
                                                        _controllerHeartRate
                                                            .text) ??
                                                    0,
                                                int.tryParse(_controllerHeight
                                                        .text) ??
                                                    0,
                                                int.tryParse(_controllerWeight
                                                        .text) ??
                                                    0,
                                                int.tryParse(
                                                        _controllerHead.text) ??
                                                    0,
                                                int.tryParse(
                                                        _controllerTemperature
                                                            .text) ??
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
              );
            },
          ),
        ),
      ),
    );
  }
}
