import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/translate.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: white,
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
        children: [
          ListTile(
            onTap: () async {
              Navigator.pushNamed(context, updateProfileDoctorName);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                dimensWidth(),
              ),
            ),
            dense: true,
            visualDensity: const VisualDensity(vertical: 0),
            title: Text(
              translate(context, 'update_profile'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: color1F1F1F),
            ),
            leading: FaIcon(
              FontAwesomeIcons.solidAddressCard,
              size: dimensIcon() * .7,
              color: color1F1F1F,
            ),
            trailing:
                FaIcon(FontAwesomeIcons.chevronRight, size: dimensIcon() * .5),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, changePasswordName);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                dimensWidth(),
              ),
            ),
            dense: true,
            visualDensity: const VisualDensity(vertical: 0),
            title: Text(
              translate(context, 'change_password'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: color1F1F1F),
            ),
            leading: FaIcon(
              FontAwesomeIcons.lock,
              size: dimensIcon() * .7,
              color: color1F1F1F,
            ),
            trailing:
                FaIcon(FontAwesomeIcons.chevronRight, size: dimensIcon() * .5),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, walletName);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                dimensWidth(),
              ),
            ),
            dense: true,
            visualDensity: const VisualDensity(vertical: 0),
            title: Text(
              translate(context, 'wallet'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: color1F1F1F),
            ),
            leading: FaIcon(
              FontAwesomeIcons.wallet,
              size: dimensIcon() * .7,
              color: color1F1F1F,
            ),
            trailing:
                FaIcon(FontAwesomeIcons.chevronRight, size: dimensIcon() * .5),
          ),
        ],
      ),
    );
  }
}
