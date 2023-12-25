import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/utils/translate.dart';

class HelpsScreen extends StatelessWidget {
  const HelpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: FaIcon(
              FontAwesomeIcons.question,
              color: color1F1F1F.withOpacity(.05),
              size: dimensWidth() * 110,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3, vertical: dimensHeight()),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, faqsName);
                  },
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  title: Text(
                    translate(context, 'FAQs'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: color1F1F1F),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.circleQuestion,
                    size: dimensIcon() * .7,
                    color: color1F1F1F,
                  ),
                  trailing: FaIcon(FontAwesomeIcons.chevronRight,
                      size: dimensIcon() * .5),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, termsAndConditionsName);
                  },
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  title: Text(
                    translate(context, 'terms_and_conditions'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: color1F1F1F),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.fileContract,
                    size: dimensIcon() * .7,
                    color: color1F1F1F,
                  ),
                  trailing: FaIcon(FontAwesomeIcons.chevronRight,
                      size: dimensIcon() * .5),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, privacyPolicyName);
                  },
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  title: Text(
                    translate(context, 'privacy_policy'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: color1F1F1F),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.shieldHalved,
                    size: dimensIcon() * .7,
                    color: color1F1F1F,
                  ),
                  trailing: FaIcon(FontAwesomeIcons.chevronRight,
                      size: dimensIcon() * .5),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, privacyPolicyName);
                  },
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  title: Text(
                    translate(context, 'bug_report'),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: color1F1F1F),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.comments,
                    size: dimensIcon() * .7,
                    color: color1F1F1F,
                  ),
                  trailing: FaIcon(FontAwesomeIcons.chevronRight,
                      size: dimensIcon() * .5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
