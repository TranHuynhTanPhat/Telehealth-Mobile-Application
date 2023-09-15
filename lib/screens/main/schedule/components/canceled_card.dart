import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';

class CanceledCard extends StatelessWidget {
  const CanceledCard({super.key, required this.object});
  final Map<String, dynamic> object;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: dimensHeight() * 2),
      padding: EdgeInsets.symmetric(
          horizontal: dimensWidth() * 2, vertical: dimensWidth() * 2),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: color6A6E83.withOpacity(.2),
                style: BorderStyle.solid,
                width: 2,
                strokeAlign: BorderSide.strokeAlignInside)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: dimensWidth() * 32,
                    child: Text(
                      "${AppLocalizations.of(context).translate('dr')}. ${AppLocalizations.of(context).translate(object['dr'])}",
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: color6A6E83, fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    width: dimensWidth() * 32,
                    child: Text(
                      AppLocalizations.of(context)
                          .translate(object['specialist']),
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: color6A6E83, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Text(
                    "${AppLocalizations.of(context).translate('patient')}: ${object['patient']}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: color6A6E83),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.clock,
                    color: color6A6E83,
                    size: dimensWidth() * 2,
                  ),
                  SizedBox(
                    width: dimensWidth(),
                  ),
                  Text(
                    object['begin'].format(context).toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth() * .3,
                  ),
                  Text(
                    "-",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth() * .3,
                  ),
                  Text(
                    object['end'].format(context).toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatDayMonthYear(context, object['date']),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context).translate(object['status']),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: color6A6E83, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth(),
                  ),
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    color: color6A6E83,
                    size: dimensWidth() * 2,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
