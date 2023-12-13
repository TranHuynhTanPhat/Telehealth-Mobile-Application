// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/data/api/models/responses/doctor_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class DetailDoctorScreen extends StatefulWidget {
  const DetailDoctorScreen({
    super.key,
    this.args,
  });
  final String? args;

  @override
  State<DetailDoctorScreen> createState() => _DetailDoctorScreenState();
}

class _DetailDoctorScreenState extends State<DetailDoctorScreen> {
  var _image;
  late DoctorResponse doctor;

  @override
  void initState() {
    _image = null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      doctor = DoctorResponse.fromJson(widget.args!);
    } catch (e) {
      EasyLoading.showToast(translate(context, 'cant_load_data'));
      Navigator.pop(context);
      return const SizedBox();
    }
    try {
      if (doctor.avatar != null &&
          doctor.avatar != 'default' &&
          doctor.avatar != '') {
        _image = _image ??
            NetworkImage(
              CloudinaryContext.cloudinary
                  .image(doctor.avatar ?? '')
                  .toString(),
            );
      } else {
        _image = AssetImage(DImages.placeholder);
      }
    } catch (e) {
      logPrint(e);
      _image = AssetImage(DImages.placeholder);
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      extendBody: true,
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(
            dimensWidth() * 3, 0, dimensWidth() * 3, dimensHeight() * 3),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white.withOpacity(0.0), white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: double.infinity,
        child: ElevatedButtonWidget(
          text: translate(context, 'book_appointment_now'),
          onPressed: () => Navigator.pushNamed(context, timelineDoctorName),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              centerTitle: true,
              snap: false,
              pinned: true,
              floating: true,
              expandedHeight: dimensHeight() * 35,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: _image,
                      onError: (exception, stackTrace) => setState(() {
                        logPrint(exception);
                        _image = AssetImage(DImages.placeholder);
                      }),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(dimensHeight() * 7),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    dimensWidth() * 3,
                    dimensHeight(),
                    dimensWidth() * 3,
                    dimensHeight(),
                  ),
                  alignment: Alignment.bottomLeft,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [white.withOpacity(0.0), white],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          doctor.fullName ?? translate(context, 'undefine'),
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "${convertToVND(doctor.feePerMinutes ?? 0)}/${translate(context, 'minute')}",
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: secondary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(
              bottom: dimensHeight() * 2,
              left: dimensWidth() * 3,
              right: dimensWidth() * 3),
          children: [
            Padding(
              padding:
                  EdgeInsets.only(bottom: dimensHeight(), top: dimensHeight()),
              child: Text(
                translate(context, doctor.specialty ?? 'undefine'),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: doctor.ratings ?? 0,
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
                Padding(
                  padding: EdgeInsets.only(left: dimensWidth()),
                  child: Text(
                    // "3.5 (+800 ${translate(context, 'feedbacks')})",
                    "${doctor.ratings?.toStringAsFixed(1) ?? 0} (${doctor.numberOfConsultation} ${translate(context, 'appointments')})",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: dimensHeight() * 3),
              child: Text(
                translate(context, 'biography'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              doctor.biography ?? translate(context, 'undefine'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Padding(
              padding: EdgeInsets.only(top: dimensHeight() * 3),
              child: Text(
                translate(context, 'working_time'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              'Mon - Sat, 10:00 am - 07:00 pm',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Padding(
              padding: EdgeInsets.only(top: dimensHeight() * 3),
              child: Text(
                translate(context, 'feedbacks'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              'Mon - Sat, 10:00 am - 07:00 pm',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(
              height: dimensHeight() * 10,
            )
          ],
        ),
      ),
    );
  }

  // ListView shimmerBuilder() {
  //   return ListView(
  //     shrinkWrap: true,
  //     scrollDirection: Axis.vertical,
  //     padding: EdgeInsets.only(
  //         bottom: dimensHeight() * 2,
  //         left: dimensWidth() * 3,
  //         right: dimensWidth() * 3),
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(
  //             bottom: dimensHeight(),
  //             top: dimensHeight(),
  //             right: dimensWidth() * 25),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(right: dimensWidth() * 20),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2.5,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: dimensHeight() * 2, right: dimensWidth() * 35),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 3.5,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(top: dimensHeight() * 2),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(top: dimensHeight()),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(top: dimensHeight()),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(top: dimensHeight()),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding:
  //             EdgeInsets.only(top: dimensHeight(), right: dimensWidth() * 15),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: dimensHeight() * 3, right: dimensWidth() * 20),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 3.5,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: dimensHeight() * 2, right: dimensWidth() * 15),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: dimensHeight() * 3, right: dimensWidth() * 35),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 3.5,
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.only(
  //             top: dimensHeight() * 2, right: dimensWidth() * 20),
  //         child: ShimmerWidget.rectangular(
  //           height: dimensHeight() * 2,
  //         ),
  //       ),
  //       SizedBox(
  //         height: dimensHeight() * 10,
  //       )
  //     ],
  //   );
  // }
}
