// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/bloc/cubits/cubit_consultation/consultation_cubit.dart';
import 'package:healthline/bloc/cubits/cubit_doctor/doctor_cubit.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class DoctorCard extends StatefulWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
  });
  final DoctorResponse doctor;

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  var _image;
  @override
  void initState() {
    _image = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (widget.doctor.avatar != null &&
          widget.doctor.avatar != 'default' &&
          widget.doctor.avatar != '') {
        _image = _image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(widget.doctor.avatar ?? '')
                  .toString(),
            );
      } else {
        _image = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      _image = AssetImage(DImages.placeholder);
    }
    return InkWell(
      splashColor: transparent,
      highlightColor: transparent,
      onTap: () {
        Navigator.pushNamed(context, detailDoctorName,
          arguments: widget.doctor.toJson());
        context.read<DoctorCubit>().addRecentDoctor(widget.doctor);

      },
      child: Container(
        padding: EdgeInsets.all(dimensWidth() * 2),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.1),
              spreadRadius: dimensWidth() * .4,
              blurRadius: dimensWidth() * .4,
            ),
          ],
          borderRadius: BorderRadius.circular(dimensWidth() * 3),
          border: Border.all(color: colorA8B1CE.withOpacity(.2), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Hero(
                  tag: widget.doctor.id!,
                  transitionOnUserGestures: true,
                  child: CircleAvatar(
                    radius: dimensWidth() * 4.5,
                    backgroundImage: _image,
                    backgroundColor: white,
                    onBackgroundImageError: (exception, stackTrace) {
                      logPrint(exception);
                      setState(
                        () {
                          _image = AssetImage(DImages.placeholder);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: dimensWidth() * 2.5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.doctor.fullName ??
                            translate(context, 'undefine'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        translate(
                          context,
                          widget.doctor.specialty ??
                              translate(context, 'undefine'),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      InkWell(
                        splashColor: transparent,
                        highlightColor: transparent,
                        onTap: () {
                          if (widget.doctor.id != null) {
                            DateTime dateTime = DateTime.now();
                            context.read<ConsultationCubit>().fetchTimeline(
                                doctorId: widget.doctor.id!,
                                date:
                                    '${dateTime.day+1}/${dateTime.month}/${dateTime.year}');
                            Navigator.pushNamed(
                              context,
                              createConsultationName,
                              arguments: widget.doctor.toJson(),
                            );
                          } else {
                            EasyLoading.showToast(
                                translate(context, 'cant_load_data'));
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          width: dimensWidth() * 17,
                          padding: EdgeInsets.all(dimensWidth() * .8),
                          decoration: const BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.solidCalendarPlus,
                                size: dimensIcon() * .4,
                                color: white,
                              ),
                              SizedBox(
                                width: dimensWidth() * .3,
                              ),
                              Expanded(
                                child: Text(
                                  translate(context, 'book_appointment_now'),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: dimensHeight(),
            ),
            widget.doctor.biography != null
                ? Text(
                    widget.doctor.biography.toString(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
