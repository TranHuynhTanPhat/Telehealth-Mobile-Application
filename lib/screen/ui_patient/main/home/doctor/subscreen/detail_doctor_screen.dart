// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class DetailDoctorScreen extends StatefulWidget {
  const DetailDoctorScreen({
    super.key,
    this.args,
  });
  final String? args;

  @override
  State<DetailDoctorScreen> createState() => _DetailDoctorScreenState();
}

class _DetailDoctorScreenState extends State<DetailDoctorScreen> {
  var _image;
  late DoctorResponse doctor;

  @override
  void initState() {
    _image = null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      doctor = DoctorResponse.fromJson(widget.args!);
      context
          .read<ConsultationCubit>()
          .fetchFeedbackDoctor(doctorId: doctor.id!);
    } catch (e) {
      EasyLoading.showToast(translate(context, 'cant_load_data'));
      Navigator.pop(context);
      return const SizedBox();
    }
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
              );
            } else {
              EasyLoading.showToast(translate(context, 'cant_load_data'));
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: CustomScrollView(slivers: [
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
                        .bodyLarge
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
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: dimensHeight(), horizontal: dimensWidth() * 3),
                child: Text(
                  translate(context, doctor.specialty ?? 'undefine'),
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: dimensWidth() * 3, right: dimensWidth() * 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      ignoreGestures: true,
                      initialRating: doctor.ratings ?? 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: dimensWidth() * 2,
                      itemBuilder: (context, _) => const FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: dimensWidth()),
                      child: Text(
                        // "3.5 (+800 ${translate(context, 'feedbacks')})",
                        "${doctor.ratings?.toStringAsFixed(1) ?? 0} (${doctor.numberOfConsultation} ${translate(context, 'appointments')})",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: dimensHeight() * 3,
                    left: dimensWidth() * 3,
                    right: dimensWidth() * 3),
                child: Text(
                  translate(context, 'biography'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: dimensWidth() * 3, right: dimensWidth() * 3),
                child: Text(
                  doctor.biography ?? translate(context, 'undefine'),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: dimensHeight() * 3,
                    left: dimensWidth() * 3,
                    right: dimensWidth() * 3),
                child: Text(
                  translate(context, 'feedbacks'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              BlocBuilder<ConsultationCubit, ConsultationState>(
                builder: (context, state) {
                  if (state.feedbacks != null && state.feedbacks!.isNotEmpty) {
                    return Column(
                      children: state.feedbacks!.map((e) {
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
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: image,
                            onBackgroundImageError: (exception, stackTrace) {
                              logPrint(exception);
                            },
                          ),
                          title: Text(
                            e.user?.fullName ?? translate(context, 'undefine'),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  initialRating: (e.rated ?? 0).toDouble(),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: dimensWidth() * 2,
                                  itemBuilder: (context, _) => const FaIcon(
                                    FontAwesomeIcons.solidStar,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (double value) {},
                                ),
                                if (e.feedback != null)
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(e.feedback!),
                                  )
                              ]),
                        );
                      }).toList(),
                    );
                  } else {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                      child: Text(
                        translate(context, 'empty'),
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: dimensHeight() * 15,
              )
              //   ],
              // ),
            ],
          ),
        ),
      ]),
    );
  }

  // ListView shimmerBuilder() {
  //   return ListView(
  //     shrinkWrap: true,
  //     scrollDirection: Axis.vertical,
  //     padding: EdgeInsets.only(
  //         bottom: dimensHeight() * 2,
  //         left: dimensWidth() * 3,
  //         right: dimensWidth() * 3),
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(
  //             bottom: dimensHeight(),
  //             top: dimensHeight(),
  //             right: dimensWidth() * 25),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(right: dimensWidth() * 20),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2.5,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: dimensHeight() * 2, right: dimensWidth() * 35),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 3.5,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(top: dimensHeight() * 2),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(top: dimensHeight()),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(top: dimensHeight()),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(top: dimensHeight()),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding:
  //             EdgeInsets.only(top: dimensHeight(), right: dimensWidth() * 15),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: dimensHeight() * 3, right: dimensWidth() * 20),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 3.5,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: dimensHeight() * 2, right: dimensWidth() * 15),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: dimensHeight() * 3, right: dimensWidth() * 35),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 3.5,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: dimensHeight() * 2, right: dimensWidth() * 20),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       SizedBox(
  //         height: dimensHeight() * 10,
  //       )
  //     ],
  //   );
  // }
}
