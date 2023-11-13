import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/patient_record_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/main/health_info/patient_record/components/export.dart';
import 'package:healthline/screen/ui_patient/main/health_info/patient_record/components/list_folder.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';

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
              ListFolder(fileByFolders: fileByFolders),
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