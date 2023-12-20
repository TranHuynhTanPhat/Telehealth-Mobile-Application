import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:healthline/bloc/cubits/cubit_doctor_profile/doctor_profile_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

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
          return ListView(
            shrinkWrap: true,
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

              return ExpansionTile(
                title: Padding(
                  padding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
                  child: Text(
                    e.fullName ?? translate(context, 'undefine'),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: image,
                  onBackgroundImageError: (exception, stackTrace) {
                    logPrint(exception);
                  },
                ),
                children: [
                  if (e.email != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dimensHeight() * 3,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              e.email!,
                              style: Theme.of(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            onTap: () {
                              logPrint(emailLaunchUri);
                              launchUrl(emailLaunchUri);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: dimensWidth() * 3,
                                  left: dimensWidth() * 2),
                              child: FaIcon(
                                FontAwesomeIcons.envelope,
                                size: dimensIcon() * .7,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  if (e.phone != null)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: dimensHeight() * 3,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              e.phone!,
                              style: Theme.of(context).textTheme.bodyLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            onTap: () {
                              logPrint(telLaunchUri);
                              launchUrl(telLaunchUri);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: dimensWidth() * 3,
                                  left: dimensWidth() * 2),
                              child: FaIcon(
                                FontAwesomeIcons.phone,
                                size: dimensIcon() * .7,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
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
