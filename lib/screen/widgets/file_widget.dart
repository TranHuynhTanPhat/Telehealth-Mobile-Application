import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class FileWidget extends StatelessWidget {
  const FileWidget({super.key, required this.title, required this.extension});
  final String title;
  // final FaIcon icon;
  final String extension;

  @override
  Widget build(BuildContext context) {
    FaIcon icon;
    if ([
      'doc',
      'docx',
    ].contains(extension)) {
      icon = FaIcon(
            FontAwesomeIcons.fileWord,
            size: dimensIcon(),
            color: const Color.fromARGB(255, 13, 105, 181),
          );
    } else {
      icon = [
            'xls',
            'xlsx',
            'csv',
          ].contains(extension)
            ? FaIcon(
                FontAwesomeIcons.fileExcel,
                size: dimensIcon(),
                color: Colors.green,
              )
            : extension == 'pdf'
                ? FaIcon(
                    FontAwesomeIcons.filePdf,
                    size: dimensIcon(),
                    color: Colors.redAccent,
                  )
                : [
                    'gif',
                    'jpeg',
                    'jpg',
                    'png',
                  ].contains(extension)
                    ? FaIcon(
                        FontAwesomeIcons.fileImage,
                        size: dimensIcon(),
                        color: colorDF9F1E,
                      )
                    : [
                        '3gp',
                        'asf',
                        'avi',
                        'm4u',
                        'm4v',
                        'mov',
                        'mp4',
                        'mpe',
                        'mpeg',
                        'mpg',
                        'mpg4',
                      ].contains(extension)
                        ? FaIcon(
                            FontAwesomeIcons.fileVideo,
                            size: dimensIcon(),
                            color: color009DC7,
                          )
                        : [
                            'pps',
                            'ppt',
                            'pptx',
                          ].contains(extension)
                            ? FaIcon(
                                FontAwesomeIcons.filePowerpoint,
                                size: dimensIcon(),
                                color: color9D4B6C,
                              )
                            : FaIcon(
                                FontAwesomeIcons.file,
                                size: dimensIcon(),
                                color: black26,
                              );
    }
    return ListTile(
      onTap: null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          dimensWidth(),
        ),
      ),
      dense: true,
      visualDensity: const VisualDensity(vertical: 0),
      leading: icon,

      title: Row(
        children: [
          Expanded(
            child: Text(
              translate(context, title),
              overflow: TextOverflow.visible,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
      // trailing: FaIcon(FontAwesomeIcons.chevronRight, size: dimensIcon() * .5),
    );
  }
}