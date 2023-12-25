// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/data_constants.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class ListFeedback extends StatefulWidget {
  const ListFeedback({super.key});

  @override
  State<ListFeedback> createState() => _ListFeedbackState();
}

class _ListFeedbackState extends State<ListFeedback> {
  @override
  void initState() {
    if (!mounted) return;
    try {
      var doctor = LoginResponse.fromJson(
          AppStorage().getString(key: DataConstants.DOCTOR)!);
      context
          .read<ConsultationCubit>()
          .fetchFeedbackDoctor(doctorId: doctor.id!);
    } catch (e) {
      logPrint(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationCubit, ConsultationState>(
      builder: (context, state) {
        // return Column(children: [
        //   ListTile(
        //     leading: CircleAvatar(
        //       backgroundImage: AssetImage(DImages.placeholder),
        //       onBackgroundImageError: (exception, stackTrace) {
        //         logPrint(exception);
        //       },
        //     ),
        //     title: Text(
        //       "Tran Huynh Tan Phat",
        //       style: Theme.of(context).textTheme.labelLarge,
        //     ),
        //     subtitle: Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           RatingBar.builder(
        //             ignoreGestures: true,
        //             initialRating: 4,
        //             minRating: 1,
        //             direction: Axis.horizontal,
        //             allowHalfRating: true,
        //             itemCount: 5,
        //             itemSize: dimensWidth() * 2,
        //             itemBuilder: (context, _) => const FaIcon(
        //               FontAwesomeIcons.solidStar,
        //               color: Colors.amber,
        //             ),
        //             onRatingUpdate: (double value) {},
        //           ),
        //           // if (e.feedback != null)
        //           SizedBox(
        //             width: double.infinity,
        //             child: Text("Bác sĩ rất tận tâm"),
        //           )
        //         ]),
        //   )
        // ]);
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
          return Container(
            margin: EdgeInsets.only(top: dimensHeight() * 10),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        translate(context, 'empty'),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                color: color1F1F1F.withOpacity(.05),
                                fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: dimensHeight() * 3,
                // ),
                FaIcon(
                  FontAwesomeIcons.boxOpen,
                  color: color1F1F1F.withOpacity(.05),
                  size: dimensWidth() * 30,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
