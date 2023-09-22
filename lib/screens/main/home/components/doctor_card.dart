import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/res/style.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
  });
  final DoctorResponse doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(dimensWidth() * 2),
                    topRight: Radius.circular(dimensWidth() * 2)),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.center,
                  image: AssetImage(DImages.placeholder),
                ),

              ),
            )
            //  Image(image: AssetImage(DImages.placeholder),fit: BoxFit.cover,alignment: Alignment.center,)
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
                    flex: 1,
                    child: Text(
                      doctor.fullName??"Undefine",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      doctor.specialty??"Undefine",
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
                            initialRating: 5,
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
                            "(100)",
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      )),
                ],
              ),
            ))
      ]),
    );
  }
}
