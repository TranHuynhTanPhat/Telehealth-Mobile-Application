import 'package:flutter/material.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/res/style.dart';

class MessageBoxSendTop extends StatelessWidget {
  const MessageBoxSendTop({super.key, required this.message});
  final String message;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(top: dimensHeight() / 4),
          padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(180),
                topRight: const Radius.circular(180),
                bottomLeft: const Radius.circular(180),
                bottomRight: Radius.circular(dimensWidth()*5)
              ),
              color: secondary),
          child: Text(
            message,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: white, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
