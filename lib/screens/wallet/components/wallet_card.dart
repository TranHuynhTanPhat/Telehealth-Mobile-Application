import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: dimensHeight() * 3, horizontal: dimensWidth() * 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dimensWidth() * 3),
        gradient: const LinearGradient(
          colors: [primary, color9D4B6C],
          stops: [0, 1],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                translate(context, 'service_card'),
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: white),
              ),
              FaIcon(
                FontAwesomeIcons.hospital,
                size: dimensIcon() * 1,
                color: white,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: dimensHeight() * 3, bottom: dimensHeight() * 1.5),
            child: Text(
              'Tran Huynh Tan Phat',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: white),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FaIcon(
                FontAwesomeIcons.wallet,
                size: dimensIcon() * 1,
                color: white,
              ),
              Text(
                '0đ',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: white, fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }
}
