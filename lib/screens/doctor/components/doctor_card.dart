// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/res/style.dart';

class DoctorCard extends StatefulWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
  });
  final Map<String, dynamic> doctor;

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  var imgVariable;
  @override
  void initState() {
    imgVariable = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    imgVariable = imgVariable ??
        NetworkImage(
          CloudinaryContext.cloudinary
              .image(widget.doctor['avatar'] ?? '')
              .toString(),
        );
    return InkWell(
      splashColor: transparent,
      highlightColor: transparent,
      onTap: () => Navigator.pushNamed(context, detailDoctorName),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(dimensWidth() * 2),
              margin: EdgeInsets.symmetric(vertical: dimensHeight() * 1),
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
                border:
                    Border.all(color: colorA8B1CE.withOpacity(.2), width: 2),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: dimensWidth() * 4.5,
                                backgroundImage: imgVariable,
                                onBackgroundImageError:
                                    (exception, stackTrace) => setState(() {
                                          imgVariable =
                                              AssetImage(DImages.placeholder);
                                        })),
                            SizedBox(
                              width: dimensWidth() * 2.5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.doctor['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'Next Available:' +
                                        widget.doctor['available_next'],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              dimensWidth() * .8),
                                          decoration: const BoxDecoration(
                                            color: primary,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                          ),
                                          child: FaIcon(
                                            FontAwesomeIcons.solidComment,
                                            size: dimensIcon() * .4,
                                            color: white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: dimensWidth(),
                                      ),
                                      InkWell(
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              dimensWidth() * .8),
                                          decoration: const BoxDecoration(
                                            color: primary,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100),
                                            ),
                                          ),
                                          child: FaIcon(
                                            FontAwesomeIcons.solidCalendarPlus,
                                            size: dimensIcon() * .4,
                                            color: white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: dimensHeight(),
                        ),
                        Text(
                          widget.doctor['biography'],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 1),
            child: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: dimensIcon() * .6,
              color: primary.withOpacity(.5),
            ),
          )
        ],
      ),
    );
  }
}
