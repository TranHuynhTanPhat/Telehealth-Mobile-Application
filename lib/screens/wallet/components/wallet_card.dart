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
          vertical: dimensHeight() * 4, horizontal: dimensWidth() * 2),
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
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FaIcon(
                FontAwesomeIcons.hospital,
                size: dimensIcon() * .5,
                color: white,
              ),
              SizedBox(
                width: dimensWidth()*.5,
              ),
              Text(
                translate(context, 'Healthline'),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: white, fontWeight: FontWeight.w400, height: 0),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: dimensHeight() * 2, bottom: dimensHeight() * 3),
            child: Text(
              'Tran Huynh Tan Phat',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: white, fontWeight: FontWeight.w900),
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
