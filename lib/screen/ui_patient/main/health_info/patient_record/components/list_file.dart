import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/bloc/cubits/cubit_patient_record/patient_record_cubit.dart';
import 'package:healthline/data/api/models/responses/patient_record_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/file_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ListFile extends StatefulWidget {
  const ListFile({super.key, required this.fileRecords});
  final List<PatientRecordResponse> fileRecords;

  @override
  State<ListFile> createState() => _ListFileState();
}

class _ListFileState extends State<ListFile> {
  Offset _tapPosition = Offset.zero;
  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _showMenu(String? url, String fileName, String? patientRecordId) {
    var overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      shadowColor: black26,
      color: white,
      surfaceTintColor: white,
      items: [
        PopupMenuItem(
          onTap: url != null
              ? () async => _openFile(url, fileName)
              : () =>
                  EasyLoading.showToast(translate(context, 'cant_download')),
          child: Text(
            translate(context, 'open'),
          ),
        ),
        PopupMenuItem(
          onTap: patientRecordId != null
              ? () => context
                  .read<PatientRecordCubit>()
                  .deletePatientRecord(patientRecordId)
              : null,
          child: Text(
            translate(context, 'delete'),
          ),
        ),
      ],
      position: RelativeRect.fromRect(
          _tapPosition & const Size(40, 40), // smaller rect, the touch area
          Offset.zero & overlay.size // Bigger rect, the entire screen
          ),
    );
  }

  Future<void> _openFile(String url, String fileName) async {
    if (Platform.isAndroid) {

      var status1 = await Permission.storage.status;
      var status2 = await Permission.photos.status;
      if (!status1.isGranted && !status2.isGranted) {
        await Permission.storage.request();
        await Permission.photos.request();
      } else {
        if (!mounted) return;
        context
            .read<PatientRecordCubit>()
            .openFile(url: url, fileName: fileName);
      }
    } else if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (!status.isGranted) {
        await Permission.photos.request();
      } else {
        if (!mounted) return;
        context
            .read<PatientRecordCubit>()
            .openFile(url: url, fileName: fileName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.fileRecords.map(
      (e) {
        String fileName = e.record?.split('/').last ?? 'undefine';
        String type = fileName.split('.').last.toLowerCase();
        DateTime updateAt =
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(e.updateAt!);
        String? url;
        if (['pdf', 'gif', 'jpeg', 'jpg', 'png'].contains(type)) {
          url = CloudinaryContext.cloudinary
              .image('${Uri.encodeFull(e.record!)}.$type')
              .toString();
        } else if (['doc', 'docx', 'xls', 'xlsx', 'csv', 'pps', 'ppt', 'pptx']
            .contains(type)) {
          url = e.record != null
              ? CloudinaryContext.cloudinary
                  .raw(Uri.encodeFull(e.record!))
                  .toString()
              : null;
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
        ].contains(type)) {
          url = e.record != null
              ? CloudinaryContext.cloudinary
                  .video(Uri.encodeFull('${e.record!}.$type'))
                  .toString()
              : null;
        }

        return InkWell(
          onLongPress: () async => _showMenu(url, fileName, e.id),
          borderRadius: BorderRadius.circular(dimensWidth()),
          child: GestureDetector(
            onTapDown: _storePosition,
            onTap: url != null
                ? () async => _openFile(url!, fileName)
                : () =>
                    EasyLoading.showToast(translate(context, 'cant_download')),
            child: FileWidget(
              extension: type,
              title: fileName,
              updateAt: formatFileDate(context, updateAt),
              size: e.size,
            ),
          ),
        );
      },
    ).toList());
  }
}
