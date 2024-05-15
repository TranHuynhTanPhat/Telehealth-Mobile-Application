// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/data/api/models/responses/doctor_detail_response.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/bases/base_gridview.dart';
import 'package:healthline/screen/ui_patient/main/home/doctor/subscreen/components/doctor_card.dart';

import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/shimmer_widget.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class DetailDoctorScreen extends StatefulWidget {
  const DetailDoctorScreen({
    super.key,
    this.args,
  });
  final DoctorDetailResponse? args;

  @override
  State<DetailDoctorScreen> createState() => _DetailDoctorScreenState();
}

class _DetailDoctorScreenState extends State<DetailDoctorScreen> {
  var _image;
  late DoctorDetailResponse doctor;
  bool marked = false;
  bool seeAll = false;
  List<FeedbackResponse> feedbacks = [];

  @override
  void initState() {
    _image = null;

    if (!mounted) return;
    if (widget.args == null) return;
    doctor = widget.args!;
    context
          .read<ConsultationCubit>()
          .fetchFeedbackDoctor(doctorId: doctor.id!);
    context.read<DoctorCubit>().getWishList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (doctor.avatar != null &&
          doctor.avatar != 'default' &&
          doctor.avatar != '') {
        _image = _image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(doctor.avatar ?? '')
                  .toString(),
            );
      } else {
        _image = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      _image = AssetImage(DImages.placeholder);
    }

