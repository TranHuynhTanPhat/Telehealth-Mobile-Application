import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/main/health_info/patient_record/components/export.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';

class ListFolder extends StatefulWidget {
  const ListFolder({super.key, required this.fileByFolders});
  final Map<String, Map<String, dynamic>> fileByFolders;

  @override
  State<ListFolder> createState() => _ListFolderState();
}

class _ListFolderState extends State<ListFolder> {
  Offset _tapPosition = Offset.zero;
  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _showMenu(String folderName) {
    var overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      shadowColor: black26,
      color: white,
      surfaceTintColor: white,
      items: [
        PopupMenuItem(
          onTap: () async => _openFolder(folderName),
          child: Text(
            translate(context, 'open'),
          ),
        ),
        PopupMenuItem(
          onTap: () => context
              .read<PatientRecordCubit>()
              .deleteFolderPatient(folderName),
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

  Future<void> _openFolder(String folderName) async {
    PatientRecordCubit patientRecordCubit = context.read<PatientRecordCubit>();
    MedicalRecordCubit medicalRecordCubit = context.read<MedicalRecordCubit>();
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
            folderName: folderName,
          ),
        ),
      ),
    );
    // if (Platform.isAndroid) {
    //   var status = await Permission.storage.status;
    //   if (!status.isGranted) {
    //     await Permission.storage.request();
    //   } else {
    //     if (!mounted) return;
    //     context
    //         .read<PatientRecordCubit>()
    //         .openFile(url: url, fileName: fileName);
    //   }
    // } else if (Platform.isIOS) {
    //   var status = await Permission.photos.status;
    //   if (!status.isGranted) {
    //     await Permission.photos.request();
    //   } else {
    //     if (!mounted) return;
    //     context
    //         .read<PatientRecordCubit>()
    //         .openFile(url: url, fileName: fileName);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.fileByFolders.entries
          .map(
            (mapEntry) => Column(
              children: [
                InkWell(
                  onLongPress: () async => _showMenu(
                    mapEntry.key,
                  ),
                  borderRadius: BorderRadius.circular(dimensWidth()),
                  child: GestureDetector(
                    onTapDown: _storePosition,
                    onTap: () async => _openFolder(mapEntry.key),
                    child: ListTile(
                        onTap: null,
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
                                style: Theme.of(context).textTheme.labelLarge,
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
                  ),
                ),
                const Divider(),
              ],
            ),
          )
          .toList(),
    );
  }
}
