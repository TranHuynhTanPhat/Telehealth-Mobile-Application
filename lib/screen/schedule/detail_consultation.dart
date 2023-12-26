// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:open_document/open_document.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:healthline/app/app_controller.dart';
import 'package:healthline/app/jitsi_service.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_patient_record/patient_record_cubit.dart';
import 'package:healthline/data/api/models/responses/consultaion_response.dart';
import 'package:healthline/screen/widgets/file_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/string_extensions.dart';
import 'package:healthline/utils/time_util.dart';

import '../../res/style.dart';
import '../../utils/log_data.dart';
import '../../utils/translate.dart';

class DetailConsultationScreen extends StatefulWidget {
  const DetailConsultationScreen({super.key, this.args});

  final String? args;

  @override
  State<DetailConsultationScreen> createState() =>
      _DetailConsultationScreenState();
}

class _DetailConsultationScreenState extends State<DetailConsultationScreen> {
  ConsultationResponse? consultation;
  var imageDoctor;
  var imagePatient;
  List<int> time = [];

  Future<void> _openFile(String url, String fileName) async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
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
    if (widget.args == null) {
      EasyLoading.showToast(translate(context, 'cant_load_data'));
      Navigator.pop(context);
    } else {
      try {
        consultation = ConsultationResponse.fromJson(widget.args!);
        if (AppController().authState == AuthState.DoctorAuthorized) {
          context.read<ConsultationCubit>().fetchDetatilDoctorConsultation(
              consultationId: consultation!.id!);
        }
      } catch (e) {
        logPrint(e);
        Navigator.pop(context);
      }
      try {
        if (consultation?.doctor?.avatar != null &&
            consultation?.doctor?.avatar != 'default' &&
            consultation?.doctor?.avatar != '') {
          imageDoctor = imageDoctor ??
              NetworkImage(
                CloudinaryContext.cloudinary
                    .image(consultation?.doctor?.avatar ?? '')
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
        if (consultation?.medical?.avatar != null &&
            consultation?.medical?.avatar != 'default' &&
            consultation?.medical?.avatar != '') {
          imagePatient = imagePatient ??
              NetworkImage(
                CloudinaryContext.cloudinary
                    .image(consultation?.medical?.avatar ?? '')
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
        time = consultation?.expectedTime
                ?.split('-')
                .map((e) => int.parse(e))
                .toList() ??
            [int.parse(consultation!.expectedTime!)];
      } catch (e) {
        logPrint(e);
      }
      String expectedTime =
          '${convertIntToTime(time.first - 1)} - ${convertIntToTime(time.last)}';

      return BlocListener<PatientRecordCubit, PatientRecordState>(
        listener: (context, state) async {
          if (state is OpenFileLoading) {
            EasyLoading.show(maskType: EasyLoadingMaskType.black);
          } else if (state is OpenFileLoaded) {
            EasyLoading.dismiss();
            await OpenDocument.openDocument(filePath: state.filePath);
          } else if (state is AddPatientRecordLoaded ||
              state is DeletePatientRecordLoaded) {
            EasyLoading.showToast(translate(context, 'successfully'));
          } else if (state is OpenFileError) {
            EasyLoading.showToast(translate(context, 'cant_download'));
            if (!await launchUrl(Uri.parse(state.url))) {
              if (!mounted) return;
              EasyLoading.showToast(translate(context, 'cant_open'));
            }
          } else if (state is AddPatientRecordError) {
            EasyLoading.showToast(translate(context, state.message));
          } else if (state is DeletePatientRecordError) {
            EasyLoading.showToast(translate(context, state.message));
          }
        },
        child: BlocBuilder<ConsultationCubit, ConsultationState>(
          builder: (context, state) {
            return Scaffold(
                resizeToAvoidBottomInset: true,
                extendBody: true,
                backgroundColor: white,
                appBar: AppBar(
                  title: Text(
                    translate(context, 'appointment'),
                  ),
                ),
                bottomNavigationBar: AbsorbPointer(
                  absorbing: state.blocState == BlocState.Pending,
                  child: consultation?.status == 'confirmed'
                      ? Container(
                          padding: EdgeInsets.fromLTRB(dimensWidth() * 3, 0,
                              dimensWidth() * 3, dimensHeight() * 3),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white.withOpacity(0.0), white],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const FaIcon(FontAwesomeIcons.video),
                            label: Text(translate(context, 'join_now')),
                            style: ButtonStyle(
                              foregroundColor:
                                  const MaterialStatePropertyAll(white),
                              textStyle: MaterialStatePropertyAll(
                                  Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(color: white)),
                              padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: dimensHeight() * 2,
                                    horizontal: dimensWidth() * 2.5),
                              ),
                              backgroundColor:
                                  const MaterialStatePropertyAll(primary),
                            ),
                            onPressed: () async {
                              if (consultation?.jistiToken != null) {
                                await JitsiService.instance.join(
                                  token: consultation!.jistiToken!,
                                  // token:
                                  //     "eyJraWQiOiJ2cGFhcy1tYWdpYy1jb29raWUtZmQwNzQ0ODk0ZjE5NGYzZWE3NDg4ODRmODNjZWMxOTUvMzNhNzE4LVNBTVBMRV9BUFAiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJqaXRzaSIsImlzcyI6ImNoYXQiLCJpYXQiOjE3MDM1MjcxOTQsImV4cCI6MTcwMzUzNDM5NCwibmJmIjoxNzAzNTI3MTg5LCJzdWIiOiJ2cGFhcy1tYWdpYy1jb29raWUtZmQwNzQ0ODk0ZjE5NGYzZWE3NDg4ODRmODNjZWMxOTUiLCJjb250ZXh0Ijp7ImZlYXR1cmVzIjp7ImxpdmVzdHJlYW1pbmciOmZhbHNlLCJvdXRib3VuZC1jYWxsIjpmYWxzZSwic2lwLW91dGJvdW5kLWNhbGwiOmZhbHNlLCJ0cmFuc2NyaXB0aW9uIjpmYWxzZSwicmVjb3JkaW5nIjp0cnVlfSwidXNlciI6eyJoaWRkZW4tZnJvbS1yZWNvcmRlciI6ZmFsc2UsIm1vZGVyYXRvciI6dHJ1ZSwibmFtZSI6ImhlYWx0aGxpbmVtYW5hZ2VyMjAyMyIsImlkIjoiZ29vZ2xlLW9hdXRoMnwxMDU2NjI0NTIyMjQxNTUyNTc1MTQiLCJhdmF0YXIiOiIiLCJlbWFpbCI6ImhlYWx0aGxpbmVtYW5hZ2VyMjAyM0BnbWFpbC5jb20ifX0sInJvb20iOiIqIn0.YWwmM6uribUGzj-diw56NjjOfnJSVySbrCDlowcPWvABzd5fWjcJud6cJhBgSXIBD1Mv6vRNvRvs9jXeUaZCnE16rzAJh3BNi0Zdq4PUfETMe9P_mtAnnulPEwapRX7lWJZbJ4blZUFKdc_F3vrq5NQpD0IViRY_qMrhAs_CUl3WeUvA62l2fbYqVpWO2qybMDdapMF-F3y7F0QyatMt2RNFNK_RqI3xSgTaKZGzTE7Lu7eOc3_fDXcnLLxd8C9A0zj-9K_c0iC_ehYrZsViBFb42ZHkDkUQrNu3R2EQdTJsbeuweIDtw94ieW8dJi8mUuYRcROPeowXBKyfqg7O6Q",
                                  roomName:
                                      "${dotenv.get('ROOM_JITSI', fallback: '')}/${consultation!.id!}",
                                  // roomName:
                                  //     "${dotenv.get('ROOM_JITSI', fallback: '')}/4d_9A_4dk6aj2s5Rgye1Z",
                                  displayName:
                                      consultation?.medical?.fullName ??
                                          translate(context, 'undefine'),
                                  urlAvatar: CloudinaryContext.cloudinary
                                      .image(consultation?.doctor?.avatar ?? '')
                                      .toString(),
                                  email: consultation?.medical?.email ?? '',
                                );
                              } else {
                                EasyLoading.showToast(
                                    translate(context, 'cant_load_data'));
                              }
                              // showBottomSheetFeedback(context);
                            },
                          ),
                        )
                      : AppController().authState == AuthState.DoctorAuthorized
                          ? Container(
                              padding: EdgeInsets.fromLTRB(dimensWidth() * 3, 0,
                                  dimensWidth() * 3, dimensHeight() * 3),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.0),
                                    white
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      const MaterialStatePropertyAll(white),
                                  textStyle: MaterialStatePropertyAll(
                                      Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(color: white)),
                                  padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: dimensHeight() * 2,
                                        horizontal: dimensWidth() * 2.5),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          color1C6AA3),
                                ),
                                onPressed: () {
                                  try {
                                    context
                                        .read<ConsultationCubit>()
                                        .confirmConsultation(
                                            consultationId: consultation!.id!);
                                  } catch (e) {
                                    EasyLoading.showToast(
                                        translate(context, 'cant_load_data'));
                                  }
                                },
                                child: Text(
                                    translate(context, 'confirm').capitalize()),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.fromLTRB(dimensWidth() * 3, 0,
                                  dimensWidth() * 3, dimensHeight() * 3),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.0),
                                    white
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      const MaterialStatePropertyAll(white),
                                  textStyle: MaterialStatePropertyAll(
                                      Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(color: white)),
                                  padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: dimensHeight() * 2,
                                        horizontal: dimensWidth() * 2.5),
                                  ),
                                  backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.redAccent),
                                ),
                                onPressed: () {
                                  try {
                                    context
                                        .read<ConsultationCubit>()
                                        .cancelConsultation(
                                            consultationId: consultation!.id!);
                                  } catch (e) {
                                    EasyLoading.showToast(
                                        translate(context, 'cant_load_data'));
                                  }
                                },
                                child: Text(
                                    translate(context, 'cancel').capitalize()),
                              ),
                            ),
                ),
                body: ListView(
                  // shrinkWrap: true,
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
                            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                .parse(consultation!.date!)),
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
                                translate(context, consultation?.status),
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
                              consultation?.status == 'confirmed'
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
                                  consultation?.doctor?.fullName ??
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
                                      consultation?.doctor?.specialty ??
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
                                  consultation?.medical?.fullName ??
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
                            String type =
                                fileName.split('.').last.toLowerCase();
                            DateTime updateAt =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                    .parse(e.updateAt!);
                            String? url;
                            if (['pdf', 'gif', 'jpeg', 'jpg', 'png']
                                .contains(type)) {
                              url = CloudinaryContext.cloudinary
                                  .image('${Uri.encodeFull(e.record!)}.$type')
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
                                      .video(
                                          Uri.encodeFull('${e.record!}.$type'))
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
                        ).toList()
                      ]
                    ],
                  ],
                ));
          },
        ),
      );
    }
    return const SizedBox();
  }
}
