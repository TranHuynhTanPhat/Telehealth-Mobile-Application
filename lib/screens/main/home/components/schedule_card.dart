import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, required this.object});
  final Map<String, dynamic> object;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(dimensWidth() * 2),
      decoration: BoxDecoration(
          color: colorCDDEFF,
          borderRadius: BorderRadius.circular(dimensWidth() * 2.5)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: white.withOpacity(.5),
                borderRadius: BorderRadius.circular(
                  dimensWidth() * 1.5,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Text(
                      object['date'].month.toString(),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: secondary, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      object['date'].day.toString(),
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: secondary, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
            )),
        Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.only(
                  left: dimensWidth() * 2,
                  top: dimensWidth(),
                  bottom: dimensWidth() * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      object['time'].format(context).toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: secondary),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      object['dr'],
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: secondary, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)
                          .translate(object['description']),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: secondary),
                    ),
                  )
                ],
              ),
            ))
      ]),
    );
  }
}