    return BlocConsumer<DoctorCubit, DoctorState>(
      listener: (context, state) {
        if (state.blocState == BlocState.Successed) {
          EasyLoading.dismiss();
          setState(() {
            if (state.wishDoctors
                .where((element) => element.id == doctor.id)
                .isNotEmpty) {
              marked = true;
            } else {
              marked = false;
            }
          });
        } else if (state.blocState == BlocState.Pending) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
        } else {
          EasyLoading.dismiss();
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: white,
          extendBody: true,
          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(
                dimensWidth() * 3, 0, dimensWidth() * 3, dimensHeight() * 3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.0), white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            width: double.infinity,
            child: ElevatedButtonWidget(
              text: translate(context, 'book_appointment_now'),
              onPressed: () {
                if (doctor.id != null) {
                  DateTime dateTime = DateTime.now();
                  context.read<ConsultationCubit>().fetchTimeline(
                      doctorId: doctor.id!,
                      date:
                          '${dateTime.day + 1}/${dateTime.month}/${dateTime.year}');
                  Navigator.pushNamed(
                    context,
                    createConsultationName,
                    arguments: doctor.toJson(),
                  ).then((value) {
                    if (value == true) {
                      context.read<ConsultationCubit>().fetchConsultation();
                    }
                  });
                } else {
                  EasyLoading.showToast(translate(context, 'cant_load_data'));
                  Navigator.pop(context);
                }
              },
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                elevation: 0,
                snap: true,
                floating: true,
                stretch: true,
                pinned: true,
                backgroundColor: white,
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: Hero(
                    tag: doctor.id!,
                    transitionOnUserGestures: true,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: _image,
                          onError: (exception, stackTrace) => setState(() {
                            logPrint(exception);
                            _image = AssetImage(DImages.placeholder);
                          }),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(dimensHeight() * 7),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      dimensWidth() * 3,
                      dimensHeight(),
                      dimensWidth() * 3,
                      dimensHeight(),
                    ),
                    alignment: Alignment.bottomLeft,
                    width: double.infinity,
                    height: dimensHeight() * 7,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            white.withOpacity(0.0),
                            white.withOpacity(.3),
                            white.withOpacity(.6),
                            white.withOpacity(.9),
                            white,
                            white
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          tileMode: TileMode.clamp),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            doctor.fullName ?? translate(context, 'undefine'),
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "${convertToVND(doctor.feePerMinutes ?? 0)}/${translate(context, 'minute')}",
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: secondary),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: dimensWidth() * 3,
                              ),
                              child: Text(
                                translate(
                                    context,
                                    doctor.specialties!.firstOrNull
                                            ?.specialty ??
                                        doctor.careers!.firstOrNull?.position ??
                                        'undefine'),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: dimensWidth() * 3),
                          child: InkWell(
                            splashColor: transparent,
                            hoverColor: transparent,
                            highlightColor: transparent,
                            onTap: () async {
                              if (doctor.id == null) {
                                EasyLoading.showToast(
                                    translate(context, 'cant_be_done'));
                              } else {
                                await context
                                    .read<DoctorCubit>()
                                    .addWishList(doctorId: doctor.id!);
                                await context.read<DoctorCubit>().getWishList();
                                // setState(() {
                                //   marked = !marked;
                                // });
                              }
                            },
                            child: FaIcon(
                              marked
                                  ? FontAwesomeIcons.solidBookmark
                                  : FontAwesomeIcons.bookmark,
                              size: dimensIcon() * .8,
                              color: marked ? Colors.orangeAccent : null,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: dimensWidth() * 3, right: dimensWidth() * 3),
                      child: Text(
                        "${translate(context, 'medical_institution')}: ${doctor.careers!.firstOrNull?.medicalInstitute ?? translate(context, 'undefine')}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    // if (doctor.email != null)
                    //   Padding(
                    //     padding: EdgeInsets.only(
                    //         left: dimensWidth() * 3, right: dimensWidth() * 3),
                    //     child: Text(
                    //       "${translate(context, 'email')}: ${doctor.email}",
                    //       style: Theme.of(context).textTheme.bodyMedium,
                    //     ),
                    //   ),

                    Padding(
                      padding: EdgeInsets.only(
                          left: dimensWidth() * 3,
                          right: dimensWidth() * 3,
                          top: dimensHeight() * 3),
                      child: Text(
                        translate(context, 'biography'),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: dimensWidth() * 3,
                          right: dimensWidth() * 3,
                          bottom: dimensHeight() * 2),
                      child: ShowBiography(
                        biography:
                            doctor.biography ?? translate(context, 'empty'),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (doctor.educationAndCertifications != null &&
                            doctor.educationAndCertifications!.isNotEmpty) {
                          final consulationCubit =
                              context.read<ConsultationCubit>();
                          await showDialogEduAndEpx(context, consulationCubit);
                        }
                      },
                      splashColor: secondary.withOpacity(.1),
                      highlightColor: secondary.withOpacity(.1),
                      overlayColor:
                          MaterialStatePropertyAll(secondary.withOpacity(.1)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dimensWidth() * 3,
                          vertical: dimensHeight() * 2,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.stamp,
                              color: secondary,
                              size: dimensIcon() / 2,
                            ),
                            SizedBox(
                              width: dimensWidth(),
                            ),
                            Text(
                              translate(
                                  context, 'education_and_certifications'),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: secondary),
                            ),
                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () async {
                        if (doctor.educationAndCertifications != null &&
                            doctor.educationAndCertifications!.isNotEmpty) {
                          final consulationCubit =
                              context.read<ConsultationCubit>();
                          await showCareer(context, consulationCubit);
                        }
                      },
                      splashColor: secondary.withOpacity(.1),
                      highlightColor: secondary.withOpacity(.1),
                      overlayColor:
                          MaterialStatePropertyAll(secondary.withOpacity(.1)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: dimensWidth() * 3,
                          vertical: dimensHeight() * 2,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.userDoctor,
                              color: secondary,
                              size: dimensIcon() / 2,
                            ),
                            SizedBox(
                              width: dimensWidth(),
                            ),
                            Text(
                              translate(context, 'career'),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: secondary),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<ConsultationCubit, ConsultationState>(
                      builder: (context, state) {
                        feedbacks = state.feedbacks!;

                        feedbacks = feedbacks
                            .where((element) =>
                                element.rated != null && element.rated! > 0)
                            .toList();
                        feedbacks.sort((a, b) {
                          DateTime? aTime =
                              convertStringToDateTime(a.createdAt);
                          DateTime? bTime =
                              convertStringToDateTime(b.createdAt);
                          if (aTime != null && bTime != null) {
                            return aTime.compareTo(bTime);
                          } else {
                            return aTime == null ? -1 : 1;
                          }
                        });

                        feedbacks = feedbacks.reversed.toList();

                        return Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: dimensWidth() * 3),
                              shape: Border(
                                bottom: BorderSide(
                                    width: .5,
                                    color: secondary.withOpacity(.2)),
                                top: BorderSide(
                                    width: 15,
                                    color: secondary.withOpacity(.2)),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, feedbacksName,
                                    arguments: state.feedbacks);
                              },
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      translate(context, 'feedbacks'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                  Text(
                                    translate(context, 'see_all'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: secondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                              subtitle: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RatingBar.builder(
                                    ignoreGestures: true,
                                    initialRating: doctor.ratings ?? 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: dimensWidth() * 1.5,
                                    itemBuilder: (context, _) => const FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: Colors.orangeAccent,
                                    ),
                                    onRatingUpdate: (double value) {},
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: dimensWidth() / 2),
                                    child: Row(
                                      children: [
                                        Text(
                                          "${doctor.ratings?.toStringAsFixed(1) ?? 0}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        Text(
                                          " (${doctor.numberOfConsultation})",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if (feedbacks.isNotEmpty)
                              ...feedbacks
                                  .getRange(
                                      0,
                                      feedbacks.length > 5
                                          ? 5
                                          : feedbacks.length)
                                  .toList()
                                  .map(
                                (e) {
                                  // count++;
                                  var image;
                                  try {
                                    if (e.user?.avatar != null &&
                                        e.user?.avatar != 'default' &&
                                        e.user?.avatar != '') {
                                      image = image ??
                                          NetworkImage(
                                            CloudinaryContext.cloudinary
                                                .image(e.user?.avatar ?? '')
                                                .toString(),
                                          );
                                    } else {
                                      image = AssetImage(DImages.placeholder);
                                    }
                                  } catch (e) {
                                    logPrint(e);
                                    image = AssetImage(DImages.placeholder);
                                  }
                                  DateTime? createdAt =
                                      convertStringToDateTime(e.createdAt);
                                  return ListTile(
                                    shape: Border(
                                      bottom: BorderSide(
                                          color: secondary.withOpacity(.1),
                                          width: .5),
                                    ),
                                    leading: CircleAvatar(
                                      radius: dimensWidth() * 2,
                                      backgroundImage: image,
                                      onBackgroundImageError:
                                          (exception, stackTrace) {
                                        logPrint(exception);
                                      },
                                    ),
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            e.user?.fullName ??
                                                translate(context, 'undefine'),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: transparent,
                                          highlightColor: transparent,
                                          onTap: () => showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext context) =>
                                                      AlertDialog(
                                                        // insetPadding: EdgeInsets.zero,
                                                        // iconPadding: EdgeInsets.zero,
                                                        // titlePadding: EdgeInsets.zero,
                                                        // buttonPadding: EdgeInsets.zero,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        // actionsPadding: EdgeInsets.zero,
                                                        content: InkWell(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        dimensWidth() *
                                                                            2,
                                                                    vertical:
                                                                        dimensHeight() *
                                                                            2),
                                                                child: Text(
                                                                  translate(
                                                                      context,
                                                                      'report'),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .labelLarge,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                          child: FaIcon(
                                            FontAwesomeIcons.ellipsis,
                                            size: dimensIcon() / 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            initialRating:
                                                (e.rated ?? 0).toDouble(),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: dimensWidth() * 1.5,
                                            itemBuilder: (context, _) =>
                                                const FaIcon(
                                              FontAwesomeIcons.solidStar,
                                              color: Colors.orangeAccent,
                                            ),
                                            onRatingUpdate: (double value) {},
                                          ),
                                          if (e.feedback != null)
                                            Container(
                                              padding: EdgeInsets.only(
                                                top: dimensHeight(),
                                              ),
                                              width: double.infinity,
                                              child: Text(e.feedback!),
                                            ),
                                          if (createdAt != null)
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: dimensHeight()),
                                              width: double.infinity,
                                              child: Text(
                                                formatyMMMMd(
                                                    context, createdAt),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: black26
                                                            .withOpacity(.5),
                                                        fontSize: 8),
                                              ),
                                            )
                                        ]),
                                  );
                                },
                              )
                            else
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: dimensWidth() * 3),
                                child: Text(
                                  translate(context, 'empty'),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            if (feedbacks.isNotEmpty)
                              ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, feedbacksName,
                                      arguments: state.feedbacks);
                                },
                                shape: Border(
                                  bottom: BorderSide(
                                      color: secondary.withOpacity(.1),
                                      width: 15),
                                ),
                                title: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: dimensHeight() * 2),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${translate(context, "see_all")} >",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: secondary),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),

