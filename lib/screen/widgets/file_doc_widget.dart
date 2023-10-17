import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class FileDocWidget extends StatelessWidget {
  const FileDocWidget({
    super.key, required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          dimensWidth(),
        ),
      ),
      dense: true,
      visualDensity: const VisualDensity(vertical: 0),
      leading: FaIcon(
        FontAwesomeIcons.fileWord,
        size: dimensIcon(),
        color: const Color.fromARGB(255, 13, 105, 181),
      ),
      title: Text(
        translate(context, title),
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: FaIcon(FontAwesomeIcons.chevronRight, size: dimensIcon() * .5),
    );
  }
}