
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';

class FileExcelWidget extends StatelessWidget {
  const FileExcelWidget({
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
      dense: true,
      visualDensity: const VisualDensity(vertical: 0),
      leading: FaIcon(
        FontAwesomeIcons.fileExcel,
        size: dimensIcon(),
        color: Colors.green,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: FaIcon(FontAwesomeIcons.chevronRight,
          size: dimensIcon() * .5),
    );
  }
}

