// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

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
  var _image;
  @override
  void initState() {
    _image = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _image = _image ??
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
                                backgroundImage: _image,
                                backgroundColor: white,
                                onBackgroundImageError:
                                    (exception, stackTrace) => setState(() {
                                          _image =
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
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    translate(
                                        context, widget.doctor['specialty']),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  InkWell(
                                    child: Container(
                                      width: dimensWidth() * 17,
                                      padding:
                                          EdgeInsets.all(dimensWidth() * .8),
                                      decoration: const BoxDecoration(
                                        color: primary,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                              translate(context,
                                                  'book_appointment_now'),
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
