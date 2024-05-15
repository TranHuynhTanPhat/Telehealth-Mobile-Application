import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/data/api/models/requests/doctor_detail_request.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/dateformat_extentions.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class CareerForm extends StatefulWidget {
  const CareerForm({
    super.key,
    required this.backPressed,
    required this.doctorDetailRequest,
    required this.updateDoctorDetail, required this.nextPressed,
  });
  final Function() backPressed;
  final Function(int) nextPressed;
  final DoctorDetailRequest doctorDetailRequest;
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
  State<CareerForm> createState() => _CareerFormState();
}

class _CareerFormState extends State<CareerForm> {
  late TextEditingController _controllerMedicalInstitution;
  late TextEditingController _controllerPosition;
  late TextEditingController _controllerPeriodStart;
  late TextEditingController _controllerPeriodEnd;
  final _formKeyCareer = GlobalKey<FormState>();
  List<CareerModelRequest> careers = [];

  int curCareer = 0;

  @override
  void initState() {
    _controllerMedicalInstitution = TextEditingController();
    _controllerPosition = TextEditingController();
    _controllerPeriodStart = TextEditingController();
    _controllerPeriodEnd = TextEditingController();

    if (!mounted) return;
    careers = widget.doctorDetailRequest.careers ?? [];
    curCareer = careers.length - 1;

    if (curCareer != -1) {
      _controllerMedicalInstitution.text =
          careers[curCareer].medicalInstitute ?? "";
      _controllerPosition.text = careers[curCareer].position ?? "";
      _controllerPeriodStart.text = careers[curCareer].periodStart ?? "";
      _controllerPeriodEnd.text = careers[curCareer].periodEnd ?? "";

      // if (!(_controllerMedicalInstitution.text.isEmpty ||
      //     _controllerPeriodEnd.text.isEmpty ||
      //     _controllerPosition.text.isEmpty ||
      //     _controllerPeriodStart.text.isEmpty)) {
      //   curCareer++;
      //   resetController();
      // }
    } else {
      curCareer = 0;
    }
    super.initState();
  }

  void resetController() {
    _controllerMedicalInstitution.text = "";
    _controllerPeriodEnd.text = "";
    _controllerPeriodStart.text = "";
    _controllerPosition.text = "";

    // _formKeyCareer.currentState!.reset();
  }

  void updateCareers() {
    if (curCareer <= careers.length) {
      if (_formKeyCareer.currentState!.validate()) {
        curCareer++;
        EasyLoading.showToast(translate(context, 'successfully'));
      }
    }
  }

  void addSpe() {
    if (curCareer == careers.length) {
      careers.add(
        CareerModelRequest(
            medicalInstitute: _controllerMedicalInstitution.text,
            position: _controllerPosition.text,
            periodStart: _controllerPeriodStart.text,
            periodEnd: _controllerPeriodEnd.text),
      );
    } else {
      careers[curCareer] = CareerModelRequest(
          medicalInstitute: _controllerMedicalInstitution.text,
          position: _controllerPosition.text,
          periodStart: _controllerPeriodStart.text,
          periodEnd: _controllerPeriodEnd.text);
    }
  }

  void deleteCareer() {
    careers.removeAt(curCareer);
    curCareer = careers.length;
    resetController();
    EasyLoading.showToast(translate(context, 'successfully'));
  }

