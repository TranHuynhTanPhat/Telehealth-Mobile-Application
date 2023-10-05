// ignore_for_file: deprecated_member_use, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
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
    return BlocListener<SideMenuCubit, SideMenuState>(
      listener: (context, state) {
        if (state is SideMenuLoading) {
          EasyLoading.show();
        } else if (state is LogoutActionState) {
          EasyLoading.dismiss();
          Navigator.pushReplacementNamed(context, logInName);
        } else if (state is ErrorActionState) {
          EasyLoading.dismiss();
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
                AppController.instance.authState == AuthState.AllAuthorized
                    ? ListTile(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, mainScreenDoctorName);
                        },
                        title: Text(
                          translate(context, 'Phòng khám của tôi'),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: white),
                        ),
                        leading: FaIcon(
                          FontAwesomeIcons.houseMedical,
                          size: dimensIcon() * .5,
                          color: white,
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: EdgeInsets.only(
                      top: dimensHeight() * 2,
                      left: dimensWidth() * 2,
                      bottom: dimensHeight()),
                  child: Text(
                    translate(context, 'general'),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: white),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, contactName);
                  },
                  title: Text(
                    translate(context, 'edit_contact_info'),
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
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, changePasswordName);
                  },
                  title: Text(
                    translate(context, 'change_password'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: white),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.lock,
                    size: dimensIcon() * .5,
                    color: white,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, walletName);
                  },
                  title: Text(
                    translate(context, 'wallet'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: white),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.wallet,
                    size: dimensIcon() * .5,
                    color: white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: dimensHeight() * 3,
                      left: dimensWidth() * 2,
                      bottom: dimensHeight()),
                  child: Text(
                    translate(context, 'supports'),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: white),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, faqsName);
                  },
                  title: Text(
                    translate(context, 'FAQs'),
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
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, termsAndConditionsName);
                  },
                  title: Text(
                    translate(context, 'terms_and_conditions'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: white),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.fileContract,
                    size: dimensIcon() * .5,
                    color: white,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, privacyPolicyName);
                  },
                  title: Text(
                    translate(context, 'privacy_policy'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: white),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.shieldHalved,
                    size: dimensIcon() * .5,
                    color: white,
                  ),
                ),
                const Spacer(),
                ListTile(
                  onTap: () {
                    AppLocalizations.of(context).isVnLocale
                        ? context.read<ResCubit>().toEnglish()
                        : context.read<ResCubit>().toVietnamese();
                  },
                  title: Text(
                    AppLocalizations.of(context).isVnLocale
                        ? translate(context, 'en')
                        : translate(context, 'vi'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: white),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.language,
                    size: dimensIcon() * .5,
                    color: white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: dimensHeight() * 5),
                  child: ListTile(
                    onTap: () {
                      // RestClient().logout();
                      context.read<SideMenuCubit>().logout();
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.arrowRightFromBracket,
                      size: dimensIcon() * .7,
                      color: Colors.yellow,
                    ),
                    title: Text(
                      translate(context, 'log_out'),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(color: Colors.yellow),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
