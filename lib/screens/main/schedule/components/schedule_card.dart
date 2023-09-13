import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.object});
  final Map<String, dynamic> object;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: dimensWidth() * 2),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: dimensWidth() * 1.5, vertical: dimensWidth() * 2),
        decoration: BoxDecoration(
          color: colorCDDEFF,
          borderRadius: BorderRadius.all(
            Radius.circular(dimensWidth() * 3),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: (){},
                    child: SizedBox(
                      height: dimensHeight()*.6,
                        child: FaIcon(
                      FontAwesomeIcons.ellipsis,
                      size: dimensWidth() * 2.5,
                      color: color1F1F1F.withOpacity(.4),
                    )),
                  ),
                ))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: dimensImage() * 8,
                  height: dimensImage() * 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        dimensWidth() * 2,
                      ),
                    ),
                    image: DecorationImage(
                      image: AssetImage(object['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: dimensWidth() * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate(
                            object['time'].format(context).toString()),
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: color1F1F1F),
                      ),
                      Text(
                        AppLocalizations.of(context).translate(object['dr']),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: color1F1F1F,
                                fontWeight: FontWeight.w900),
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate(object['description']),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: color1F1F1F),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
