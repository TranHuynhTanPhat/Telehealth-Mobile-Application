import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../res/style.dart';
import '../../../utils/translate.dart';

class ApplicationSettingScreen extends StatelessWidget {
  const ApplicationSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          translate(context, 'application_setting'),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: dimensWidth()*3),
        children: [
          ListTile(
            onTap: () {
            },
            dense: true,
            visualDensity: const VisualDensity(vertical: 0),
            title: Text(
              translate(context, 'update_application'),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: color1F1F1F),
            ),
            leading: FaIcon(
              FontAwesomeIcons.circleArrowDown,
              size: dimensIcon() * .7,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
