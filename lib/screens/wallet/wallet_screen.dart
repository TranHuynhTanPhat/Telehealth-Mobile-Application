import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/wallet/components/exports.dart';
import 'package:healthline/utils/translate.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translate(context, 'wallet'),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
            vertical: dimensHeight() * 2, horizontal: dimensWidth() * 3),
        children: [
          const WalletCard(),
          Padding(
            padding: EdgeInsets.only(
                top: dimensHeight() * 4, bottom: dimensHeight() * 1.5),
            child: Text(
              translate(context, 'recharge_with'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          OptionCard(
            name: translate(context, 'transfer'),
            description: translate(context, 'transfer_money_through_banks'),
            icon: SizedBox(
              width: dimensIcon(),
              height: dimensIcon(),
              child: FaIcon(
                FontAwesomeIcons.moneyBillTransfer,
                size: dimensIcon(),
                color: colorDF9F1E,
              ),
            ),
          ),
          OptionCard(
            name: translate(context, 'bank_card'),
            description: translate(
                context, 'transfer_money_via_visa_master_or_bank_card'),
            icon: SizedBox(
              width: dimensIcon(),
              height: dimensIcon(),
              child: FaIcon(
                FontAwesomeIcons.creditCard,
                size: dimensIcon(),
                color: secondary,
              ),
            ),
          ),
          OptionCard(
              name: '${translate(context, 'wallet')} Momo',
              description: translate(context, 'recharge_via_momo_application'),
              icon: SizedBox(
                width: dimensIcon(),
                height: dimensIcon(),
                child: Image.asset(
                  DImages.mono,
                  fit: BoxFit.cover,
                  scale: 1,
                  width: dimensIcon(),
                  height: dimensIcon(),
                ),
              )),
        ],
      ),
    );
  }
}
