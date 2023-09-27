import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';

class UpcomingCard extends StatelessWidget {
  const UpcomingCard({super.key, required this.object});
  final Map<String, dynamic> object;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: dimensHeight() * 2),
      padding: EdgeInsets.symmetric(
          horizontal: dimensWidth() * 2, vertical: dimensWidth() * 2),
      decoration: BoxDecoration(
        color: object['status'] == 'pending'
            ? colorDF9F1E.withOpacity(.2)
            : colorCDDEFF,
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
                  Container(
                    width: dimensImage() * 5,
                    height: dimensImage() * 5,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          100,
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
                          translate(context, object['dr']),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: object['status'] == 'pending'
                                      ? colorDF9F1E
                                      : secondary,
                                  fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          width: dimensWidth() * 30,
                          child: Text(
                            translate(context, object['specialist']),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    color: object['status'] == 'pending'
                                        ? colorDF9F1E
                                        : secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {},
                child: FaIcon(
                  FontAwesomeIcons.ellipsis,
                  size: dimensWidth() * 2.5,
                  color:
                      object['status'] == 'Pending' ? colorDF9F1E : secondary,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: dimensHeight() * 2),
            child: SizedBox(
              width: dimensWidth() * 30,
              child: Text(
                "${translate(context, 'patient')}: ${object['patient']}",
                overflow: TextOverflow.visible,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: object['status'] == 'pending'
                          ? colorDF9F1E
                          : secondary,
                    ),
              ),
            ),
          ),
          Text(
            formatFullDate(context, object['date']),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color:
                      object['status'] == 'pending' ? colorDF9F1E : secondary,
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
                    color:
                        object['status'] == 'pending' ? colorDF9F1E : secondary,
                    size: dimensWidth() * 2,
                  ),
                  SizedBox(
                    width: dimensWidth(),
                  ),
                  Text(
                    object['begin'].format(context).toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: object['status'] == 'pending'
                            ? colorDF9F1E
                            : secondary,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth() * .3,
                  ),
                  Text(
                    "-",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: object['status'] == 'pending'
                            ? colorDF9F1E
                            : secondary,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth() * .3,
                  ),
                  Text(
                    object['end'].format(context).toString(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: object['status'] == 'pending'
                            ? colorDF9F1E
                            : secondary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    translate(context, object['status']),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: object['status'] == 'pending'
                            ? colorDF9F1E
                            : secondary,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: dimensWidth(),
                  ),
                  object['status'] == 'confirmed'
                      ? FaIcon(
                          FontAwesomeIcons.check,
                          color: secondary,
                          size: dimensWidth() * 2,
                        )
                      : FaIcon(
                          FontAwesomeIcons.arrowsRotate,
                          color: colorDF9F1E,
                          size: dimensWidth() * 2,
                        ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
