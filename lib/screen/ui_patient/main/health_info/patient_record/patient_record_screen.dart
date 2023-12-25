import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/bloc/cubits/cubit_medical_record/medical_record_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_patient_record/patient_record_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_patient/main/health_info/patient_record/components/export.dart';
import 'package:healthline/utils/translate.dart';

class PatientRecordScreen extends StatefulWidget {
  const PatientRecordScreen({super.key});

  @override
  State<PatientRecordScreen> createState() => _PatientRecordScreenState();
}

class _PatientRecordScreenState extends State<PatientRecordScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
      builder: (context, state) {
        if (state.currentId != null) {
          context
              .read<PatientRecordCubit>()
              .fetchPatientRecord(state.currentId!);
        } else {
          Navigator.pop(context);
        }
        return BlocBuilder<PatientRecordCubit, PatientRecordState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: white,
              extendBody: true,
              appBar: AppBar(
                title: Text(
                  translate(context, 'medical_record'),
                ),
                centerTitle: true,
                actions: [
                  if (state is! FetchPatientRecordLoading)
                    Padding(
                      padding: EdgeInsets.only(right: dimensWidth() * 2),
                      child: AbsorbPointer(
                        absorbing: false,
                        child: InkWell(
                          onTap: () async {
                            await Navigator.pushNamed(
                                    context, addPatientRecordName)
                                .then((value) {
                              if (value == true) {
                                setState(() {});
                              }
                            });
                            // showAddPatientRecordDialog(context);
                          },
                          borderRadius: BorderRadius.circular(180),
                          child: Padding(
                            padding: EdgeInsets.all(dimensWidth()),
                            child: FaIcon(
                              FontAwesomeIcons.plus,
                              color: color1F1F1F,
                              size: dimensIcon() * .7,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              body: AbsorbPointer(
                absorbing: state is FetchPatientRecordLoading ||
                    state is DeletePatientRecordLoading ||
                    state is AddPatientRecordLoading ||
                    state is OpenFileLoading,
                child: Builder(builder: (context) {
                  if (state.records.isNotEmpty ||
                      state is FetchPatientRecordLoading) {
                    return const ListPatientRecordScreen();
                  } else {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.boxOpen,
                            color: color1F1F1F.withOpacity(.05),
                            size: dimensWidth() * 30,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: dimensWidth() * 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    style: ButtonStyle(
                                      iconColor:
                                          const MaterialStatePropertyAll(white),
                                      iconSize: MaterialStatePropertyAll(
                                          dimensIcon() * .5),
                                      padding: MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(
                                          vertical: dimensHeight() * 2,
                                          horizontal: dimensWidth() * 2.5,
                                        ),
                                      ),
                                      backgroundColor:
                                          const MaterialStatePropertyAll(
                                              primary),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const FaIcon(FontAwesomeIcons.plus),
                                        SizedBox(
                                          width: dimensWidth(),
                                        ),
                                        Expanded(
                                          child: Text(
                                            translate(context,
                                                'add_patient_record'),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.visible,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(color: white),
                                          ),
                                        )
                                      ],
                                    ),
                                    onPressed: () async {
                                      await Navigator.pushNamed(
                                              context, addPatientRecordName)
                                          .then((value) {
                                        if (value == true) {
                                          setState(() {});
                                        }
                                      });
                                    },
                                  ),
                                ),
                                // const Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
              ),
            );
          },
        );
      },
    );
  }
}
