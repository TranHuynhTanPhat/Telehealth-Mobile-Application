// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class RecentDoctorCard extends StatefulWidget {
  const RecentDoctorCard({
    super.key,
    required this.doctor,
  });
  final DoctorResponse doctor;

  @override
  State<RecentDoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<RecentDoctorCard> {
  var _image;
  @override
  void initState() {
    _image = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      if (widget.doctor.avatar != null && widget.doctor.avatar != 'default') {
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
      onTap: () => Navigator.pushNamed(context, detailDoctorName,
          arguments: widget.doctor.toJson()),
      child: Container(
        // width: dimensWidth() * 20,
        // height: dimensHeight() * 40,
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
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(dimensWidth() * 2),
                    topRight: Radius.circular(dimensWidth() * 2),
                  ),
                  image: DecorationImage(
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        logPrint(exception);
                        setState(() {
                          _image = AssetImage(DImages.placeholder);
                        });
                      },
                      image: _image),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: dimensWidth(), horizontal: dimensWidth() * 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        widget.doctor.fullName ??
                            translate(context, 'undefine'),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        translate(
                            context, widget.doctor.specialty ?? 'undefine'),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: widget.doctor.ratings ?? 0,
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
                            "${widget.doctor.ratings?.toStringAsFixed(1) ?? 0}",
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
