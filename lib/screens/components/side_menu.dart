import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    {"name": "Setting", "icon": FontAwesomeIcons.gear},
    {"name": "Account setting", "icon": FontAwesomeIcons.userGear}
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InfoCard(
              name: "Tran Huynh Tan Phat",
              profession: "Patient",
            ),
            ...sideMenus.map((menu) => SideMenuTile(
                  press: () {
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isActive: selectedMenu == menu,
                  name: menu['name'],
                  icon: menu['icon'],
                )),
          ],
        ),
      ),
    );
  }
}
