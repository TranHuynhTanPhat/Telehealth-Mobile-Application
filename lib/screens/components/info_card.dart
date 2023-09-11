
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.name,
    required this.profession,
  });
  final String name, profession;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colorA8B1CE,
        radius: dimensWidth() * 4,
        child: FaIcon(
          FontAwesomeIcons.user,
          color: white,
          size: dimensIcon(),
        ),
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: white),
      ),
      subtitle: Text(
        profession,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(color: white.withOpacity(.5)),
      ),
    );
  }
}
