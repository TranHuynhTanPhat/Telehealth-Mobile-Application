// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/data/api/models/responses/consultation_response.dart';
import 'package:healthline/data/api/models/responses/feedback_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/time_util.dart';
import 'package:healthline/utils/translate.dart';
import 'package:intl/intl.dart';

class CompletedCard extends StatefulWidget {
  const CompletedCard({super.key, required this.finish});
  final ConsultationResponse finish;

  @override
  State<CompletedCard> createState() => _CompletedCardState();
}

class _CompletedCardState extends State<CompletedCard> {
  var image;
  List<int> time = [];
  late ConsultationResponse finish;
  @override
  void initState() {
    if (!mounted) return;
    finish = widget.finish;
    image = null;
    super.initState();
  }

  Future<bool?> showBottomSheetFeedback(BuildContext context,
      {required String feedbackId}) async {
    double rating = 1;
    TextEditingController feedbackController = TextEditingController();

    return await showModalBottomSheet<bool>(
      context: context,
      barrierColor: black26,
      elevation: 0,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: transparent,
      builder: (BuildContext contextBottomSheet) {
        // print(context.read<ConsultationCubit>());
        ConsultationCubit consultationCubit = context.read<ConsultationCubit>();

        return BlocListener<ConsultationCubit, ConsultationState>(
          bloc: consultationCubit,
          listener: (context, state) {
            if (state is CreateFeebackState) {
              if (state.blocState == BlocState.Successed) {
                finish = finish.copyWith(
                    feedback: FeedbackResponse(
                        rated: rating.toInt(),
                        feedback: feedbackController.text));
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
                        borderRadius: BorderRadius.circular(dimensWidth() * 3),
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
                              padding: EdgeInsets.only(top: dimensHeight() * 2),
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
                              padding: EdgeInsets.only(top: dimensHeight() * 2),
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
      if (widget.finish.doctor?.avatar != null &&
          widget.finish.doctor?.avatar != 'default' &&
          widget.finish.doctor?.avatar != '') {
        image = image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget.finish.doctor?.avatar ?? '')
                  .toString(),
            );
      } else {
        image = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      image = AssetImage(DImages.placeholder);
    }
    try {
      time = widget.finish.expectedTime
              ?.split('-')
              .map((e) => int.parse(e))
              .toList() ??
          [int.parse(widget.finish.expectedTime!)];
    } catch (e) {
      EasyLoading.showToast(translate(context, 'failure'));
    }
    String? expectedTime;
    try {
      expectedTime =
          '${convertIntToTime(time.first)} - ${convertIntToTime(time.last + 1)}';
    } catch (e) {
      logPrint(e);
    }

    return Container(
      margin: EdgeInsets.only(top: dimensHeight() * 2),
      padding: EdgeInsets.symmetric(
          horizontal: dimensWidth() * 2, vertical: dimensWidth() * 2),
      decoration: BoxDecoration(
        color: colorA8B1CE.withOpacity(.2),
        borderRadius: BorderRadius.all(
          Radius.circular(dimensWidth() * 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            " ${translate(context, widget.finish.doctor?.fullName)}",
                            overflow: TextOverflow.visible,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: color6A6E83,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            translate(
                                context,
                                widget.finish.doctor!.specialties!.firstOrNull
                                        ?.specialty ??
                                    ""),
                            overflow: TextOverflow.visible,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: black26,
                                    fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: dimensHeight()),
                            child: Text(
                              "${translate(context, 'patient')}: ${widget.finish.medical?.fullName ?? translate(context, 'undefine')}",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: color6A6E83),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (widget.finish.feedback?.rated == null &&
                  widget.finish.feedback?.id != null &&
                  AppController().authState == AuthState.PatientAuthorized)
                InkWell(
                  splashColor: transparent,
                  highlightColor: transparent,
                  onTap: () async {
                    await showBottomSheetFeedback(context,
                            feedbackId: widget.finish.feedback!.id!)
                        .then((value) {
                      if (value == true) {
                        context.read<ConsultationCubit>().fetchConsultation();
                      }
                    });
                  },
                  child: Text(
                    translate(context, 'feedback'),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: primary,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: dimensHeight() * 2),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    formatDayMonthYear(
                        context,
                        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                            .parse(widget.finish.date!)),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.clock,
                color: color6A6E83,
                size: dimensWidth() * 2,
              ),
              SizedBox(
                width: dimensWidth(),
              ),
              if (expectedTime != null)
                Text(
                  expectedTime,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: color1F1F1F, fontWeight: FontWeight.bold),
                ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    translate(context, widget.finish.status),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth(),
                  ),
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    color: color6A6E83,
                    size: dimensWidth() * 2,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
