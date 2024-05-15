// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/bloc/cubits/cubit_doctor_profile/doctor_profile_cubit.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';
import 'package:url_launcher/url_launcher.dart';

class ListPatient extends StatefulWidget {
  const ListPatient({super.key});

  @override
  State<ListPatient> createState() => _ListPatientState();
}

class _ListPatientState extends State<ListPatient> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
      builder: (context, state) {
        if (state is FetchPatientState && state.patients.isNotEmpty) {
          return Column(
            children: state.patients.map((e) {
              var image;
              try {
                if (e.avatar != null &&
                    e.avatar != 'default' &&
                    e.avatar != '') {
                  image = image ??
                      NetworkImage(
                        CloudinaryContext.cloudinary
                            .image(e.avatar ?? '')
                            .toString(),
                      );
                } else {
                  image = AssetImage(DImages.placeholder);
                }
              } catch (e) {
                logPrint(e);
                image = AssetImage(DImages.placeholder);
              }

              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: e.email,
              );
              final Uri telLaunchUri = Uri(
                scheme: 'tel',
                path: e.phone,
              );

              return Container(
                margin: EdgeInsets.only(top: dimensHeight() * 1.5),
                padding: EdgeInsets.symmetric(
                    vertical: dimensHeight() * 1.5,
                    horizontal: dimensWidth() * 2),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(
                      dimensWidth() * 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 15,
                        offset: const Offset(0, 2),
                      ),
                    ]),
                child: Row(children: [
                  CircleAvatar(
                    backgroundImage: image,
                    onBackgroundImageError: (exception, stackTrace) {
                      logPrint(exception);
                    },
                  ),
                  SizedBox(
                    width: dimensWidth() * 2,
                  ),
                  Expanded(
                    child: ListBody(
                      children: [
                        Text(
                          e.fullName ?? translate(context, 'undefine'),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        if (e.email != null)
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  e.email!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        if (e.phone != null)
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  e.phone!,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: dimensHeight(),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (e.email != null)
                              Padding(
                                padding:
                                    EdgeInsets.only(right: dimensWidth() * 2),
                                child: InkWell(
                                  splashColor: transparent,
                                  highlightColor: transparent,
                                  onTap: () {
                                    logPrint(emailLaunchUri);
                                    launchUrl(emailLaunchUri);
                                  },
                                  child: Container(
                                    width: dimensIcon(),
                                    height: dimensIcon(),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(360),
                                    ),
                                    child: FaIcon(
                                      FontAwesomeIcons.envelope,
                                      size: dimensIcon() * .6,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ),
                            if (e.phone != null)
                              Padding(
                                padding:
                                    EdgeInsets.only(right: dimensWidth() * 2),
                                child: InkWell(
                                  splashColor: transparent,
                                  highlightColor: transparent,
                                  onTap: () {
                                    logPrint(telLaunchUri);
                                    launchUrl(telLaunchUri);
                                  },
                                  child: Container(
                                    width: dimensIcon(),
                                    height: dimensIcon(),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(360),
                                    ),
                                    // padding:
                                    //     EdgeInsets.only(left: dimensWidth() * 2),
                                    child: FaIcon(
                                      FontAwesomeIcons.phone,
                                      size: dimensIcon() * .5,
                                      color: white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  )
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
