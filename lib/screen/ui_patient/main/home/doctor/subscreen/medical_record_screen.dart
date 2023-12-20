import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import "package:healthline/routes/app_pages.dart";
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/patient_record_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/file_widget.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  String? medicalId;
  String? patientName;
  @override
  void initState() {
    if (!mounted) return;
    context.read<MedicalRecordCubit>().fetchMedicalRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalRecordCubit, MedicalRecordState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          extendBody: true,
          bottomNavigationBar: medicalId != null
              ? Container(
                  padding: EdgeInsets.fromLTRB(dimensWidth() * 10, 0,
                      dimensWidth() * 10, dimensHeight() * 3),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.0), white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ElevatedButtonWidget(
                      text: translate(context, 'book_appointment_now'),
                      onPressed: () {
                        context.read<ConsultationCubit>().updateRequest(
                            medicalRecord: medicalId, patientName: patientName);
                        Navigator.pushNamed(
                            context, formMedicalDeclarationName);
                      }),
                )
              : null,
          appBar: AppBar(
            title: Text(
              translate(context, 'medical_record'),
            ),
          ),
          body: AbsorbPointer(
            // absorbing: state is FetchScheduleLoading && state.schedules.isEmpty,
            absorbing: false,
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    vertical: dimensHeight(), horizontal: dimensWidth() * 3),
                children: [
                  ...state.subUsers
                      .map(
                        (e) => ListTile(
                          title: Text(
                            e.fullName ?? translate(context, 'undefine'),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: color1F1F1F),
                          ),
                          subtitle: Text(
                            "${translate(context, 'relationship')}: ${translate(context, e.relationship?.name.toLowerCase() ?? 'you')}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: color1F1F1F),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              dimensWidth(),
                            ),
                          ),
                          onTap: () => setState(() {
                            // _payment = PaymentMethod.Momo;
                            medicalId = e.id;
                            patientName = e.fullName;
                            try {
                              context
                                  .read<PatientRecordCubit>()
                                  .fetchPatientRecord(medicalId!);
                            } catch (e) {
                              EasyLoading.showToast(
                                  translate(context, 'cant_load_data'));
                            }
                          }),
                          dense: true,
                          visualDensity: const VisualDensity(vertical: 0),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: dimensWidth(),
                            vertical: dimensHeight(),
                          ),
                          trailing: Radio<String>(
                            value: e.id!,
                            groupValue: medicalId,
                            onChanged: (String? value) {
                              setState(() {
                                // _payment = value ?? PaymentMethod.None;
                                medicalId = value;
                                patientName = e.fullName;
                                try {
                                  context
                                      .read<PatientRecordCubit>()
                                      .fetchPatientRecord(medicalId!);
                                } catch (e) {
                                  EasyLoading.showToast(
                                      translate(context, 'cant_load_data'));
                                }
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                  BlocBuilder<PatientRecordCubit, PatientRecordState>(
                    builder: (context, state) {
                      if (state is! FetchPatientRecordLoading) {
                        List<PatientRecordResponse> fileRecords = state.records
                            .where((element) =>
                                element.folder == null ||
                                element.folder == 'default')
                            .toList();
                        fileRecords
                            .sort((a, b) => a.updateAt!.compareTo(b.updateAt!));
                        List<PatientRecordResponse> folderRecords = state
                            .records
                            .where((element) =>
                                element.folder != null &&
                                element.folder != 'default')
                            .toList();

                        Map<String, Map<String, dynamic>> fileByFolders = {};
                        for (var element in folderRecords) {
                          if (fileByFolders.containsKey(element.folder)) {
                            DateTime newDate =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .parse(element.updateAt!);
                            DateTime oldDate =
                                fileByFolders[element.folder!]!['update_at'];
                            fileByFolders[element.folder!]!['length'] += 1;
                            fileByFolders[element.folder!]!['update_at'] =
                                newDate.isAfter(oldDate) ? newDate : oldDate;
                            // fileByFolders[element.folder!]!.add(element);
                          } else if (element.folder != null &&
                              element.folder != 'default') {
                            DateTime newDate =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .parse(element.updateAt!);
                            fileByFolders.addAll({
                              element.folder!: {
                                'length': 1,
                                'update_at': newDate
                              }
                            });
                          }
                        }

                        Map<String, int> folderNames = {'default': 5};
                        for (var element in folderRecords) {
                          if (folderNames.containsKey(element.folder)) {
                            folderNames[element.folder!] =
                                folderNames[element.folder!]! + 1;
                          } else if (element.folder != null &&
                              element.folder != 'default') {
                            folderNames.addAll({element.folder!: 1});
                          }
                        }
                        return Column(
                          // scrollDirection: Axis.vertical,
                          // padding: EdgeInsets.symmetric(
                          //     vertical: dimensHeight(),
                          //     horizontal: dimensWidth() * 3),
                          children: [
                            const Divider(
                              thickness: 3,
                            ),
                            Text(
                              translate(context, 'share_information'),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            ...fileByFolders.entries
                                .map(
                                  (mapEntry) => Column(
                                    children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(
                                            dimensWidth()),
                                        child: GestureDetector(
                                          // onTap: () async =>
                                          //     _openFolder(mapEntry.key),
                                          child: ListTile(
                                              onTap: null,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  dimensWidth(),
                                                ),
                                              ),
                                              dense: true,
                                              visualDensity:
                                                  const VisualDensity(
                                                      vertical: 0),
                                              leading: FaIcon(
                                                FontAwesomeIcons
                                                    .solidFolderClosed,
                                                color: colorDF9F1E,
                                                size: dimensIcon(),
                                              ),
                                              title: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      mapEntry.key,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelLarge,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      formatFileDate(
                                                          context,
                                                          mapEntry.value[
                                                              'update_at']),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              color: black26,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${mapEntry.value['length']} ${translate(context, 'items')}',
                                                    textAlign: TextAlign.right,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                            color: black26,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                )
                                .toList(),
                            ...fileRecords.map(
                              (e) {
                                String fileName =
                                    e.record?.split('/').last ?? 'undefine';
                                String type = fileName.split('.').last;
                                DateTime updateAt =
                                    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                        .parse(e.updateAt!);
                                if (['pdf', 'gif', 'jpeg', 'jpg', 'png']
                                    .contains(type)) {
                                } else if ([
                                  'doc',
                                  'docx',
                                  'xls',
                                  'xlsx',
                                  'csv',
                                  'pps',
                                  'ppt',
                                  'pptx'
                                ].contains(type)) {
                                } else if ([
                                  '3gp',
                                  'asf',
                                  'avi',
                                  'm4u',
                                  'm4v',
                                  'mov',
                                  'mp4',
                                  'mpe',
                                  'mpeg',
                                  'mpg',
                                  'mpg4',
                                ].contains(type)) {}

                                return InkWell(
                                  borderRadius:
                                      BorderRadius.circular(dimensWidth()),
                                  child: GestureDetector(
                                    onTap: () {
                                      logPrint(e.id);
                                    },
                                    child: FileWidget(
                                      extension: type,
                                      title: fileName,
                                      updateAt:
                                          formatFileDate(context, updateAt),
                                      size: e.size,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            // ListFolder(fileByFolders: fileByFolders),
                            // ListFile(fileRecords: fileRecords),
                          ],
                        );
                      } else {
                        return Column(
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
                        );
                      }
                    },
                  ),
                ]),
          ),
        );
      },
    );
  }
}
