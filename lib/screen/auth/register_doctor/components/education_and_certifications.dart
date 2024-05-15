import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_doctor/doctor_cubit.dart';
import 'package:healthline/data/api/models/requests/doctor_detail_request.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/dropdown_button_field.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/file_picker.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class EducationAndCertificationsForm extends StatefulWidget {
  const EducationAndCertificationsForm({
    super.key,
    required this.nextPressed,
    required this.backPressed,
    required this.doctorDetailRequest,
    required this.updateDoctorDetail,
  });
  final DoctorDetailRequest doctorDetailRequest;
  final Function() backPressed;
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
  State<EducationAndCertificationsForm> createState() =>
      _EducationAndCertificationsFormState();
}

class _EducationAndCertificationsFormState
    extends State<EducationAndCertificationsForm> {
  bool errorImage = false;
  List<EducationAndCertificationModelRequest> educationAndCertifications = [];

  List<String> typeOfEducationAndExperiences =
      TypeOfEducationAndExperience.values.map((e) => e.name).toList();
  List<String> degreeOfEducation =
      DegreeOfEducation.values.map((e) => e.name).toList();
  int curCertification = 0;
  final _formKeyEduAndCertifications = GlobalKey<FormState>();

  late TextEditingController _controllerInstitution;
  // late TextEditingController _controllerSpecialtyByDiploma;
  late TextEditingController _controllerAddress;
  late TextEditingController _controllerDiplomaNumberAndSeries;
  late TextEditingController _controllerDateOfReceiptOfDiploma;

  String? _typeOfEduAndExp;
  String? _degreeOfEdu;
  String? _specialtyByDiploma;
  List<String?> images = [];
  // ignore: prefer_typing_uninitialized_variables
  var image;

  List<String> specialties = Specialty.values.map((e) => e.name).toList();

  @override
  void initState() {
    image = null;
    _controllerInstitution = TextEditingController();
    // _controllerSpecialtyByDiploma = TextEditingController();
    _controllerAddress = TextEditingController();
    _controllerDiplomaNumberAndSeries = TextEditingController();
    _controllerDateOfReceiptOfDiploma = TextEditingController();
    if (!mounted) return;
    educationAndCertifications =
        widget.doctorDetailRequest.educationAndCertifications ?? [];
    curCertification = educationAndCertifications.length - 1;

    if (curCertification != -1) {
      _controllerInstitution.text =
          educationAndCertifications[curCertification].institution ?? "";
      // _controllerSpecialtyByDiploma.text =
      //     educationAndCertifications[curCertification].specialtyByDiploma ?? "";
      _controllerAddress.text =
          educationAndCertifications[curCertification].address ?? "";
      _controllerDiplomaNumberAndSeries.text =
          educationAndCertifications[curCertification].diplomaNumberAndSeries ??
              "";
      _controllerDateOfReceiptOfDiploma.text =
          educationAndCertifications[curCertification].dateOfReceiptOfDiploma ??
              "";
      _typeOfEduAndExp = educationAndCertifications[curCertification]
          .typeOfEducationAndExperience;
      _degreeOfEdu =
          educationAndCertifications[curCertification].degreeOfEducation;
      _specialtyByDiploma =
          educationAndCertifications[curCertification].specialtyByDiploma;
      images = [educationAndCertifications[curCertification].image];
      // if (!(_controllerInstitution.text.isEmpty ||
      //     _controllerAddress.text.isEmpty ||
      //     _controllerDiplomaNumberAndSeries.text.isEmpty ||
      //     _controllerDateOfReceiptOfDiploma.text.isEmpty ||
      //     _typeOfEduAndExp == null ||
      //     _degreeOfEdu == null ||
      //     _specialtyByDiploma == null ||
      //     images.firstOrNull == null)) {
      //   curCertification++;
      //   resetController();
      // }
    } else {
      curCertification = 0;
    }

    super.initState();
  }

  void updateEducationAndCertifications() {
    if (curCertification <= educationAndCertifications.length) {
      if (_formKeyEduAndCertifications.currentState!.validate()) {
        curCertification++;
        EasyLoading.showToast(translate(context, 'successfully'));
      }
    }
  }

  void addEdu() {
    if (curCertification == educationAndCertifications.length) {
      // if (_formKeyEduAndCertifications.currentState!.validate()) {
      educationAndCertifications.add(
        EducationAndCertificationModelRequest(
          typeOfEducationAndExperience: _typeOfEduAndExp,
          degreeOfEducation: _degreeOfEdu,
          institution: _controllerInstitution.text,
          address: _controllerAddress.text,
          specialtyByDiploma: _specialtyByDiploma,
          diplomaNumberAndSeries: _controllerDiplomaNumberAndSeries.text,
          dateOfReceiptOfDiploma: _controllerDateOfReceiptOfDiploma.text,
          image: images.firstOrNull,
        ),
      );
      // }
    } else {
      educationAndCertifications[curCertification] =
          EducationAndCertificationModelRequest(
              typeOfEducationAndExperience: _typeOfEduAndExp,
              degreeOfEducation: _degreeOfEdu,
              institution: _controllerInstitution.text,
              address: _controllerAddress.text,
              specialtyByDiploma: _specialtyByDiploma,
              diplomaNumberAndSeries: _controllerDiplomaNumberAndSeries.text,
              dateOfReceiptOfDiploma: _controllerDateOfReceiptOfDiploma.text,
              image: images.firstOrNull);
    }
  }

  void deleteEducationAndCertifications() {
    educationAndCertifications.removeAt(curCertification);
    curCertification = educationAndCertifications.length;
    resetController();
    EasyLoading.showToast(translate(context, 'successfully'));
  }

  void resetController() {
    _controllerInstitution.clear();
    _controllerAddress.clear();
    _controllerDiplomaNumberAndSeries.clear();
    _controllerDateOfReceiptOfDiploma.clear();
    _typeOfEduAndExp = null;
    _degreeOfEdu = null;
    _specialtyByDiploma = null;
    images = [];
  }

  void onWillPop(bool didPop) {
    // educationAndCertifications.forEach((element) {
    //   print(element.toJson());
    // });
    widget.updateDoctorDetail(
        educationAndCertifications: educationAndCertifications);
  }

  @override
  Widget build(BuildContext context) {
    // try {
    //   if (images.firstOrNull != null) {
    //     image = image ??
    //         NetworkImage(
    //           CloudinaryContext.cloudinary
    //               .image(images.firstOrNull ?? '')
    //               .toString(),
    //         );

    //   } else {
    //     image = AssetImage(DImages.placeholder);
    //   }
    // } catch (e) {
    //   image = AssetImage(DImages.placeholder);
    // }
    return PopScope(
      canPop: true,
      onPopInvoked: onWillPop,
      child: Column(
        children: [
          ...List.generate(
            educationAndCertifications.length,
            (index) => InkWell(
              splashColor: transparent,
              highlightColor: transparent,
              onTap: () {
                if (curCertification != index) {
                  curCertification = index;

                  _controllerInstitution.text =
                      educationAndCertifications[index].institution ?? "";
                  // _controllerSpecialtyByDiploma.text =
                  //     educationAndCertifications[curCertification].specialtyByDiploma ?? "";
                  _controllerAddress.text =
                      educationAndCertifications[index].address ?? "";
                  _controllerDiplomaNumberAndSeries.text =
                      educationAndCertifications[index]
                              .diplomaNumberAndSeries ??
                          "";
                  _controllerDateOfReceiptOfDiploma.text =
                      educationAndCertifications[index]
                              .dateOfReceiptOfDiploma ??
                          "";
                  _typeOfEduAndExp = educationAndCertifications[index]
                      .typeOfEducationAndExperience;
                  _degreeOfEdu =
                      educationAndCertifications[index].degreeOfEducation;
                  _specialtyByDiploma =
                      educationAndCertifications[index].specialtyByDiploma;
                  images = [educationAndCertifications[index].image];
                  errorImage = false;
                  setState(() {});
                }
              },
              child: Container(
                margin: EdgeInsets.only(bottom: dimensHeight() * 3),
                padding: EdgeInsets.symmetric(
                    horizontal: dimensWidth() * 2, vertical: dimensHeight()),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: curCertification == index
                      ? primary
                      : primary.withOpacity(.1),
                  border: Border.all(width: 2, color: primary),
                  borderRadius: BorderRadius.circular(360),
                ),
                child: Text(
                  "${translate(context, 'brief')}: ${index + 1}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: curCertification == index ? white : primary),
                ),
              ),
            ),
          ),
          // if (curCertification < educationAndCertifications.length)
          //   InkWell(
          //     splashColor: transparent,
          //     highlightColor: transparent,
          //     onTap: () {
          //       curCertification = educationAndCertifications.length;
          //       resetController();
          //       setState(() {});
          //     },
          //     child: Container(
          //       margin: EdgeInsets.only(bottom: dimensHeight() * 3),
          //       padding: EdgeInsets.symmetric(
          //           horizontal: dimensWidth() * 2, vertical: dimensHeight()),
          //       width: double.infinity,
          //       decoration: BoxDecoration(
          //         color: colorA8B1CE.withOpacity(.1),
          //         border: Border.all(width: 2, color: colorA8B1CE),
          //         borderRadius: BorderRadius.circular(360),
          //       ),
          //       child: Text(
          //         "+ ${translate(context, 'brief')}",
          //         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          //             fontWeight: FontWeight.w900, color: colorA8B1CE),
          //       ),
          //     ),
          //   ),
          Form(
            key: _formKeyEduAndCertifications,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                  child: DropdownButtonFieldWidget(
                    label: translate(context, 'type_of_education'),
                    value: _typeOfEduAndExp,
                    items: typeOfEducationAndExperiences
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
                      // _controllerTypeOfEduAndExp.text =
                      //     translate(context, value?.toLowerCase());
                      _typeOfEduAndExp = value;
                      addEdu();
                    }),
                    validator: (value) {
                      return _typeOfEduAndExp == null || _typeOfEduAndExp == ""
                          ? translate(
                              context, 'please_choose_type_of_education')
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                  child: DropdownButtonFieldWidget(
                    label: translate(context, 'degree_of_education'),
                    value: _degreeOfEdu,
                    items: degreeOfEducation
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
                      // _controllerDegreeOfEducation.text =
                      //     translate(context, value?.toLowerCase());
                      _degreeOfEdu = value;
                      addEdu();
                    }),
                    validator: (value) {
                      return _degreeOfEdu == null || _degreeOfEdu == ""
                          ? translate(context, 'please_choose_degree')
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                  child: TextFieldWidget(
                    validate: (value) {
                      if (_controllerInstitution.text.trim() == '') {
                        return translate(context, 'invalid');
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                    onChanged: (p0) => setState(() => addEdu()),
                    controller: _controllerInstitution,
                    label: translate(context, 'institution'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                  child: DropdownButtonFieldWidget(
                    label: translate(context, 'specialty_by_diploma'),
                    value: _specialtyByDiploma,
                    items: specialties
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
                      _specialtyByDiploma = value;
                      addEdu();
                    }),
                    validator: (value) {
                      if (_specialtyByDiploma == '' ||
                          _specialtyByDiploma == null) {
                        return translate(context, 'invalid');
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                  child: TextFieldWidget(
                    validate: (value) {
                      if (_controllerAddress.text.trim() == '') {
                        return translate(context, 'invalid');
                      }
                      return null;
                    },
                    onChanged: (p0) => setState(() => addEdu()),
                    controller: _controllerAddress,
                    label: translate(context, 'address'),
                    textCapitalization: TextCapitalization.sentences,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                  child: TextFieldWidget(
                    validate: (value) {
                      if (_controllerDiplomaNumberAndSeries.text.trim() == '') {
                        return translate(context, 'invalid');
                      }
                      return null;
                    },
                    onChanged: (p0) => addEdu(),
                    controller: _controllerDiplomaNumberAndSeries,
                    label: translate(context, 'diploma_number_and_series'),
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
                          initialDate: _controllerDateOfReceiptOfDiploma.text
                                  .trim()
                                  .isNotEmpty
                              ? DateFormat('dd/MM/yyyy').parse(
                                  _controllerDateOfReceiptOfDiploma.text.trim())
                              : DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());

                      if (date != null) {
                        _controllerDateOfReceiptOfDiploma.text =
                            // ignore: use_build_context_synchronously
                            formatDayMonthYear(context, date);
                        setState(() {
                          addEdu();
                        });
                      }
                    },
                    readOnly: true,
                    label: translate(context, 'date_of_receipt_of_diploma'),
                    controller: _controllerDateOfReceiptOfDiploma,
                    validate: (value) => value == null ||
                            value.isEmpty ||
                            _controllerDateOfReceiptOfDiploma.text.isEmpty
                        ? translate(
                            context, 'please_choose_date_of_receipt_of_diploma')
                        : null,
                    suffixIcon: const IconButton(
                        onPressed: null,
                        icon: FaIcon(FontAwesomeIcons.calendar)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                        child: Text(
                          translate(context, 'upload_image'),
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                      InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        onTap: () async {
                          if (widget.doctorDetailRequest.phone == null ||
                              widget.doctorDetailRequest.phone!.isEmpty) {
                            EasyLoading.showToast(translate(
                                context, 'please_enter_phone_number'));
                            Navigator.pop(context, 0);
                          } else {
                            File? file = await FilePickerCustom().getImage();
                            // ignore: use_build_context_synchronously
                            images = await context
                                .read<DoctorCubit>()
                                .uploadImageSpecialty(
                                    images: [file],
                                    phone: widget.doctorDetailRequest.phone!);
                            errorImage = false;
                            addEdu();
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: dimensWidth() * 10,
                          height: dimensWidth() * 10,
                          decoration: BoxDecoration(
                            color: white,
                            border: Border.all(
                                width: 1,
                                color: errorImage ? Colors.red : colorA8B1CE),
                            image: images.firstOrNull != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                      CloudinaryContext.cloudinary
                                          .image(images.firstOrNull ?? '')
                                          .toString(),
                                    ),
                                    fit: BoxFit.fill)
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: FaIcon(
                            FontAwesomeIcons.plus,
                            color: errorImage ? Colors.red : colorA8B1CE,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      splashColor: transparent,
                      highlightColor: transparent,
                      onTap: () {
                        if (_formKeyEduAndCertifications.currentState!
                                .validate() &&
                            images.firstOrNull != null) {
                          updateEducationAndCertifications();
                        } else if (images.firstOrNull == null) {
                          errorImage = true;
                        }
                        // _formKeyEduAndCertifications.currentState?.reset();
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
                            if (curCertification ==
                                educationAndCertifications.length - 1)
                              FaIcon(
                                FontAwesomeIcons.plus,
                                size: dimensWidth() * 2,
                              ),
                            Text(
                              translate(
                                  context,
                                  curCertification <
                                          educationAndCertifications.length - 1
                                      ? 'update'
                                      : 'add_information'),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (curCertification < educationAndCertifications.length)
                      InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        onTap: () {
                          deleteEducationAndCertifications();
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
                          if (_formKeyEduAndCertifications.currentState!
                              .validate() && images.firstOrNull!=null) {
                                updateEducationAndCertifications();
                            widget.nextPressed(1);
                          }else if(images.firstOrNull==null){
                            errorImage = true;
                          }
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
