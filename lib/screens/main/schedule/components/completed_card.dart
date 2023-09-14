import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';

class CompletedCard extends StatelessWidget {
  const CompletedCard({super.key, required this.object});
  final Map<String, dynamic> object;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: dimensHeight() * 2),
      padding: EdgeInsets.symmetric(
          horizontal: dimensWidth() * 2, vertical: dimensWidth() * 2),
      decoration: BoxDecoration(
        color: colorA8B1CE.withOpacity(.2),
        borderRadius: BorderRadius.all(
          Radius.circular(dimensWidth() * 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${AppLocalizations.of(context).translate('dr')}. ${AppLocalizations.of(context).translate(object['dr'])} - ${AppLocalizations.of(context).translate(object['description'])}",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: color1F1F1F,
                                fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "${AppLocalizations.of(context).translate('patient')}: ${object['patient']}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: color1F1F1F),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                  onTap: () {},
                  child: Text(
                    AppLocalizations.of(context).translate("detail"),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: primary,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic),
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: dimensHeight() * 2, bottom: dimensHeight() * .5),
            child: Text(
              formatFullDate(context, object['date']),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: color1F1F1F, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.clock,
                    color: color1F1F1F,
                    size: dimensWidth() * 2,
                  ),
                  SizedBox(
                    width: dimensWidth(),
                  ),
                  Text(
                    object['begin'].format(context).toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color1F1F1F, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth() * .3,
                  ),
                  Text(
                    "-",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color1F1F1F, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth() * .3,
                  ),
                  Text(
                    object['end'].format(context).toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color1F1F1F, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                AppLocalizations.of(context).translate(object['status']),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: color1F1F1F, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
