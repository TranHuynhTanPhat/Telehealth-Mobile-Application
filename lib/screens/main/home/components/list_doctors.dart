import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';

class ListDoctors extends StatelessWidget {
  const ListDoctors({
    super.key,
    required this.doctors,
  });

  final List<Map<String, dynamic>> doctors;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.symmetric(
          vertical: dimensWidth() * 2, horizontal: dimensWidth() * 3),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 0.8,
        mainAxisSpacing: dimensWidth() * 2,
        crossAxisSpacing: dimensHeight() * 2,
      ),
      children: doctors
          .map(
            (e) => DoctorTitle(
              doctor: e,
            ),
          )
          .toList(),
    );
  }
}

class DoctorTitle extends StatelessWidget {
  const DoctorTitle({
    super.key,
    required this.doctor,
  });
  final Map<String, dynamic> doctor;

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
                      image: AssetImage(DImages.anhthe))),
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
                      doctor['dr'],
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      doctor['description'],
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
                            initialRating: doctor['rate'],
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
                            "(${doctor['review']})",
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
