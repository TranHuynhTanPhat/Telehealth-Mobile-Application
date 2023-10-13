import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_patient/account_setting/wallet/components/exports.dart';
import 'package:healthline/utils/translate.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translate(context, 'wallet'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: dimensHeight() * 2, horizontal: dimensWidth() * 3),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                description:
                    translate(context, 'recharge_via_momo_application'),
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
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: dimensHeight() * 4,),
                child: Text(
                  translate(context, 'transaction_history'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              TabBar(
                controller: tabController,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.cloud_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.beach_access_sharp),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const <Widget>[
                    Center(
                      child: Text("It's cloudy here"),
                    ),
                    Center(
                      child: Text("It's rainy here"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
