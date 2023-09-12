import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/components/info_card.dart';
import 'package:healthline/screens/components/side_menu_title.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final List<Map<String, dynamic>> sideMenus = [
    {"name": "setting", "icon": FontAwesomeIcons.gear},
    {"name": "account_setting", "icon": FontAwesomeIcons.userGear}
  ];
  late Map<String, dynamic> selectedMenu;

  @override
  void initState() {
    selectedMenu = sideMenus.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: dimensWidth() * 50,
        height: double.infinity,
        color: secondary,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                name: "Tran Huynh Tan Phat",
                profession: AppLocalizations.of(context).translate("patient"),
              ),
              ...sideMenus.map((menu) => SideMenuTile(
                    press: () {
                      setState(() {
                        selectedMenu = menu;
                      });
                    },
                    isActive: selectedMenu == menu,
                    name: AppLocalizations.of(context).translate(menu['name']),
                    icon: menu['icon'],
                  )),
                  Spacer(),
              SideMenuTile(
                  press: () {
                    AppLocalizations.of(context).isVnLocale
                        ? context.read<ResCubit>().toEnglish()
                        : context.read<ResCubit>().toVietnamese();
                  },
                  isActive: false,
                  name: AppLocalizations.of(context).isVnLocale
                      ? AppLocalizations.of(context).translate('en')
                      : AppLocalizations.of(context).translate('vi'),
                  icon: FontAwesomeIcons.language)
              // ListTile(
              //   leading: const Icon(Icons.language_rounded),
              //   title: ElevatedButton(
              //     onPressed: ,
              //     child: Text(
              //       AppLocalizations.of(context).isVnLocale
              //           ? AppLocalizations.of(context).translate('en')
              //           : AppLocalizations.of(context).translate('vi'),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
