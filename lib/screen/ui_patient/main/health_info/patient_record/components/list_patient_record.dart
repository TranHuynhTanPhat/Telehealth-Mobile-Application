import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:intl/intl.dart';

import 'package:healthline/bloc/cubits/cubit_patient_record/patient_record_cubit.dart';
import 'package:healthline/data/api/models/responses/patient_record_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/main/health_info/patient_record/components/export.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';

class ListPatientRecordScreen extends StatefulWidget {
  const ListPatientRecordScreen({super.key});

  @override
  State<ListPatientRecordScreen> createState() =>
      _ListPatientRecordScreenState();
}

class _ListPatientRecordScreenState extends State<ListPatientRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientRecordCubit, PatientRecordState>(
      builder: (context, state) {
        if (state is! FetchPatientRecordLoading) {
          List<PatientRecordResponse> fileRecords = state.records
              .where((element) =>
                  element.folder == null || element.folder == 'default')
              .toList();
          fileRecords.sort((a, b) => a.updateAt!.compareTo(b.updateAt!));
          List<PatientRecordResponse> folderRecords = state.records
              .where((element) =>
                  element.folder != null && element.folder != 'default')
              .toList();

          Map<String, Map<String, dynamic>> fileByFolders = {};
          for (var element in folderRecords) {
            if (fileByFolders.containsKey(element.folder)) {
              DateTime newDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                  .parse(element.updateAt!);
              DateTime oldDate = fileByFolders[element.folder!]!['update_at'];
              fileByFolders[element.folder!]!['length'] += 1;
              fileByFolders[element.folder!]!['update_at'] =
                  newDate.isAfter(oldDate) ? newDate : oldDate;
              // fileByFolders[element.folder!]!.add(element);
            } else if (element.folder != null && element.folder != 'default') {
              DateTime newDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                  .parse(element.updateAt!);
              fileByFolders.addAll({
                element.folder!: {'length': 1, 'update_at': newDate}
              });
            }
          }

          Map<String, int> folderNames = {'default': 5};
          for (var element in folderRecords) {
            if (folderNames.containsKey(element.folder)) {
              folderNames[element.folder!] = folderNames[element.folder!]! + 1;
            } else if (element.folder != null && element.folder != 'default') {
              folderNames.addAll({element.folder!: 1});
            }
          }
          return ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(
                vertical: dimensHeight(), horizontal: dimensWidth() * 3),
            children: [
              ...fileByFolders.entries
                  .map(
                    (mapEntry) => Column(
                      children: [
                        ListTile(
                            onTap: () {
                              PatientRecordCubit patientRecordCubit =
                                  context.read<PatientRecordCubit>();
                              MedicalRecordCubit medicalRecordCubit =
                                  context.read<MedicalRecordCubit>();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: patientRecordCubit,
                                      ),
                                      BlocProvider.value(
                                        value: medicalRecordCubit,
                                      ),
                                    ],
                                    child: FolderPatientRecordScreen(
                                      folderName: mapEntry.key,
                                    ),
                                  ),
                                ),
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                dimensWidth(),
                              ),
                            ),
                            dense: true,
                            visualDensity: const VisualDensity(vertical: 0),
                            leading: FaIcon(
                              FontAwesomeIcons.solidFolderClosed,
                              color: colorDF9F1E,
                              size: dimensIcon(),
                            ),
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    mapEntry.key,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    formatFileDate(
                                        context, mapEntry.value['update_at']),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: black26,
                                            fontWeight: FontWeight.bold),
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
                                          fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        const Divider(),
                      ],
                    ),
                  )
                  .toList(),
              ListFile(fileRecords: fileRecords),
            ],
          );
        } else {
          return ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(
                vertical: dimensHeight(), horizontal: dimensWidth() * 3),
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
                  padding: EdgeInsets.symmetric(vertical: dimensHeight()),
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
    );
  }
}
