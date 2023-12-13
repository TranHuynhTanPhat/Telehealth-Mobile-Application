import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget(
      {super.key,
      this.onTap,
      required this.title,
      required this.leading,
      this.trailing});

  final Function()? onTap;
  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor: transparent,
      hoverColor: transparent,
      splashColor: transparent,
      onTap: onTap,
      dense: true,
      visualDensity: const VisualDensity(vertical: 0),
      title: title,
      leading: leading,
      trailing: trailing,
    );
  }
}
