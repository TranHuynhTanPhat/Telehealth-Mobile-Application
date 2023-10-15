
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../res/style.dart';

class FilePdfWidget extends StatelessWidget {
  const FilePdfWidget({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          dimensWidth(),
        ),
      ),
      leading: FaIcon(
        FontAwesomeIcons.filePdf,
        size: dimensIcon(),
        color: Colors.redAccent,
      ),
      dense: true,
      visualDensity: const VisualDensity(vertical: 0),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: FaIcon(FontAwesomeIcons.chevronRight,
          size: dimensIcon() * .5),
    );
  }
}
