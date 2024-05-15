import 'package:flutter/material.dart';
import 'package:healthline/data/api/models/responses/prescription_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class ContentDrug extends StatelessWidget {
  const ContentDrug({super.key, required this.index, required this.drugModal});
  final int? index;
  final DrugModal drugModal;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${index ?? ''}",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: white),
            ),
            SizedBox(
              width: dimensWidth() * 2,
            ),
            Expanded(
              child: Text(
                drugModal.name ?? translate(context, "undifine"),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: white),
              ),
            ),
            SizedBox(
              width: dimensWidth() * 2,
            ),
            Text(
              "SL",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: white),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: dimensWidth() * 3,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "${translate(context, 'types')}: ",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: white,
                            ),
                      ),
                      Expanded(
                        child: Text(
                          drugModal.type ?? translate(context, "undefine"),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: white),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: white,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          drugModal.note ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: dimensWidth() * 2,
            ),
            Text(
              "${drugModal.quantity ?? 0}",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: white),
            ),
          ],
        ),
      ],
    );
  }
}
