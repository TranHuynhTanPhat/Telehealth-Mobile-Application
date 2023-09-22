// ignore_for_file: deprecated_member_use, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/app/cubits/cubit_side_menu/side_menu_cubit.dart';
import 'package:healthline/app/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/components/info_card.dart';
import 'package:healthline/screens/components/side_menu_title.dart';
import 'package:healthline/utils/translate.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late SideMenus selectedMenu;

  @override
  void initState() {
    selectedMenu = SideMenus.home;
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
          Navigator.pushReplacementNamed(context, logInName);
        } else if (state is WalletActionState) {
          EasyLoading.dismiss();
          Navigator.pushNamed(context, walletName);
        } else if (state is ProfileActionState) {
          EasyLoading.dismiss();
          Navigator.pushNamed(context, profileName).then(
            (value) => setState(
              () {
                selectedMenu = SideMenus.home;
              },
            ),
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.infinity,
          color: secondary,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoCard(
                  name: "Tran Huynh Tan Phat",
                  profession: translate(context, 'patient'),
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
                      selectedMenu = SideMenus.home;
                    });
                  },
                  isActive: selectedMenu == SideMenus.home,
                  name: translate(context, 'home'),
                  icon: FontAwesomeIcons.home,
                ),
                SideMenuTile(
                  press: () {
                    setState(() {
                      selectedMenu = SideMenus.edit_profile;
                      context.read<SideMenuCubit>().navigateToProfile();
                    });
                  },
                  isActive: selectedMenu == SideMenus.edit_profile,
                  name: translate(context, 'edit_profile'),
                  icon: FontAwesomeIcons.userGear,
                ),
                SideMenuTile(
                  press: () {
                    setState(() {
                      selectedMenu = SideMenus.wallet;
                      context.read<SideMenuCubit>().navigateToWallet();
                    });
                  },
                  isActive: selectedMenu == SideMenus.wallet,
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
                    setState(() {
                      selectedMenu = SideMenus.faq;
                    });
                  },
                  isActive: selectedMenu == SideMenus.faq,
                  name: translate(context, 'FAQ'),
                  icon: FontAwesomeIcons.circleQuestion,
                ),
                SideMenuTile(
                  press: () {
                    setState(() {
                      selectedMenu = SideMenus.terms_and_conditions;
                    });
                  },
                  isActive: selectedMenu == SideMenus.terms_and_conditions,
                  name: translate(context, 'terms_and_conditions'),
                  icon: FontAwesomeIcons.fileContract,
                ),
                SideMenuTile(
                  press: () {
                    setState(() {
                      selectedMenu = SideMenus.privacy_policy;
                    });
                  },
                  isActive: selectedMenu == SideMenus.privacy_policy,
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
                  isActive: false,
                ),
                Container(
                    margin: EdgeInsets.only(bottom: dimensHeight() * 5),
                    child: ListTile(
                      onTap: () {
                        // RestClient().logout();
                        context.read<SideMenuCubit>().logoutClick();
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

enum SideMenus {
  home,
  edit_profile,
  wallet,
  setting,
  faq,
  terms_and_conditions,
  privacy_policy
}
