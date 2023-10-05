// ignore_for_file: deprecated_member_use, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/components/info_card.dart';
import 'package:healthline/screen/components/side_menu_title.dart';
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
      // listenWhen: (previous, current) => current is SideMenuActionState,
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
          width: dimensWidth() * 40,
          height: double.infinity,
          color: secondary,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InfoCard(),
                
                SideMenuTile(
                  press: () {
                    setState(() {
                      Navigator.pushReplacementNamed(context, mainScreenDoctorName);
                    });
                  },
                  
                  name: translate(context, 'Phòng khám của tôi'),
                  icon: FontAwesomeIcons.houseMedical,
                ),
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
                SideMenuTile(
                  press: () {
                    setState(() {
                      Navigator.pushNamed(context, contactName);
                    });
                  },
                  
                  name: translate(context, 'edit_contact_info'),
                  icon: FontAwesomeIcons.userGear,
                ),
                SideMenuTile(
                  press: () {
                    setState(() {
                      Navigator.pushNamed(context, changePasswordName);
                    });
                  },
                  
                  name: translate(context, 'change_password'),
                  icon: FontAwesomeIcons.lock,
                ),
                SideMenuTile(
                  press: () {
                    setState(() {
                      Navigator.pushNamed(context, walletName);
                    });
                  },
                  
                  name: translate(context, 'wallet'),
                  icon: FontAwesomeIcons.wallet,
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
                SideMenuTile(
                  press: () {
                    Navigator.pushNamed(context, faqsName);
                  },
                  
                  name: translate(context, 'FAQs'),
                  icon: FontAwesomeIcons.circleQuestion,
                ),
                SideMenuTile(
                  press: () {
                    Navigator.pushNamed(context, termsAndConditionsName);
                  },
                  
                  name: translate(context, 'terms_and_conditions'),
                  icon: FontAwesomeIcons.fileContract,
                ),
                SideMenuTile(
                  press: () {
                    Navigator.pushNamed(context, privacyPolicyName);
                  },
                  
                  name: translate(context, 'privacy_policy'),
                  icon: FontAwesomeIcons.shieldHalved,
                ),
                const Spacer(),
                SideMenuTile(
                  press: () {
                    AppLocalizations.of(context).isVnLocale
                        ? context.read<ResCubit>().toEnglish()
                        : context.read<ResCubit>().toVietnamese();
                  },
                  name: AppLocalizations.of(context).isVnLocale
                      ? translate(context, 'en')
                      : translate(context, 'vi'),
                  icon: FontAwesomeIcons.language,
                  
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
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
