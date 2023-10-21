import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';

import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/ui_patient/main/health_info/patient_record/components/export.dart';
import 'package:healthline/utils/keyboard.dart';

class FolderPatientRecordScreen extends StatefulWidget {
  const FolderPatientRecordScreen({super.key, required this.folderName});
  final String folderName;

  @override
  State<FolderPatientRecordScreen> createState() =>
      _FolderPatientRecordScreenState();
}

class _FolderPatientRecordScreenState extends State<FolderPatientRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientRecordCubit, PatientRecordState>(
      listener: (context, state) {
        if (state is DeletePatientRecordLoaded) {
          if (state.records
              .where((element) => element.folder == widget.folderName)
              .isEmpty) {
            Navigator.pop(context);
          }
        }
      },
      child: BlocBuilder<PatientRecordCubit, PatientRecordState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              KeyboardUtil.hideKeyboard(context);
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  widget.folderName,
                ),
                actions: [
                  if (state is! FetchPatientRecordLoading)
                    Padding(
                      padding: EdgeInsets.only(right: dimensWidth() * 2),
                      child: AbsorbPointer(
                        absorbing: false,
                        child:
                            BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
                          builder: (context, state) {
                            return InkWell(
                              onTap: () async {
                                await Navigator.pushNamed(
                                        context, addPatientRecordName)
                                    .then((value) {
                                  if (value == true) {
                                    setState(() {
                                      if (state.currentId != null) {
                                        context
                                            .read<PatientRecordCubit>()
                                            .fetchPatientRecord(
                                                state.currentId!);
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    });
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
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
              body: AbsorbPointer(
                absorbing: false,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(
                        vertical: dimensHeight() * 3,
                        horizontal: dimensWidth() * 3),
                    children: [
                      ListFile(
                          fileRecords: state.records
                              .where((element) =>
                                  element.folder == widget.folderName)
                              .toList())
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
