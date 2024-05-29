import 'package:flutter/material.dart';
import 'package:healthline/data/api/models/responses/message_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';

class MessageBoxSendMiddle extends StatelessWidget {
  const MessageBoxSendMiddle({super.key, required this.message});
  final MessageResponse message;

  @override
  Widget build(BuildContext context) {
    DateTime? time = convertStringToDateTime(message.createdAt);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (time != null)
          Text(formatDayMonthYear(context, time),
              style: Theme.of(context).textTheme.bodySmall),
        SizedBox(
          width: dimensWidth(),
        ),
        Container(
          margin: EdgeInsets.only(top: dimensHeight() / 4),
          padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(180),
                  bottomLeft: const Radius.circular(180),
                  topRight: Radius.circular(dimensWidth() * 5),
                  bottomRight: Radius.circular(dimensWidth() * 5)),
              color: secondary),
          child: Text(
            message.text ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: white, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
