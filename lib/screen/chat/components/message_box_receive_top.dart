import 'package:flutter/material.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/res/style.dart';

class MessageBoxReceiveTop extends StatelessWidget {
  const MessageBoxReceiveTop({super.key, required this.message});
  final String message;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: dimensHeight() / 4),
          padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 2, vertical: dimensHeight() * 2),
          decoration:  BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(180),
                topRight: const Radius.circular(180),
                bottomRight: const Radius.circular(180),
                bottomLeft: Radius.circular(dimensWidth()*5)
              ),
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
