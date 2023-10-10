import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/badge_notification.dart';
import 'package:healthline/utils/translate.dart';

class LabelDrawer extends StatefulWidget {
  const LabelDrawer(
      {super.key,
      required this.active,
      this.press,
      required this.label,
      required this.icon,
      this.isShowBadge = false});
  final bool active;
  final String label;
  final IconData icon;
  final Function()? press;
  final bool isShowBadge;

  @override
  State<LabelDrawer> createState() => _LabelDrawerState();
}

class _LabelDrawerState extends State<LabelDrawer> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastEaseInToSlowEaseOut,
          margin: EdgeInsets.only(
            right: dimensWidth(),
          ),
          decoration: BoxDecoration(
            color: primary.withOpacity(.2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  dimensWidth() * 2,
                ),
                bottomRight: Radius.circular(
                  dimensWidth() * 2,
                )),
          ),
          width: widget.active == true ? dimensWidth() * 40 : 0,
          height: dimensHeight() * 7,
        ),
        Container(
          width: dimensWidth() * 40,
          height: dimensHeight() * 7,
          alignment: Alignment.center,
          child: ListTile(
            focusColor: transparent,
            hoverColor: transparent,
            splashColor: transparent,
            onTap: widget.press,
            dense: true,
            visualDensity: const VisualDensity(vertical: 0),
            title: Text(
              translate(context, widget.label),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: color1F1F1F),
            ),
            leading: badgeNotification(
                FaIcon(
                  widget.icon,
                  size: dimensIcon() * .5,
                  color: color1F1F1F,
                ),
                widget.isShowBadge,
                Theme.of(context).colorScheme.error,
                -10,
                -10),
          ),
        ),
      ],
    );
  }
}
