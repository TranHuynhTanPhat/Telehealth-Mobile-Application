import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class DetailPatientScreen extends StatefulWidget {
  const DetailPatientScreen({super.key});

  @override
  State<DetailPatientScreen> createState() => _DetailPatientScreenState();
}

class _DetailPatientScreenState extends State<DetailPatientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: white,
      appBar: AppBar(
        title: const Text(
          "Patient's name",
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
            horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
        children: [
           const HealthStat(
                fullName: "fullName",
                relationship: "relationship",
                heartRate: 100,
                bloodGroup: "A",
                height: 179,
                weight: 73,
                bmi: 50,
                temperature: 36),
          
          Padding(
            padding: EdgeInsets.only(top: dimensHeight()*2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Lịch sử khám bệnh",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: color1F1F1F),
                ),
                InkWell(
                  // onTap: () => Navigator.pushNamed(context, doctorName),
                  child: Text(
                    translate(context, 'see_all'),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: dimensHeight() * 2),
            child: const ScheduleCard(),
          ),
        ],
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(dimensWidth() * 2),
      ),
      child: Column(children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: primary,
              backgroundImage: AssetImage(DImages.placeholder),
              radius: dimensHeight() * 4,
              onBackgroundImageError: (exception, stackTrace) {
                logPrint(exception);
              },
            ),
            SizedBox(
              width: dimensWidth() * 2,
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Medical's name",
                      style: Theme.of(context).textTheme.labelLarge,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Symptom",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "20:20 1/4/2024",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: black26),
                      textAlign: TextAlign.right,
                    )),
                  ],
                ),
              ],
            ))
          ],
        ),
        Divider(
          thickness: 2,
          color: black26.withOpacity(.2),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Patient's feedback",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: dimensHeight() * 2),
          alignment: Alignment.center,
          width: double.infinity,
          child: RatingBar.builder(
            ignoreGestures: true,
            initialRating: 0,
            minRating: 0,
            maxRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: dimensWidth() * 3.5,
            itemPadding: EdgeInsets.all(dimensWidth()),
            itemBuilder: (context, _) => const FaIcon(
              FontAwesomeIcons.solidStar,
              color: Colors.amber,
            ),
            onRatingUpdate: (double value) {},
          ),
        ),
      ]),
    );
  }
}

class HealthStat extends StatelessWidget {
  const HealthStat({
    super.key,
    required this.fullName,
    required this.relationship,
    required this.heartRate,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.temperature,
  });

  final String? fullName;
  final String? relationship;
  final num heartRate;
  final String bloodGroup;
  final double height;
  final num weight;
  final double bmi;
  final num temperature;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(dimensWidth() * 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: dimensHeight()),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${translate(context, 'full_name')}: ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                // if (state.subUsers.isNotEmpty)
                Expanded(
                  child: Text(
                    fullName ?? translate(context, 'undefine'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
          if (relationship != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: dimensHeight()),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${translate(context, 'relationship')}: ',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  // if (state.subUsers.isNotEmpty)
                  Expanded(
                    child: Text(
                      translate(context, relationship?.toLowerCase()),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  )
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: dimensHeight()),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${translate(context, 'heart_rate')}: ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: Text(
                    '$heartRate bpm',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: dimensHeight()),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${translate(context, 'blood_group')}: ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: Text(
                    bloodGroup,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: dimensHeight()),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${translate(context, 'height')}: ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: Text(
                    '$height m',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: dimensHeight()),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${translate(context, 'weight')}: ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: Text(
                    '$weight Kg',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: dimensHeight()),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${translate(context, 'BMI')}: ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: Text(
                    '${double.parse(
                      bmi.toStringAsFixed(2),
                    )} ',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: dimensHeight()),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${translate(context, 'temperature')}: ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Expanded(
                  child: Text(
                    '$temperature °C',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
