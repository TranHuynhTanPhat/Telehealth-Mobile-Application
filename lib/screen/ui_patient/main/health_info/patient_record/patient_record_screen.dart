import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:open_document/open_document.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:healthline/bloc/cubits/cubit_medical_record/medical_record_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_patient_record/patient_record_cubit.dart';
import 'package:healthline/screen/widgets/file_doc_widget.dart';
import 'package:healthline/screen/widgets/file_excel_widget.dart';
import 'package:healthline/screen/widgets/file_pdf_widget.dart';
import 'package:healthline/screen/widgets/file_undefine_widget.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/utils/translate.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:open_file/open_file.dart';

import '../../../../../res/style.dart';

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

  Future<bool> checkPermission() async {
    bool result = true;
    if (Platform.isIOS) {
      result = await Permission.photos.request().then((value) {
        if (!value.isGranted) {
          EasyLoading.showToast(translate(context, 'you_cant_open'));
          return false;
        } else {
          return true;
        }
      });
    }
    if (Platform.isAndroid) {
      result = await Permission.storage.request().then((value) {
        if (!value.isGranted) {
          EasyLoading.showToast(translate(context, 'you_cant_open'));
          return false;
        } else {
          return true;
        }
      });
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientRecordCubit, PatientRecordState>(
      listener: (context, state) async {
        if (state is OpenFileLoading) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
        } else if (state is OpenFileLoaded) {
          EasyLoading.dismiss();

          await OpenDocument.openDocument(filePath: state.filePath);
        } else if (state is OpenFileError) {
          EasyLoading.showToast(translate(context, 'cant_open'));
          if (!await launchUrl(Uri.parse(state.url))) {
            if (!mounted) return;
            EasyLoading.showToast(translate(context, 'cant_opent'));
          }
        }
      },
      child: BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
        builder: (context, state) {
          if (state.currentId != null) {
            context
                .read<PatientRecordCubit>()
                .fetchPatientRecord(state.currentId!);
          } else {
            Navigator.pop(context);
          }
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: white,
            extendBody: true,
            appBar: AppBar(
              title: Text(
                translate(context, 'medical_record'),
              ),
              centerTitle: true,
            ),
            body: BlocBuilder<PatientRecordCubit, PatientRecordState>(
              builder: (context, state) {
                return AbsorbPointer(
                  absorbing: state is FetchPatientRecordLoading ||
                      state is OpenFileLoading,
                  child: state is! FetchPatientRecordLoading
                      ? ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.symmetric(
                              vertical: dimensHeight(),
                              horizontal: dimensWidth() * 3),
                          children: [
                            ...state.records.map((e) {
                              String? url = e.name != null
                                  ? CloudinaryContext.cloudinary
                                      .raw(e.name!)
                                      .toString()
                                  : null;

                              String fileName =
                                  e.name?.split('/').last ?? 'undefine';
                              String type = fileName.split('.').last;
                              return InkWell(
                                  splashColor: transparent,
                                  highlightColor: transparent,
                                  onTap: () async {
                                    // if (await checkPermission()) {

                                    if (Platform.isAndroid) {
                                      var status =
                                          await Permission.storage.status;
                                      if (!status.isGranted) {
                                        await Permission.storage.request();
                                      } else {
                                        if (url != null) {
                                          if (!mounted) return;
                                          context
                                              .read<PatientRecordCubit>()
                                              .openFile(
                                                  url: url, fileName: fileName);
                                        }
                                      }
                                    } else if (Platform.isIOS) {
                                      var status =
                                          await Permission.photos.status;
                                      if (!status.isGranted) {
                                        await Permission.photos.request();
                                      } else {
                                        if (url != null) {
                                          if (!mounted) return;
                                          context
                                              .read<PatientRecordCubit>()
                                              .openFile(
                                                  url: url, fileName: fileName);
                                        }
                                      }
                                    }

                                    // }

                                    // if (!await launchUrl(Uri.parse(url!))) {
                                    //   throw Exception('Could not launch $url');
                                    // }
                                  },
                                  child: ['doc', 'docx'].contains(type)
                                      ? FileDocWidget(
                                          title: translate(context, fileName))
                                      : ['xls', 'xlsm', 'xlsx', 'xlt']
                                              .contains(type)
                                          ? FileExcelWidget(
                                              title:
                                                  translate(context, fileName))
                                          : ['pdf'].contains(type)
                                              ? FilePdfWidget(title: fileName)
                                              : FileUndefineWidget(
                                                  title: fileName));
                            }).toList()
                          ],
                        )
                      : ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.symmetric(
                              vertical: dimensHeight(),
                              horizontal: dimensWidth() * 3),
                          children: [
                            ListTile(
                              onTap: null,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  dimensWidth(),
                                ),
                              ),
                              dense: true,
                              visualDensity: const VisualDensity(vertical: 0),
                              leading: ShimmerWidget.circular(
                                height: dimensIcon(),
                                width: dimensIcon(),
                              ),
                              title: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: dimensHeight()),
                                child: ShimmerWidget.rectangular(
                                  height: dimensIcon(),
                                  width: dimensIcon(),
                                ),
                              ),
                            ),
                          ],
                        ),
                );
              },
            ),
          );
        },
      ),
    );
  }
  // _pushScreen() async {
  //   String name = await OpenDocument.getNameFolder();

  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => MyFilesScreen(filePath: name),
  //     ),
  //   );
  // }
}
