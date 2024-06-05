import 'package:flutter/material.dart';
import 'package:healthline/data/api/models/responses/message_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/date_util.dart';

class MessageBoxReceiveMiddle extends StatelessWidget {
  const MessageBoxReceiveMiddle({super.key, required this.message});
  final MessageResponse message;

  @override
  Widget build(BuildContext context) {
    DateTime? time = convertStringToDateTime(message.createdAt);

    return Row(
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(top: dimensHeight() / 4),
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(180),
                    bottomRight: const Radius.circular(180),
                    topLeft: Radius.circular(dimensWidth() * 5),
                    bottomLeft: Radius.circular(dimensWidth() * 5)),
                color: primary),
            child: Text(
              message.text ?? "",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: white, fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(
          width: dimensWidth(),
        ),
        if (time != null)
          Text(
            formatFileDate(context, time),
            style: Theme.of(context).textTheme.bodySmall,
          )
      ],
    );
  }
}
