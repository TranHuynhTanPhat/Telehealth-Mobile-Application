import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_patient_record/patient_record_cubit.dart';
import 'package:healthline/data/api/models/responses/consultation_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/file_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';

class DetailHistoryConsultationScreen extends StatefulWidget {
  const DetailHistoryConsultationScreen(
      {super.key, required this.consultation});
  final ConsultationResponse? consultation;

  @override
  State<DetailHistoryConsultationScreen> createState() =>
      _DetailHistoryConsultationScreenState();
}

class _DetailHistoryConsultationScreenState
    extends State<DetailHistoryConsultationScreen> {
  var imageDoctor;
  var imagePatient;
  List<int> time = [];

  Future<void> _openFile(String url, String fileName) async {
    if (Platform.isAndroid) {
      var status1 = await Permission.storage.status;
      var status2 = await Permission.mediaLibrary.status;
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
  void initState() {
    if (!mounted) return;
    if (widget.consultation == null) return;
    try {
      context.read<ConsultationCubit>().fetchDetailDoctorConsultation(
          consultationId: widget.consultation!.id!);
    } catch (e) {
      logPrint(e);
      Navigator.pop(context);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (widget.consultation?.doctor?.avatar != null &&
          widget.consultation?.doctor?.avatar != 'default' &&
          widget.consultation?.doctor?.avatar != '') {
        imageDoctor = imageDoctor ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget.consultation?.doctor?.avatar ?? '')
                  .toString(),
            );
      } else {
        imageDoctor = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      imageDoctor = AssetImage(DImages.placeholder);
    }
    try {
      if (widget.consultation?.medical?.avatar != null &&
          widget.consultation?.medical?.avatar != 'default' &&
          widget.consultation?.medical?.avatar != '') {
        imagePatient = imagePatient ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget.consultation?.medical?.avatar ?? '')
                  .toString(),
            );
      } else {
        imagePatient = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      imagePatient = AssetImage(DImages.placeholder);
    }
    try {
      time = widget.consultation?.expectedTime
              ?.split('-')
              .map((e) => int.parse(e))
              .toList() ??
          [int.parse(widget.consultation!.expectedTime!)];
    } catch (e) {
      logPrint(e);
    }
    String expectedTime =
        '${convertIntToTime(time.first)} - ${convertIntToTime(time.last + 1)}';

    return BlocBuilder<ConsultationCubit, ConsultationState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          backgroundColor: white,
          appBar: AppBar(
            surfaceTintColor: transparent,
            scrolledUnderElevation: 0,
            backgroundColor: white,
            title: Text(
              "state.",
            ),
            centerTitle: false,
          ),
          body: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 3,
            ),
            children: [
              Container(
                padding: EdgeInsets.only(bottom: dimensHeight() * 2),
                width: double.infinity,
                child: Text(
                  formatFullDate(context,
                      convertStringToDateTime(widget.consultation?.date)!),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: color1F1F1F, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: dimensHeight() * 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.clock,
                          color: color1F1F1F,
                          size: dimensWidth() * 2,
                        ),
                        SizedBox(
                          width: dimensWidth(),
                        ),
                        Text(
                          expectedTime,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: color1F1F1F,
                                  fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate(context, widget.consultation?.status),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: color1F1F1F,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: dimensWidth(),
                        ),
                        widget.consultation?.status == 'confirmed'
                            ? FaIcon(
                                FontAwesomeIcons.check,
                                color: color1F1F1F,
                                size: dimensWidth() * 2,
                              )
                            : FaIcon(
                                FontAwesomeIcons.arrowsRotate,
                                color: color1F1F1F,
                                size: dimensWidth() * 2,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    translate(context, 'doctor'),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: black26),
                  ),
                  Expanded(
                    child: Text(
                      ' ---------------------------------------------------',
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: black26),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: dimensImage() * 7,
                    height: dimensImage() * 7,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          100,
                        ),
                      ),
                      image: DecorationImage(
                        image: imageDoctor,
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          logPrint(exception);
                          setState(() {
                            imageDoctor = AssetImage(DImages.placeholder);
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: dimensWidth() * 2,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            widget.consultation?.doctor?.fullName ??
                                translate(context, 'undefine'),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    color: color1F1F1F,
                                    fontWeight: FontWeight.w900),
                          ),
                        ),
                        if (widget.consultation?.doctor?.specialties != null &&
                            widget
                                .consultation!.doctor!.specialties!.isNotEmpty)
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              translate(
                                  context,
                                  widget.consultation?.doctor!.specialties!
                                          .firstOrNull?.specialty ??
                                      widget.consultation?.doctor!.careers!
                                          .firstOrNull?.medicalInstitute ??
                                      'undefine'),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: color1F1F1F),
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: dimensHeight() * 3,
              ),
              Row(
                children: [
                  Text(
                    translate(context, 'patient'),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: black26),
                  ),
                  Expanded(
                    child: Text(
                      ' ---------------------------------------------------',
                      maxLines: 1,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: black26),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: dimensImage() * 7,
                    height: dimensImage() * 7,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          100,
                        ),
                      ),
                      image: DecorationImage(
                        image: imagePatient,
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          logPrint(exception);
                          setState(() {
                            imagePatient = AssetImage(DImages.placeholder);
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: dimensWidth() * 2,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            widget.consultation?.medical?.fullName ??
                                translate(context, 'undefine'),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                    color: color1F1F1F,
                                    fontWeight: FontWeight.w900),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            translate(
                                context,
                                widget.consultation?.medical?.gender ??
                                    'undefine'),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        if (widget.consultation?.medical?.dateOfBirth != null)
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              formatDayMonthYear(
                                  context,
                                  convertStringToDateTime(widget
                                      .consultation!.medical!.dateOfBirth!)!),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: dimensHeight() * 2,
              ),
              if (state is FetchDetatilDoctorConsultationState &&
                  state.blocState == BlocState.Successed &&
                  state.detailDoctorConsultation != null) ...[
                Row(children: [
                  Text(
                    '${translate(context, 'symptoms')}: ',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Expanded(
                    child: Text(
                        state.detailDoctorConsultation?.symptoms ??
                            translate(context, 'empty'),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium),
                  )
                ]),
                Row(children: [
                  Text("${translate(context, 'medical_history')}: ",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge),
                  Expanded(
                    child: Text(
                        state.detailDoctorConsultation?.medicalHistory ??
                            translate(context, 'empty'),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium),
                  )
                ]),
                if (state.detailDoctorConsultation?.patientRecords != null) ...[
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      translate(context, 'patient_records'),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  ...state.detailDoctorConsultation!.patientRecords!.map(
                    (e) {
                      String fileName = e.record?.split('/').last ?? 'undefine';
                      String type = fileName.split('.').last.toLowerCase();
                      DateTime updateAt =
                          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                              .parse(e.updateAt!);
                      String? url;
                      if (['pdf', 'gif', 'jpeg', 'jpg', 'png'].contains(type)) {
                        url = CloudinaryContext.cloudinary
                            .image('${Uri.encodeFull(e.record!)}.')
                            .toString();
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
                                .video(Uri.encodeFull('${e.record!}.'))
                                .toString()
                            : null;
                      }

                      return FileWidget(
                        onTap: url != null
                            ? () async => _openFile(url!, fileName)
                            : () => EasyLoading.showToast(
                                translate(context, 'cant_download')),
                        extension: type,
                        title: fileName,
                        updateAt: formatFileDate(context, updateAt),
                        size: e.size,
                      );
                    },
                  )
                ],
              ],
              const Divider(
                thickness: 1,
                color: Colors.black26,
              ),
            ],
          ),
        );
      },
    );
  }
}
