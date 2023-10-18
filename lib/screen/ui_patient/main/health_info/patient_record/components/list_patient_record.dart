import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:healthline/bloc/cubits/cubit_patient_record/patient_record_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/file_widget.dart';
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
          return ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(
                vertical: dimensHeight(), horizontal: dimensWidth() * 3),
            children: [
              ...state.records.map(
                (e) {
                  String? url = e.name != null
                      ? CloudinaryContext.cloudinary.raw(e.name!).toString()
                      : null;

                  String fileName = e.name?.split('/').last ?? 'undefine';
                  String type = fileName.split('.').last;
                  return InkWell(
                    splashColor: transparent,
                    highlightColor: transparent,
                    onTap: () async {
                      if (Platform.isAndroid) {
                        var status = await Permission.storage.status;
                        if (!status.isGranted) {
                          await Permission.storage.request();
                        } else {
                          if (url != null) {
                            if (!mounted) return;
                            context
                                .read<PatientRecordCubit>()
                                .openFile(url: url, fileName: fileName);
                          }
                        }
                      } else if (Platform.isIOS) {
                        var status = await Permission.photos.status;
                        if (!status.isGranted) {
                          await Permission.photos.request();
                        } else {
                          if (url != null) {
                            if (!mounted) return;
                            context
                                .read<PatientRecordCubit>()
                                .openFile(url: url, fileName: fileName);
                          }
                        }
                      }
                    },
                    child: FileWidget(
                      extension: type,
                      title: fileName,
                    ),
                  );
                },
              ).toList(),
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
