import 'package:flutter/material.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/res/style.dart';

class MessageBoxReceiveBottom extends StatelessWidget {
  const MessageBoxReceiveBottom({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: dimensHeight() / 4),
          padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(180),
                  topRight: const Radius.circular(180),
                  bottomRight: const Radius.circular(180),
                  topLeft: Radius.circular(dimensWidth() * 5)),
              color: primary),
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
