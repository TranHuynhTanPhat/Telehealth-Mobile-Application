// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/data_constants.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class ListFeedback extends StatefulWidget {
  const ListFeedback({super.key});

  @override
  State<ListFeedback> createState() => _ListFeedbackState();
}

class _ListFeedbackState extends State<ListFeedback> {
  List<FeedbackResponse> feedbacks = [];
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
      return;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationCubit, ConsultationState>(
      builder: (context, state) {
        if (state is FetchFeedbackDoctorState) {
          if (state.blocState == BlocState.Successed &&
              state.feedbacks != null) {
            feedbacks = state.feedbacks!;
            feedbacks = feedbacks
                .where((element) => element.rated != null && element.rated! > 0)
                .toList();
            feedbacks.sort((a, b) {
              DateTime? aTime = convertStringToDateTime(a.createdAt);
              DateTime? bTime = convertStringToDateTime(b.createdAt);
              if (aTime != null && bTime != null) {
                return aTime.compareTo(bTime);
              } else {
                return aTime == null ? -1 : 1;
              }
            });
          }
        }
        if (feedbacks.isNotEmpty) {
          return Column(
            children: feedbacks.map((e) {
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
              DateTime? createdAt = convertStringToDateTime(e.createdAt);
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
                        ),
                      if (createdAt != null)
                        Container(
                          padding: EdgeInsets.only(top: dimensHeight()),
                          width: double.infinity,
                          child: Text(
                            formatyMMMMd(context, createdAt),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: black26.withOpacity(.5),
                                    fontSize: 8),
                          ),
                        ),
                      const Divider(
                        thickness: 2,
                      ),
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
