import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/cancel_button.dart';
import 'package:healthline/screen/widgets/save_button.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class AddVaccinationScreen extends StatefulWidget {
  const AddVaccinationScreen({super.key});

  @override
  State<AddVaccinationScreen> createState() => _AddVaccinationScreenState();
}

class _AddVaccinationScreenState extends State<AddVaccinationScreen> {
  late TextEditingController _controllerDisease;
  late TextEditingController _controllerDayOfLastDose;
  int? _index;
  int? _dose;
  int _currentStep = 0;

  late List<String> listId;

  @override
  void initState() {
    _controllerDisease = TextEditingController();
    _controllerDayOfLastDose = TextEditingController();
    _dose = null;
    listId = [];
    super.initState();
  }

  bool checkValid() {
    return _controllerDisease.text.trim().isNotEmpty &&
            _controllerDayOfLastDose.text.trim().isNotEmpty
        ? true
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VaccineRecordCubit, VaccineRecordState>(
      listener: (context, state) {
        if (state is CreateVaccinationRecordState &&
            state.blocState == BlocState.Successed) {
          Navigator.pop(context, true);
        } else if (state is FetchVaccinationState &&
            state.blocState == BlocState.Failed) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<VaccineRecordCubit, VaccineRecordState>(
        builder: (context, state) {
          try {
            listId =
                state.injectedVaccinations.map((e) => e.vaccine!.id!).toList();
          } catch (e) {
            logPrint(e);
          }
          if (state.vaccinations.isEmpty) {
            context.read<VaccineRecordCubit>().fetchVaccination();
          }
          return GestureDetector(
            onTap: () => KeyboardUtil.hideKeyboard(context),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              extendBody: true,
              backgroundColor: white,
              appBar: AppBar(
                title: Text(
                  translate(context, 'add_vaccination'),
                ),
                centerTitle: true,
                leading: cancelButton(context),
                actions: [
                  if (checkValid())
                    Padding(
                      padding: EdgeInsets.only(right: dimensWidth() * 2),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(180),
                        onTap: () => context
                            .read<VaccineRecordCubit>()
                            .createVaccinationRecordState(
                                state.vaccinations[_index!].id!,
                                _currentStep + 1,
                                _controllerDayOfLastDose.text.trim()),
                        child: saveButton(context),
                      ),
                    )
                ],
              ),
              body: AbsorbPointer(
                absorbing: state.blocState == BlocState.Pending,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(
                    vertical: dimensHeight(),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dimensHeight(),
                        horizontal: dimensWidth() * 3,
                      ),
                      child: MenuAnchor(
                        onOpen: () {
                          setState(() {
                            // _controllerVaccine.text = '';
                            _dose = null;
                          });
                        },
                        onClose: () {},
                        style: MenuStyle(
                          elevation: const MaterialStatePropertyAll(10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(dimensWidth() * 3),
                            ),
                          ),
                          backgroundColor:
                              const MaterialStatePropertyAll(white),
                          surfaceTintColor:
                              const MaterialStatePropertyAll(white),
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 2,
                              vertical: dimensHeight(),
                            ),
                          ),
                          maximumSize: MaterialStatePropertyAll(
                            Size(dimensWidth() * 40, dimensHeight() * 55),
                          ),
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
                            label: translate(context, 'vaccination'),
                            controller: _controllerDisease,
                            validate: (value) => null,
                            suffixIcon: const IconButton(
                              onPressed: null,
                              icon: FaIcon(FontAwesomeIcons.caretDown),
                            ),
                          );
                        },
                        menuChildren: state.vaccinations
                            .where((element) {
                              if (listId.contains(element.id)) {
                                return false;
                              } else {
                                if (state.age < 9) {
                                  return element.isChild == true;
                                } else {
                                  return element.isChild == false;
                                }
                              }
                            })
                            .map(
                              (e) => MenuItemButton(
                                style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(white)),
                                onPressed: () => setState(() {
                                  _controllerDisease.text =
                                      translate(context, e.disease.toString());
                                  setState(() {
                                    _index = state.vaccinations.indexOf(e);

                                    int dose =
                                        state.vaccinations[_index!].maxDose!;
                                    // _controllerVaccine.text = dose.toString();
                                    _currentStep = 0;
                                    _dose = dose;
                                    // }
                                  });
                                }),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: dimensHeight(),
                                      bottom: dimensHeight()),
                                  color: white,
                                  width: dimensWidth() * 30,
                                  child: Text(
                                    translate(context, e.disease.toString()),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    if (_dose != null && _dose! > 0)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                        child: Text(
                            '${translate(context, "how_many_doses_have_you_received")} - ${_currentStep + 1}'),
                      ),
                    if (_dose != null && _dose! > 0)
                      Container(
                        height: dimensHeight() * 18,
                        alignment: Alignment.topCenter,
                        child: Stepper(
                          physics: const NeverScrollableScrollPhysics(),
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          steps: [
                            ...List.generate(
                              _dose!,
                              (index) => Step(
                                  title: const SizedBox(),
                                  label: Text(
                                      '${translate(context, 'dose')} ${index + 1}'),
                                  content: const SizedBox(),
                                  state: _currentStep >= index
                                      ? StepState.complete
                                      : StepState.indexed),
                            ),
                          ],
                          type: StepperType.horizontal,
                          currentStep: _currentStep,
                          connectorColor:
                              const MaterialStatePropertyAll(secondary),
                          controlsBuilder: (context, details) =>
                              const SizedBox(),
                          onStepTapped: (step) => setState(() {
                            _currentStep = step;
                          }),
                        ),
                      ),
                    _dose != null && _dose! > 0
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 3,
                            ),
                            child: TextFieldWidget(
                              onTap: () async {
                                DateTime? date = await showDatePicker(
                                    initialEntryMode:
                                        DatePickerEntryMode.calendarOnly,
                                    initialDatePickerMode: DatePickerMode.day,
                                    context: context,
                                    initialDate:
                                        _controllerDayOfLastDose.text.isNotEmpty
                                            ? DateFormat('dd/MM/yyyy').parse(
                                                _controllerDayOfLastDose.text)
                                            : DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());
                                if (date != null) {
                                  setState(() {
                                    _controllerDayOfLastDose.text =
                                        // ignore: use_build_context_synchronously
                                        formatDayMonthYear(context, date);
                                  });
                                }
                              },
                              readOnly: true,
                              label: translate(context, 'time_dose'),
                              controller: _controllerDayOfLastDose,
                              validate: (value) => value!.isEmpty
                                  ? translate(context, 'please_choose')
                                  : null,
                              suffixIcon: const IconButton(
                                  onPressed: null,
                                  icon: FaIcon(FontAwesomeIcons.calendar)),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