                    BlocBuilder<DoctorCubit, DoctorState>(
                      builder: (context, state) {
                        if (state.blocState == BlocState.Pending) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: dimensHeight() * 3,
                                  horizontal: dimensWidth() * 3,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      translate(context, 'suggestion_for_you'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(color: color1F1F1F),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding:
                                    EdgeInsets.only(top: dimensWidth() * 3),
                                child: const LinearProgressIndicator(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: dimensWidth() * 2,
                                    horizontal: dimensWidth() * 3),
                                child: BaseGridview(
                                  radio: 0.8,
                                  children: [buildShimmer(), buildShimmer()],
                                ),
                              )
                            ],
                          );
                        } else if (state.blocState == BlocState.Successed) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                              dimensWidth() * 3,
                              0,
                              dimensWidth() * 3,
                              dimensHeight() * 20,
                            ),
                            child: Column(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: dimensHeight() * 3,
                                  horizontal: dimensWidth() * 3,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      translate(context, 'suggestion_for_you'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(color: color1F1F1F),
                                    ),
                                  ],
                                ),
                              ),
                              BaseGridview(radio: 0.8, children: [
                                ...state.doctors.map(
                                  (e) => DoctorCard(
                                    doctor: e,
                                  ),
                                ),
                              ]),
                            ]),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    // SizedBox(
                    //   height: dimensHeight() * 15,
                    // )
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> showDialogEduAndEpx(
      BuildContext context, ConsultationCubit consulationCubit) async {
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.stamp,
              color: secondary,
              size: dimensIcon() / 2,
            ),
            SizedBox(
              width: dimensWidth(),
            ),
            Text(
              translate(context, 'education_and_certifications'),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: secondary),
            ),
          ],
        ),
        backgroundColor: white,
        elevation: 0,
        iconPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(
            horizontal: dimensWidth() * 3, vertical: dimensHeight() * 3),
        content: SingleChildScrollView(
          child: BlocProvider.value(
            value: consulationCubit,
            child: ListBody(
              children: [
                ...doctor.educationAndCertifications!.map(
                  (e) => Container(
                    decoration: const BoxDecoration(
                      color: white,
                      border: BorderDirectional(
                          bottom: BorderSide(width: 2, color: secondary)),
                      // borderRadius:
                      //     BorderRadius.circular(
                      //         dimensWidth() * 2)
                    ),
                    margin: EdgeInsets.only(
                      bottom: dimensHeight() * 2,
                    ),
                    padding: EdgeInsets.only(bottom: dimensHeight()),
                    child: ListBody(
                      children: [
                        Row(
                          children: [
                            Text("${translate(context, "type_of_education")}: ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("${e.typeOfEducationAndExperience}",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                "${translate(context, "degree_of_education")}: ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("${e.degreeOfEducation}",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        Row(
                          children: [
                            Text("${translate(context, "institution")}: ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("${e.institution}",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                "${translate(context, "specialty_by_diploma")}: ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("${e.specialtyByDiploma}",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        Row(
                          children: [
                            Text("${translate(context, "address")}: ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("${e.address}",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                "${translate(context, "date_of_receipt_of_diploma")}: ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("${e.dateOfReceiptOfDiploma}",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> showCareer(
      BuildContext context, ConsultationCubit consulationCubit) async {
    return await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.userDoctor,
              color: secondary,
              size: dimensIcon() / 2,
            ),
            SizedBox(
              width: dimensWidth(),
            ),
            Text(
              translate(context, 'career'),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: secondary),
            ),
          ],
        ),
        backgroundColor: white,
        elevation: 0,
        iconPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.symmetric(
            horizontal: dimensWidth() * 3, vertical: dimensHeight() * 3),
        content: SingleChildScrollView(
          child: BlocProvider.value(
            value: consulationCubit,
            child: ListBody(
              children: [
                ...doctor.careers!.map(
                  (e) => Container(
                    decoration: const BoxDecoration(
                      color: white,
                      border: BorderDirectional(
                          bottom: BorderSide(width: 2, color: secondary)),
                      // borderRadius:
                      //     BorderRadius.circular(
                      //         dimensWidth() * 2)
                    ),
                    margin: EdgeInsets.only(
                      bottom: dimensHeight() * 2,
                    ),
                    padding: EdgeInsets.only(bottom: dimensHeight()),
                    child: ListBody(
                      children: [
                        Row(
                          children: [
                            Text(
                                "${translate(context, "medical_institution")}: ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("${e.medicalInstitute}",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        Row(
                          children: [
                            Text("${translate(context, "position")}: ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("${e.position}",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                        Row(
                          children: [
                            Text("${translate(context, "start")}: ",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("${e.periodStart}",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildShimmer() => Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(dimensWidth() * 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.1),
              spreadRadius: dimensWidth() * .4,
              blurRadius: dimensWidth() * .4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: ShimmerWidget.rectangular(
                height: double.maxFinite,
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(dimensWidth() * 2),
                  topRight: Radius.circular(dimensWidth() * 2),
                )),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: dimensWidth(), horizontal: dimensWidth() * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ShimmerWidget.rectangular(
                        height: dimensHeight() * .5,
                        width: dimensWidth() * 14,
                      ),
                    ),
                    SizedBox(
                      height: dimensHeight(),
                    ),
                    Expanded(
                      flex: 2,
                      child: ShimmerWidget.rectangular(
                        height: double.maxFinite,
                        width: dimensWidth() * 10,
                      ),
                    ),
                    SizedBox(
                      height: dimensHeight(),
                    ),
                    const Expanded(
                      flex: 3,
                      child:
                          ShimmerWidget.rectangular(height: double.maxFinite),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}

class ShowBiography extends StatefulWidget {
  const ShowBiography({super.key, required this.biography});
  final String biography;
  @override
  State<ShowBiography> createState() => _ShowBiographyState();
}

class _ShowBiographyState extends State<ShowBiography> {
  bool seeAll = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          seeAll = !seeAll;
        });
      },
      splashColor: transparent,
      highlightColor: transparent,
      child: Text(
        widget.biography,
        style: Theme.of(context).textTheme.bodyLarge,
        maxLines: seeAll ? null : 5,
        overflow: seeAll ? null : TextOverflow.ellipsis,
      ),
    );
  }
}
