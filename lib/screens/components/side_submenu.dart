import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';

class SideSubMenu extends StatelessWidget {
  const SideSubMenu({
    super.key,
    required this.press,
    required this.name,
    required this.icon,
     this.color = white,
  });

  final VoidCallback press;
  final String name;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: FaIcon(
        icon,
        size: dimensIcon()*.7,
        color: color,
      ),
      title: Text(
        name,
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: color),
      ),
    );
  }
}
