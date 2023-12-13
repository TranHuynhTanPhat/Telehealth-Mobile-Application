import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/translate.dart';

import '../../../bloc/cubits/cubits_export.dart';
import '../../../res/style.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          translate(context, 'account_setting'),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
            vertical: dimensHeight() * 3, horizontal: dimensWidth() * 3),
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, contactName);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                dimensWidth(),
              ),
            ),
            dense: true,
            visualDensity: const VisualDensity(vertical: 0),
            title: Text(
              translate(context, 'edit_contact_info'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: color1F1F1F),
            ),
            leading: FaIcon(
              FontAwesomeIcons.userGear,
              size: dimensIcon() * .7,
              color: color1F1F1F,
            ),
            trailing:
                FaIcon(FontAwesomeIcons.chevronRight, size: dimensIcon() * .7),
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
                FaIcon(FontAwesomeIcons.chevronRight, size: dimensIcon() * .7),
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
                FaIcon(FontAwesomeIcons.chevronRight, size: dimensIcon() * .7),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              // RestClient().logout();
              context.read<AuthenticationCubit>().logout();
              Navigator.pop(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                dimensWidth(),
              ),
            ),
            dense: true,
            visualDensity: const VisualDensity(vertical: 0),
            leading: FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              size: dimensIcon() * .7,
              color: Colors.redAccent,
            ),
            title: Text(
              translate(context, 'log_out'),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}
