// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_prescription/prescription_cubit.dart';
import 'package:healthline/data/api/models/responses/prescription_response.dart';
import 'package:healthline/screen/prescription/components/export.dart';
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

  Future<dynamic> showDetailDrug(BuildContext context,
      {required DrugModal drug}) async {
    context.read<PrescriptionCubit>().getInfoDrug(id: drug.code!);
    final prescriptionCubit = context.read<PrescriptionCubit>();
    return await showDialog(
      barrierColor: white.withOpacity(.9),
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: transparent,
        elevation: 0,
        iconPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: FaIcon(
              FontAwesomeIcons.circleXmark,
              color: secondary,
              size: dimensIcon(),
            ),
          )
        ],
        content: SingleChildScrollView(
          child: BlocProvider.value(
            value: prescriptionCubit,
            child: Container(
              color: transparent,
              width: MediaQuery.of(context).size.width - dimensWidth() * 5,
              child: ListBody(
                children: [
                  DrugCardTop(
                    widget: ContentDrug(
                      drugModal: drug,
                      index: null,
                    ),
                  ),
                  DrugCardBottom(
                    widget: BlocBuilder<PrescriptionCubit, PrescriptionState>(
                      bloc: prescriptionCubit,
                      builder: (context, state) {
                        if (state is GetInfoDrugState) {
                          if (state.blocState == BlocState.Successed &&
                              state.data != null) {
                            List<String> hoatChat =
                                state.data!.hoatChat?.split(";") ?? [];
                            List<String>? nongDo =
                                state.data!.nongDo?.split(";") ?? [];

                            String x = "";
                            for (int i = 0; i < hoatChat.length; i++) {
                              if (i < nongDo.length) {
                                x +=
                                    ("${hoatChat[i].trim()}-${nongDo[i].trim()};");
                              }
                            }

                            return ListBody(
                              children: [
                                Row(
                                  children: [
                                    Text("${translate(context, "drug_name")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.tenThuoc ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Số quyết định")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.soQuyetDinh ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Ngày phê duyệt")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.pheDuyet ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Hoạt chât - nồng độ")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(x,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("${translate(context, "Tá dược")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.taDuoc ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Dạng bào chế")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.baoChe ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("${translate(context, "Đóng gói")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.dongGoi ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Tiêu chuẩn")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.tieuChuan ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("${translate(context, "Tuổi thọ")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.tuoiTho ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Công ty sản xuất")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.congTySx ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Quốc gia sản xuất")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.nuocSx ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Quốc gia sản xuất")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.nuocSx ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Nhóm thuốct")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.diaChiSx ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                        "${translate(context, "Quốc gia sản xuất")}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: white)),
                                    Expanded(
                                      child: Text(
                                          state.data?.nhomThuoc ??
                                              translate(context, 'empty'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(color: white)),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        }
                        return Center(
                          child: Text(
                            translate(context, "detail"),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: white),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
        try {
          if (state is FetchDetatilDoctorConsultationState &&
              state.blocState == BlocState.Successed &&
              state.detailDoctorConsultation != null) {
            if (state.detailDoctorConsultation?.medical?.avatar != null &&
                state.detailDoctorConsultation?.medical?.avatar != 'default' &&
                state.detailDoctorConsultation?.medical?.avatar != '') {
              imagePatient = imagePatient ??
                  NetworkImage(
                    CloudinaryContext.cloudinary
                        .image(
                            state.detailDoctorConsultation?.medical?.avatar ??
                                '')
                        .toString(),
                  );
            } else {
              imagePatient = AssetImage(DImages.placeholder);
            }
          }
        } catch (e) {
          logPrint(e);
          imagePatient = AssetImage(DImages.placeholder);
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          backgroundColor: white,
          appBar: AppBar(
            surfaceTintColor: transparent,
            scrolledUnderElevation: 0,
            backgroundColor: white,
            title: Text(
              "${state is FetchDetatilDoctorConsultationState && state.blocState == BlocState.Successed && state.detailDoctorConsultation != null ? state.detailDoctorConsultation?.medical?.fullName : translate(context, 'medical_examination_history')}",
            ),
            centerTitle: false,
          ),
          body: state is FetchDetatilDoctorConsultationState &&
                  state.blocState == BlocState.Successed &&
                  state.detailDoctorConsultation != null
              ? ListView(
                  shrinkWrap: false,
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensWidth() * 3,
                      vertical: dimensHeight() * 2),
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: dimensHeight() * 2),
                      width: double.infinity,
                      child: Text(
                        formatFullDate(
                            context,
                            convertStringToDateTime(
                                widget.consultation?.date)!),
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
                              if (widget.consultation?.doctor?.gender != null)
                                Row(children: [
                                  Text(
                                    "${translate(context, 'gender')}: ",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: color1F1F1F),
                                  ),
                                  Text(
                                    "${widget.consultation?.doctor?.gender}",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: color1F1F1F),
                                  ),
                                ]),
                              if (widget.consultation?.doctor?.email != null)
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "${widget.consultation?.doctor?.email}",
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
                                  imagePatient =
                                      AssetImage(DImages.placeholder);
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
                                  state.detailDoctorConsultation?.medical
                                          ?.fullName ??
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
                              Row(children: [
                                Text(
                                  "${translate(context, 'gender')}: ",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: color1F1F1F),
                                ),
                                Text(
                                  "${state.detailDoctorConsultation?.medical?.gender}",
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: color1F1F1F),
                                ),
                              ]),
                              if (state.detailDoctorConsultation?.medical
                                      ?.dateOfBirth !=
                                  null)
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    formatDayMonthYear(
                                        context,
                                        convertStringToDateTime(state
                                            .detailDoctorConsultation!
                                            .medical!
                                            .dateOfBirth!)!),
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                    if (state.detailDoctorConsultation?.patientRecords !=
                        null) ...[
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
                          String fileName =
                              e.record?.split('/').last ?? 'undefine';
                          String type = fileName.split('.').last.toLowerCase();
                          DateTime updateAt =
                              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                  .parse(e.updateAt!);
                          String? url;
                          if (['pdf', 'gif', 'jpeg', 'jpg', 'png']
                              .contains(type)) {
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
                    const Divider(
                      thickness: 1,
                      color: Colors.black26,
                    ),
                    if (state.detailDoctorConsultation?.feedback?.rated !=
                            null &&
                        state.detailDoctorConsultation?.feedback?.feedback !=
                            null) ...[
                      Padding(
                        padding: EdgeInsets.only(
                            top: dimensHeight() * 3, bottom: dimensHeight()),
                        child: Text(
                          translate(context, 'feedback'),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: (state.detailDoctorConsultation
                                        ?.feedback?.rated ??
                                    0)
                                .toDouble(),
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: dimensWidth() * 1.5,
                            itemBuilder: (context, _) => const FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (double value) {},
                          ),
                          Text(
                            " (${state.detailDoctorConsultation?.feedback?.rated?.toStringAsFixed(1) ?? 0})",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Text(
                        state.detailDoctorConsultation?.feedback?.feedback ??
                            "",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.black26,
                      ),
                    ],
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${translate(context, "prescription_code")}: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontStyle: FontStyle.italic),
                        ),
                        Expanded(
                          child: Text(
                            widget.consultation?.prescription?.id ??
                                translate(context, 'undifine'),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${translate(context, "created_at")}: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontStyle: FontStyle.italic),
                        ),
                        Expanded(
                          child: Text(
                            formatDayMonthYear(
                                context,
                                convertStringToDateTime(widget.consultation
                                        ?.prescription?.createdAt) ??
                                    DateTime.now()),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: dimensHeight() * 2,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${translate(context, "diagnosis")}: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontStyle: FontStyle.italic),
                        ),
                        Expanded(
                          child: Text(
                            widget.consultation?.prescription?.diagnosis ?? "",
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: black26,
                      height: dimensHeight() * 5,
                    ),
                    if (widget.consultation?.prescription != null)
                      ...widget.consultation!.prescription!.drugs!.map(
                        (e) {
                          if (widget
                                  .consultation?.prescription!.drugs?.length ==
                              1) {
                            return InkWell(
                              onTap: () async {
                                if (e.code != null) {
                                  await showDetailDrug(context, drug: e);
                                }
                              },
                              child: DrugCardNone(
                                  widget: ContentDrug(
                                index: 1,
                                drugModal: e,
                              )),
                            );
                          }
                          int index = widget.consultation!.prescription!.drugs!
                                  .indexWhere(
                                      (element) => element.code == e.code) +
                              1;
                          if (widget.consultation?.prescription?.drugs?.first ==
                              e) {
                            return InkWell(
                              onTap: () async {
                                if (e.code != null) {
                                  await showDetailDrug(context, drug: e);
                                }
                              },
                              child: DrugCardTop(
                                  widget: ContentDrug(
                                index: index,
                                drugModal: e,
                              )),
                            );
                          } else if (widget
                                  .consultation?.prescription?.drugs?.last ==
                              e) {
                            return InkWell(
                              onTap: () async {
                                if (e.code != null) {
                                  await showDetailDrug(context, drug: e);
                                }
                              },
                              child: DrugCardBottom(
                                  widget: ContentDrug(
                                index: index,
                                drugModal: e,
                              )),
                            );
                          }
                          return InkWell(
                            onTap: () async {
                              if (e.code != null) {
                                await showDetailDrug(context, drug: e);
                              }
                            },
                            child: DrugCardMid(
                                widget: ContentDrug(
                              index: index,
                              drugModal: e,
                            )),
                          );
                        },
                      ),
                    // DrugCardTop(),
                    // DrugCardMid(),
                    // DrugCardBottom(),
                    SizedBox(
                      height: dimensHeight() * 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${translate(context, "notice")}: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontStyle: FontStyle.italic),
                        ),
                        Expanded(
                          child: Text(
                            widget.consultation?.prescription?.notice ??
                                translate(context, 'empty'),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        )
                      ],
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
