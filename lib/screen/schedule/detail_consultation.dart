// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/data/api/models/responses/prescription_response.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:intl/intl.dart';
import 'package:open_document/open_document.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:healthline/app/app_controller.dart';
import 'package:healthline/app/jitsi_service.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_patient_record/patient_record_cubit.dart';
import 'package:healthline/data/api/models/responses/consultation_response.dart';
import 'package:healthline/routes/app_pages.dart';
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
    if (widget.args == null) {
      EasyLoading.showToast(translate(context, 'cant_load_data'));
      return;
    }
    try {
      consultation = ConsultationResponse.fromJson(widget.args!);
      if (AppController().authState == AuthState.DoctorAuthorized) {
        context
            .read<ConsultationCubit>()
            .fetchDetailDoctorConsultation(consultationId: consultation!.id!);
      }
    } catch (e) {
      logPrint(e);
      Navigator.pop(context);
    }
    super.initState();
  }

  Future<bool?> showBottomSheetFeedback(BuildContext context,
      {required String feedbackId}) {
    double rating = 1;
    TextEditingController feedbackController = TextEditingController();

    return showModalBottomSheet<bool>(
      context: context,
      barrierColor: black26,
      elevation: 0,
      isScrollControlled: true,
      backgroundColor: transparent,
      builder: (BuildContext contextBottomSheet) {
        // print(context.read<ConsultationCubit>());
        ConsultationCubit consultationCubit = context.read<ConsultationCubit>();

        return BlocListener<ConsultationCubit, ConsultationState>(
          bloc: consultationCubit,
          listener: (context, state) {
            if (state is CreateFeebackState) {
              if (state.blocState == BlocState.Successed) {
                EasyLoading.showToast(translate(context, 'successfully'));
                Navigator.pop(context, true);
              } else if (state.blocState == BlocState.Failed) {
                EasyLoading.showToast(
                    translate(context, 'feedback should not be empty'));
              }
            }
          },
          child: BlocBuilder<ConsultationCubit, ConsultationState>(
            bloc: consultationCubit,
            builder: (context, state) {
              return AbsorbPointer(
                absorbing: state is CreateFeebackState &&
                    state.blocState == BlocState.Pending,
                child: GestureDetector(
                  onTap: () => KeyboardUtil.hideKeyboard(context),
                  child: Wrap(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(15, 0, 15,
                            20 + MediaQuery.of(context).viewInsets.bottom),
                        padding: EdgeInsets.symmetric(
                            horizontal: dimensWidth() * 3,
                            vertical: dimensHeight() * 3),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius:
                              BorderRadius.circular(dimensWidth() * 3),
                        ),
                        child: Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  translate(context, 'feedbacks'),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: dimensHeight()),
                                width: double.infinity,
                                child: TextFieldWidget(
                                  controller: feedbackController,
                                  textInputType: TextInputType.multiline,
                                  label: translate(context, 'feedbacks'),
                                  validate: (value) {
                                    if (feedbackController.text.trim().length <
                                        3) {
                                      return translate(
                                          context, 'least_3_characters_long');
                                    }
                                    if (feedbackController.text.trim().length >
                                        250) {
                                      return translate(context,
                                          'maximum_length_of_10_characters');
                                    }
                                    return null;
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  maxLine: 5,
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(top: dimensHeight() * 2),
                                alignment: Alignment.center,
                                width: double.infinity,
                                child: RatingBar.builder(
                                  ignoreGestures: false,
                                  initialRating: (rating).toDouble(),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemSize: dimensWidth() * 3,
                                  itemPadding: EdgeInsets.all(dimensWidth()),
                                  itemBuilder: (context, _) => const FaIcon(
                                    FontAwesomeIcons.solidStar,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (double value) {
                                    rating = value;
                                  },
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(top: dimensHeight() * 2),
                                width: double.infinity,
                                child: ElevatedButtonWidget(
                                  text: translate(context, 'send'),
                                  onPressed: () {
                                    consultationCubit.createFeedback(
                                      feedbackId: feedbackId,
                                      rating: (rating).toInt(),
                                      feedback: feedbackController.text.trim(),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        '${convertIntToTime(time.first)} - ${convertIntToTime(time.last + 1)}';

    return MultiBlocListener(
      listeners: [
        BlocListener<PatientRecordCubit, PatientRecordState>(
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
                // ignore: use_build_context_synchronously
                EasyLoading.showToast(translate(context, 'cant_open'));
              }
            } else if (state is AddPatientRecordError) {
              EasyLoading.showToast(translate(context, state.message));
            } else if (state is DeletePatientRecordError) {
              EasyLoading.showToast(translate(context, state.message));
            }
          },
        ),
        // BlocListener<ConsultationCubit, ConsultationState>(
        //   listener: (context, state) async {
        //     if (state is AnnounceBusyState) {
        //       if (state.blocState == BlocState.Pending) {
        //         EasyLoading.show(maskType: EasyLoadingMaskType.black);
        //       }
        //       else if (state.blocState == BlocState.Failed) {
        //         if(state is FetchPrescriptionState){
        //           EasyLoading.showToast(translate(context, "prescription_has_not_been_created_yet"));

        //         }else {
        //           EasyLoading.showToast(translate(context, state.error));
        //         }
        //       }
        //       else {
        //         EasyLoading.dismiss();
        //         Navigator.pop(context);
        //       }
        //     }
        //   },
        // )
      ],
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
                child: (consultation?.status == 'confirmed')
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
                                //     "eyJraWQiOiJ2cGFhcy1tYWdpYy1jb29raWUtZmQwNzQ0ODk0ZjE5NGYzZWE3NDg4ODRmODNjZWMxOTUvMzNhNzE4LVNBTVBMRV9BUFAiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJqaXRzaSIsImlzcyI6ImNoYXQiLCJpYXQiOjE3MDM4NzgxMTAsImV4cCI6MTcwMzg4NTMxMCwibmJmIjoxNzAzODc4MTA1LCJzdWIiOiJ2cGFhcy1tYWdpYy1jb29raWUtZmQwNzQ0ODk0ZjE5NGYzZWE3NDg4ODRmODNjZWMxOTUiLCJjb250ZXh0Ijp7ImZlYXR1cmVzIjp7ImxpdmVzdHJlYW1pbmciOnRydWUsIm91dGJvdW5kLWNhbGwiOnRydWUsInNpcC1vdXRib3VuZC1jYWxsIjpmYWxzZSwidHJhbnNjcmlwdGlvbiI6dHJ1ZSwicmVjb3JkaW5nIjp0cnVlfSwidXNlciI6eyJoaWRkZW4tZnJvbS1yZWNvcmRlciI6ZmFsc2UsIm1vZGVyYXRvciI6dHJ1ZSwibmFtZSI6ImhlYWx0aGxpbmVtYW5hZ2VyMjAyMyIsImlkIjoiZ29vZ2xlLW9hdXRoMnwxMDU2NjI0NTIyMjQxNTUyNTc1MTQiLCJhdmF0YXIiOiIiLCJlbWFpbCI6ImhlYWx0aGxpbmVtYW5hZ2VyMjAyM0BnbWFpbC5jb20ifX0sInJvb20iOiIqIn0.l4zgt_PgUGMEKinDgsSNM1ghgXQb1KoA5h9EqStDvU-_5yZcXBFpxoNrYdk_7TvEYWSEJjsFPNWF4soF0lKWF7skWSYoN0II3xVcJV8lidy3WfFwuxFVDew_fIDsy3kyKSOqbtbsSFOcZuBXhmgCbbOkLQ8wuwrVDq6dgpGEdXBFjkuGbIHG6e1GK34s-9qiUO3QsA7Rvq1dJXkPqBvuf6V8oTMs--pPBPdAnx5bmBb82DQ3BwnolOfuoDKPWXfNbRRsSupYDmnHBeTRGaXqTztkzuhiL_RDQf6BQOauE98sCFfHRkdiB5AMbxlBQxihRQJyjrJ7zhMgSHZJ6gtMxA",
                                roomName:
                                    "//${dotenv.get('ROOM_JITSI', fallback: '')}/${consultation!.id!}",
                                // roomName:
                                //     "${dotenv.get('ROOM_JITSI', fallback: '')}/4d_9A_4dk6aj2s5Rgye1Z",
                                displayName: consultation?.medical?.fullName ??
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
                    : (consultation?.status == "pending")
                        ? (AppController().authState ==
                                AuthState.DoctorAuthorized)
                            ? Container(
                                padding: EdgeInsets.fromLTRB(dimensWidth() * 3,
                                    0, dimensWidth() * 3, dimensHeight() * 3),
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
                                              consultationId:
                                                  consultation!.id!);
                                    } catch (e) {
                                      EasyLoading.showToast(
                                          translate(context, 'cant_load_data'));
                                    }
                                  },
                                  child: Text(translate(context, 'confirm')
                                      .capitalize()),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.fromLTRB(dimensWidth() * 3,
                                    0, dimensWidth() * 3, dimensHeight() * 3),
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
                                              consultationId:
                                                  consultation!.id!);
                                    } catch (e) {
                                      EasyLoading.showToast(
                                          translate(context, 'cant_load_data'));
                                    }
                                  },
                                  child: Text(translate(context, 'cancel')
                                      .capitalize()),
                                ),
                              )
                        : (consultation?.status == "finished")
                            ? (consultation?.feedback?.rated == null &&
                                    consultation?.feedback?.id != null &&
                                    AppController().authState ==
                                        AuthState.PatientAuthorized)
                                ? Container(
                                    padding: EdgeInsets.fromLTRB(
                                        dimensWidth() * 3,
                                        0,
                                        dimensWidth() * 3,
                                        dimensHeight() * 3),
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
                                    child: ElevatedButtonWidget(
                                      onPressed: () async {
                                        await showBottomSheetFeedback(context,
                                                feedbackId:
                                                    consultation!.feedback!.id!)
                                            .then((value) {
                                          if (value == true) {
                                            context
                                                .read<ConsultationCubit>()
                                                .fetchConsultation();
                                          }
                                        });
                                      },
                                      text: translate(context, 'feedback')
                                          .capitalize(),
                                    ),
                                  )
                                : const SizedBox.shrink()
                            : const SizedBox.shrink()),
            body: ListView(
              // shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
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
                          if (consultation!.doctor!.specialties!.isNotEmpty)
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                translate(
                                    context,
                                    consultation?.doctor!.specialties!
                                            .firstOrNull?.specialty ??
                                        consultation?.doctor!.careers!
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
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              translate(context,
                                  consultation?.medical?.gender ?? 'undefine'),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          if (consultation?.medical?.dateOfBirth != null)
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                formatDayMonthYear(
                                    context,
                                    convertStringToDateTime(
                                        consultation!.medical!.dateOfBirth!)!),
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
                ],
                const Divider(
                  thickness: 1,
                  color: Colors.black26,
                ),
                if (consultation?.status != "pending")
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, prescriptionName,
                              arguments: consultation?.id)
                          .then((value) {
                        if (value == addPrescriptionName &&
                            AppController().authState ==
                                AuthState.DoctorAuthorized) {
                          PrescriptionResponse prescriptionResponse =
                              PrescriptionResponse(
                            createdAt: DateTime.now().toIso8601String(),
                            patientName: consultation?.medical?.fullName,
                            patientAddress: consultation?.medical?.address,
                            gender: consultation?.medical?.gender,
                            doctorName: consultation?.doctor?.fullName,
                          );
                          Navigator.pushNamed(context, addPrescriptionName,
                              arguments: {
                                "prescriptionResponse": prescriptionResponse,
                                "consultationId": consultation?.id
                              });
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(dimensWidth()),
                    splashColor: secondary.withOpacity(.1),
                    highlightColor: secondary.withOpacity(.1),
                    overlayColor:
                        MaterialStatePropertyAll(secondary.withOpacity(.1)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: primary.withOpacity(.2),
                        borderRadius: BorderRadius.circular(dimensWidth() * 2),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 2,
                        vertical: dimensHeight() * 2,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.prescription,
                            size: dimensIcon() / 2,
                          ),
                          SizedBox(
                            width: dimensWidth(),
                          ),
                          Text(
                            translate(context, 'prescription'),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                if (consultation?.status == "confirmed" &&
                    AppController().authState == AuthState.PatientAuthorized)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: dimensWidth() * 15,
                        vertical: dimensHeight() * 2),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext contextBottomSheet) {
                            return AlertDialog(
                              title: const Text('Bạn muốn huỷ cuộc hẹn này?'),
                              content: const SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Bấm đồng ý để huỷ'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Đồng ý'),
                                  onPressed: () {
                                    context
                                        .read<ConsultationCubit>()
                                        .announceBusy(
                                            consultationId: consultation!.id!);
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: Text(translate(context, 'cancel')),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(dimensWidth()),
                            side: const BorderSide(
                              strokeAlign: 0.1,
                              color: black26,
                            ))),
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        foregroundColor: const MaterialStatePropertyAll(white),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered) ||
                                states.contains(MaterialState.pressed)) {
                              return white.withOpacity(.3); //<-- SEE HERE
                            }
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      child: Text(
                        translate(context, 'busy'),
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: black26),
                      ),
                    ),
                  ),
                if (consultation?.status == "finished" &&
                    consultation?.feedback?.rated != null &&
                    consultation?.feedback?.feedback != null) ...[
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
                        initialRating:
                            (consultation?.feedback?.rated ?? 0).toDouble(),
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
                        " (${consultation?.feedback?.rated?.toStringAsFixed(1) ?? 0})",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Text(
                    consultation?.feedback?.feedback ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
