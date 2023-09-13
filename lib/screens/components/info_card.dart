import 'package:flutter/material.dart';
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
        backgroundImage: AssetImage(DImages.anhthe),
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
