import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/wallet/components/exports.dart';

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
          AppLocalizations.of(context).translate('wallet'),
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
              AppLocalizations.of(context).translate('recharge_with'),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          OptionCard(
            name: AppLocalizations.of(context).translate('transfer'),
            description: AppLocalizations.of(context)
                .translate('transfer_money_through_banks'),
            icon: FaIcon(
              FontAwesomeIcons.moneyBillTransfer,
              size: dimensIcon(),
              color: colorDF9F1E,
            ),
          ),
          OptionCard(
            name: AppLocalizations.of(context).translate('bank_card'),
            description: AppLocalizations.of(context)
                .translate('transfer_money_via_visa_master_or_bank_card'),
            icon: FaIcon(
              FontAwesomeIcons.creditCard,
              size: dimensIcon(),
              color: secondary,
            ),
          ),
          OptionCard(
              name: '${AppLocalizations.of(context).translate('wallet')} Momo',
              description: AppLocalizations.of(context)
                  .translate('recharge_via_momo_application'),
              icon: Image.asset(
                DImages.mono,
                scale: 1,
                width: dimensIcon(),
                height: dimensIcon(),
              )),
        ],
      ),
    );
  }
}