  void onWillPop(bool didPop) {
    widget.updateDoctorDetail(careers: careers);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: onWillPop,
      child: Column(
        children: [
          ...List.generate(
            careers.length,
            (index) => InkWell(
              splashColor: transparent,
              highlightColor: transparent,
              onTap: () {
                if (curCareer != index) {
                  curCareer = index;
                  CareerModelRequest careerModel = careers[index];
                  _controllerMedicalInstitution.text =
                      careerModel.medicalInstitute ?? "";
                  _controllerPosition.text = careerModel.position ?? "";
                  try {
                    if (careerModel.periodStart != null) {
                      _controllerPeriodStart.text = formatDayMonthYear(
                        context,
                        DateFormat('dd/MM/yyyy')
                                .tryParse(careerModel.periodStart!) ??
                            DateTime.now(),
                      );
                    }
                  } catch (e) {
                    logPrint(e);
                  }
                  try {
                    if (careerModel.periodEnd != null) {
                      _controllerPeriodEnd.text = formatDayMonthYear(
                        context,
                        DateFormat('dd/MM/yyyy')
                                .tryParse(careerModel.periodEnd!) ??
                            DateTime.now(),
                      );
                    }
                  } catch (e) {
                    logPrint(e);
                  }
                  setState(() {});
                }
              },
              child: Container(
                margin: EdgeInsets.only(bottom: dimensHeight() * 3),
                padding: EdgeInsets.symmetric(
                    horizontal: dimensWidth() * 2, vertical: dimensHeight()),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: curCareer == index ? primary : primary.withOpacity(.1),
                  border: Border.all(width: 2, color: primary),
                  borderRadius: BorderRadius.circular(360),
                ),
                child: Text(
                  "${translate(context, 'brief')}: ${index + 1}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: curCareer == index ? white : primary),
                ),
              ),
            ),
          ),
          Form(
            key: _formKeyCareer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                  child: TextFieldWidget(
                    validate: (value) {
                      if (_controllerMedicalInstitution.text.trim() == '') {
                        return translate(context, 'invalid');
                      }
                      return null;
                    },
                    onChanged: (p0) => setState(() => addSpe()),
                    textCapitalization: TextCapitalization.words,
                    controller: _controllerMedicalInstitution,
                    label: translate(context, 'medical_institution'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                  child: TextFieldWidget(
                    validate: (value) {
                      if (_controllerPosition.text.trim() == '') {
                        return translate(context, 'invalid');
                      }
                      return null;
                    },
                    onChanged: (p0) => setState(() => addSpe()),
                    textCapitalization: TextCapitalization.sentences,
                    controller: _controllerPosition,
                    label: translate(context, 'position'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Text(
                  translate(context, 'period'),
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                        child: TextFieldWidget(
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                                initialDatePickerMode: DatePickerMode.day,
                                context: context,
                                initialDate: DateFormat('dd/MM/yyyy').tryParse(
                                        _controllerPeriodStart.text.trim()) ??
                                    DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now());
                            if (date != null) {
                              _controllerPeriodStart.text =
                                  // ignore: use_build_context_synchronously
                                  formatDayMonthYear(context, date);
                              setState(() => addSpe());
                            }
                          },
                          hint: translate(context, 'start'),
                          readOnly: true,
                          controller: _controllerPeriodStart,
                          validate: (value) => value!.isEmpty
                              ? translate(context, 'please_choose_period_start')
                              : null,
                          suffixIcon: const IconButton(
                              onPressed: null,
                              icon: FaIcon(FontAwesomeIcons.calendar)),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(dimensWidth(),
                          dimensHeight() * 3, dimensWidth(), dimensHeight()),
                      child: FaIcon(
                        FontAwesomeIcons.arrowRight,
                        size: dimensWidth() * 2,
                        color: colorA8B1CE,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                        child: TextFieldWidget(
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                                initialDatePickerMode: DatePickerMode.day,
                                context: context,
                                initialDate: DateFormat('dd/MM/yyyy').tryParse(
                                        _controllerPeriodEnd.text.trim()) ??
                                    DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now());
                            if (date != null) {
                              _controllerPeriodEnd.text =
                                  // ignore: use_build_context_synchronously
                                  formatDayMonthYear(context, date);
                              setState(() => addSpe());
                            }
                          },
                          hint: translate(context, 'end'),
                          readOnly: true,
                          controller: _controllerPeriodEnd,
                          validate: (value) => value!.isEmpty
                              ? translate(context, 'please_choose_period_end')
                              : null,
                          suffixIcon: const IconButton(
                              onPressed: null,
                              icon: FaIcon(FontAwesomeIcons.calendar)),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashColor: transparent,
                      highlightColor: transparent,
                      onTap: () {
                        if (_formKeyCareer.currentState!.validate()) {
                          updateCareers();
                        }
                        // _formKeyCareer.currentState?.reset();
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: dimensHeight() * 3),
                        padding: EdgeInsets.symmetric(
                            horizontal: dimensWidth() * 2,
                            vertical: dimensHeight() * 2),
                        width: dimensWidth() * 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorA8B1CE.withOpacity(.1),
                          border: Border.all(width: 1, color: colorA8B1CE),
                          borderRadius:
                              BorderRadius.circular(dimensWidth() * 2),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (curCareer == careers.length-1)
                              FaIcon(
                                FontAwesomeIcons.plus,
                                size: dimensWidth() * 2,
                              ),
                            Text(
                              translate(
                                  context,
                                  curCareer < careers.length - 1
                                      ? 'update'
                                      : 'add_information'),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (curCareer < careers.length)
                      InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        onTap: () {
                          deleteCareer();
                          setState(() {});
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: dimensHeight() * 3),
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 2,
                              vertical: dimensHeight() * 2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(.1),
                            border: Border.all(width: 1, color: Colors.red),
                            borderRadius:
                                BorderRadius.circular(dimensWidth() * 2),
                          ),
                          child: Text(
                            translate(context, 'delete'),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.red),
                          ),
                        ),
                      ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(
                              vertical: dimensHeight() * 2,
                              horizontal: dimensWidth() * 2.5),
                        ),
                        elevation: const MaterialStatePropertyAll(0),
                        backgroundColor: const MaterialStatePropertyAll(white),
                        shape: const MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(360)),
                            side: BorderSide(width: 1, color: primary),
                          ),
                        ),
                      ),
                      onPressed: widget.backPressed,
                      child: Text(
                        translate(context, "back"),
                      ),
                    ),
                    ElevatedButtonWidget(
                        text: translate(context, 'done'),
                        onPressed: () {
                          if (_formKeyCareer.currentState!.validate()) {
                          }
                          updateCareers();
widget.nextPressed(3);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
