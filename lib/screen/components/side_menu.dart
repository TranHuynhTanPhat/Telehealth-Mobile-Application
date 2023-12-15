// ignore_for_file: deprecated_member_use, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/components/badge_notification.dart';
import 'package:healthline/screen/components/info_card.dart';
import 'package:healthline/utils/translate.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state.blocState == BlocState.Pending) {
          EasyLoading.show();
        } else if ((state.blocState == BlocState.Successed ||
                state.blocState == BlocState.Failed) &&
            state is LogoutState) {
          EasyLoading.dismiss();
          Navigator.pushReplacementNamed(context, logInName);
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: secondary,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InfoCard(),
                // if (AppController.instance.authState == AuthState.AllAuthorized)
                //   ListTile(
                //     onTap: () {
                //       EasyLoading.show();
                //       Future.delayed(const Duration(seconds: 1), () {
                //         Navigator.pushReplacementNamed(
                //             context, mainScreenDoctorName);
                //       });
                //     },
                //     title: Text(
                //       translate(context, 'my_clinic'),
                //       style: Theme.of(context)
                //           .textTheme
                //           .titleMedium
                //           ?.copyWith(color: white),
                //     ),
                //     leading: FaIcon(
                //       FontAwesomeIcons.houseMedical,
                //       size: dimensIcon() * .5,
                //       color: white,
                //     ),
                //   )
                // else
                //   const SizedBox(),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, forumName);
                  },
                  title: Text(
                    translate(context, 'forum'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: white),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.solidComments,
                    size: dimensIcon() * .5,
                    color: white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: dimensHeight() * 2,
                      left: dimensWidth() * 2,
                      bottom: dimensHeight()),
                  child: Text(
                    translate(context, 'setting'),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: white),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, accountSettingName);
                  },
                  title: Text(
                    translate(context, 'account_setting'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: white),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.userGear,
                    size: dimensIcon() * .5,
                    color: white,
                  ),
                ),
                BlocBuilder<ApplicationUpdateCubit, ApplicationUpdateState>(
                    builder: (context, state) {
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, applicationSettingName);
                    },
                    title: Text(
                      translate(context, 'application_setting'),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: white),
                    ),
                    leading: badgeNotification(
                        child: FaIcon(
                          FontAwesomeIcons.gear,
                          size: dimensIcon() * .5,
                          color: white,
                        ),
                        isShow: state is UpdateAvailable,
                        color: Theme.of(context).colorScheme.error,
                        top: -10,
                        end: -10),
                  );
                }),
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: dimensHeight() * 3,
                //       left: dimensWidth() * 2,
                //       bottom: dimensHeight()),
                //   child: Text(
                //     translate(context, 'supports'),
                //     style: Theme.of(context)
                //         .textTheme
                //         .titleLarge
                //         ?.copyWith(color: white),
                //   ),
                // ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, helpsName);
                  },
                  title: Text(
                    translate(context, 'helps'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: white),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.circleQuestion,
                    size: dimensIcon() * .5,
                    color: white,
                  ),
                ),
                // ListTile(
                //   onTap: () {
                //     Navigator.pushNamed(context, faqsName);
                //   },
                //   title: Text(
                //     translate(context, 'FAQs'),
                //     style: Theme.of(context)
                //         .textTheme
                //         .titleMedium
                //         ?.copyWith(color: white),
                //   ),
                //   leading: FaIcon(
                //     FontAwesomeIcons.circleQuestion,
                //     size: dimensIcon() * .5,
                //     color: white,
                //   ),
                // ),
                // ListTile(
                //   onTap: () {
                //     Navigator.pushNamed(context, termsAndConditionsName);
                //   },
                //   title: Text(
                //     translate(context, 'terms_and_conditions'),
                //     style: Theme.of(context)
                //         .textTheme
                //         .titleMedium
                //         ?.copyWith(color: white),
                //   ),
                //   leading: FaIcon(
                //     FontAwesomeIcons.fileContract,
                //     size: dimensIcon() * .5,
                //     color: white,
                //   ),
                // ),
                // ListTile(
                //   onTap: () {
                //     Navigator.pushNamed(context, privacyPolicyName);
                //   },
                //   title: Text(
                //     translate(context, 'privacy_policy'),
                //     style: Theme.of(context)
                //         .textTheme
                //         .titleMedium
                //         ?.copyWith(color: white),
                //   ),
                //   leading: FaIcon(
                //     FontAwesomeIcons.shieldHalved,
                //     size: dimensIcon() * .5,
                //     color: white,
                //   ),
                // ),
                // const Spacer(),
                // ListTile(
                //   onTap: () {
                //     AppLocalizations.of(context).isVnLocale
                //         ? context.read<ResCubit>().toEnglish()
                //         : context.read<ResCubit>().toVietnamese();
                //   },
                //   title: Text(
                //     AppLocalizations.of(context).isVnLocale
                //         ? translate(context, 'en')
                //         : translate(context, 'vi'),
                //     style: Theme.of(context)
                //         .textTheme
                //         .titleMedium
                //         ?.copyWith(color: white),
                //   ),
                //   leading: FaIcon(
                //     FontAwesomeIcons.language,
                //     size: dimensIcon() * .5,
                //     color: white,
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(bottom: dimensHeight() * 5),
                //   child: ListTile(
                //     onTap: () {
                //       // RestClient().logout();
                //       context.read<SideMenuCubit>().logout();
                //     },
                //     leading: FaIcon(
                //       FontAwesomeIcons.arrowRightFromBracket,
                //       size: dimensIcon() * .7,
                //       color: Colors.yellow,
                //     ),
                //     title: Text(
                //       translate(context, 'log_out'),
                //       style: Theme.of(context)
                //           .textTheme
                //           .labelMedium
                //           ?.copyWith(color: Colors.yellow),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
