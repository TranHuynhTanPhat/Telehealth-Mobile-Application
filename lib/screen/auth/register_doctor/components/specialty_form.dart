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
import 'package:healthline/utils/file_picker.dart';
import 'package:healthline/utils/translate.dart';

class SpecialtyForm extends StatefulWidget {
  const SpecialtyForm({
    super.key,
    required this.nextPressed,
    required this.backPressed,
    required this.doctorDetailRequest,
    required this.updateDoctorDetail,
  });

  final Function(int) nextPressed;
  final Function() backPressed;
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
  State<SpecialtyForm> createState() => _SpecialtyFormState();
}

class _SpecialtyFormState extends State<SpecialtyForm> {
  final GlobalKey<FormState> _formKeySpecialty = GlobalKey<FormState>();

  List<String> levelOfSpecialties =
      LeverOfSpecialty.values.map((e) => e.name).toList();
  List<String> specialties = Specialty.values.map((e) => e.name).toList();
  List<SpecialtyModelRequest> specialty = [];

  String? _levelOfSpecialty;
  String? _specialty;
  List<String?> images = [];

  bool errorImage = false;

  int curSpecialty = 0;

  @override
  void initState() {
    if (!mounted) return;
    specialty = widget.doctorDetailRequest.specialties ?? [];
    curSpecialty = specialty.length - 1;

    if (curSpecialty != -1) {
      _levelOfSpecialty = specialty[curSpecialty].levelOfSpecialty;
      _specialty = specialty[curSpecialty].specialty;

      images = [specialty[curSpecialty].image];
      // if (!(_levelOfSpecialty == null ||
      //     _specialty == null ||
      //     images.firstOrNull == null)) {
      //   // curSpecialty++;
      // }
    } else {
      curSpecialty = 0;
    }
    super.initState();
  }

  void resetController() {
    _levelOfSpecialty = null;
    _specialty = null;
    images = [];
  }

  void updateSpecialties() {
    if (curSpecialty <= specialty.length) {
      if (_formKeySpecialty.currentState!.validate()) {
        curSpecialty++;
        EasyLoading.showToast(translate(context, 'successfully'));
      }
    }
  }

  void addSpe() {
    if (curSpecialty == specialty.length) {
      // if (_formKeyEduAndCertifications.currentState!.validate()) {
      specialty.add(SpecialtyModelRequest(
          specialty: _specialty,
          levelOfSpecialty: _levelOfSpecialty,
          image: images.firstOrNull));
      // }
    } else {
      specialty[curSpecialty] = SpecialtyModelRequest(
          specialty: _specialty,
          levelOfSpecialty: _levelOfSpecialty,
          image: images.firstOrNull);
    }
  }

  void deleteSpecialty() {
    specialty.removeAt(curSpecialty);
    curSpecialty = specialty.length;
    resetController();
    EasyLoading.showToast(translate(context, 'successfully'));
  }

  void onWillPop(bool didPop) {
    widget.updateDoctorDetail(specialties: specialty);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: onWillPop,
      child: Column(
        children: [
          ...List.generate(
            specialty.length,
            (index) => InkWell(
              splashColor: transparent,
              highlightColor: transparent,
              onTap: () {
                if (curSpecialty != index) {
                  curSpecialty = index;

                  _levelOfSpecialty = specialty[index].levelOfSpecialty;
                  _specialty = specialty[index].specialty;
                  images = [specialty[index].image];
                  // _file = specialtyModel.image;
                  setState(() {});
                }
              },
              child: Container(
                margin: EdgeInsets.only(bottom: dimensHeight() * 3),
                padding: EdgeInsets.symmetric(
                    horizontal: dimensWidth() * 2, vertical: dimensHeight()),
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                      curSpecialty == index ? primary : primary.withOpacity(.1),
                  border: Border.all(width: 2, color: primary),
                  borderRadius: BorderRadius.circular(360),
                ),
                child: Text(
                  "${translate(context, 'brief')}: ${index + 1}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: curSpecialty == index ? white : primary),
                ),
              ),
            ),
          ),
          Form(
            key: _formKeySpecialty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                  child: DropdownButtonFieldWidget(
                    label: translate(context, 'specialty'),
                    value: _specialty,
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
                      _specialty = value;
                      addSpe();
                    }),
                    validator: (value) {
                      return _specialty == null || _specialty == ""
                          ? translate(
                              context, 'please_enter_specialty')
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: dimensHeight() * 3),
                  child: DropdownButtonFieldWidget(
                    label: translate(context, 'level_of_specialty'),
                    value: _levelOfSpecialty,
                    items: levelOfSpecialties
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
                      _levelOfSpecialty = value;
                      addSpe();
                    }),
                    validator: (value) {
                      return _levelOfSpecialty == null ||
                              _levelOfSpecialty == ""
                          ? translate(
                              context, 'please_choose_level_of_specialty')
                          : null;
                    },
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
                            addSpe();
                            setState(() {});
                          }
                        },
                        child: Container(
                          width: dimensWidth() * 10,
                          height: dimensWidth() * 10,
                          decoration: BoxDecoration(
                            color: white,
                            border: Border.all(width: 1, color: colorA8B1CE),
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
                            color: images.firstOrNull == null
                                ? colorA8B1CE
                                : white,
                          ),
                        ),
                      ),
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
                        if (_formKeySpecialty.currentState!.validate() &&
                            images.firstOrNull != null) {
                          updateSpecialties();
                        } else if (images.firstOrNull == null) {
                          errorImage = true;
                        }
                        // _formKeySpecialty.currentState?.reset();
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
                            if (curSpecialty == specialty.length - 1)
                              FaIcon(
                                FontAwesomeIcons.plus,
                                size: dimensWidth() * 2,
                              ),
                            Text(
                              translate(
                                  context,
                                  curSpecialty < specialty.length - 1
                                      ? 'update'
                                      : 'add_information'),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (curSpecialty < specialty.length)
                      InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        onTap: () {
                          deleteSpecialty();
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
                        if(_formKeySpecialty.currentState!.validate()) {
                          updateSpecialties();
                          widget.nextPressed(2);
                        }
                      },
                    ),
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
