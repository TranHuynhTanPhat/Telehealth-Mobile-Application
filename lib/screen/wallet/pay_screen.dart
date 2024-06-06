import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/bloc/cubits/cubit_wallet/wallet_cubit.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({
    super.key,
  });

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabPayController;
  final rechargeController = TextEditingController();
  final withdrawController = TextEditingController();

  PaymentMethod checkMomo = PaymentMethod.None;

  @override
  void initState() {
    tabPayController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is WalletRecharge) {
          if (state.blocState == BlocState.Successed) {
            Navigator.pop(context, "success");
          }
        }
      },
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state.blocState == BlocState.Pending,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: white,
              extendBody: true,
              appBar: AppBar(
                title: Text(
                  "${translate(context, 'recharge')}/${translate(context, 'withdraw')}",
                ),
              ),
              body: GestureDetector(
                onTap: () => KeyboardUtil.hideKeyboard(context),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: dimensHeight()),
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: dimensHeight() * 2),
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: dimensWidth() * 3),
                                child: TabBar(
                                  controller: tabPayController,
                                  splashBorderRadius:
                                      BorderRadius.circular(dimensWidth() * 2),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  labelColor: white,
                                  unselectedLabelColor: secondary,
                                  // indicatorPadding: EdgeInsets.symmetric(horizontal: dimensWidth()*3, vertical: dimensHeight()),
                                  indicator: BoxDecoration(
                                    color: secondary,
                                    borderRadius: BorderRadius.circular(
                                        dimensWidth() * 2),
                                  ),
                                  tabs: [
                                    Tab(
                                      text: translate(context, "recharge"),
                                    ),
                                    Tab(
                                      text: translate(context, 'withdraw'),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: tabPayController,
                                  children: [
                                    ListView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(
                                          left: dimensWidth() * 3,
                                          right: dimensWidth() * 3,
                                          top: dimensHeight() * 3),
                                      children: [
                                        TextFieldWidget(
                                          suffix: const Text("VNĐ"),
                                          controller: rechargeController,
                                          textInputType: const TextInputType
                                              .numberWithOptions(
                                            signed: false,
                                          ),
                                          label: translate(context, 'recharge'),
                                          onChanged: (p0) {
                                            String temp =
                                                rechargeController.text;
                                            temp = temp.replaceAll('.', '');
                                            temp = temp.replaceAll('₫', '');
                                            int? num = int.tryParse(temp);
                                            if (num != null) {
                                              rechargeController.text =
                                                  convertToVND(num);
                                              int l = rechargeController
                                                  .text.length;
                                              if (l > 2) l -= 2;
                                              rechargeController.selection =
                                                  TextSelection.fromPosition(
                                                TextPosition(offset: l),
                                              );
                                            } else {
                                              rechargeController.text = "";
                                            }
                                          },
                                          validate: (value) => null,
                                        ),
                                        SizedBox(
                                          height: dimensHeight() * 3,
                                        ),
                                        RadioListTile<PaymentMethod>(
                                          title: Row(
                                            children: [
                                              Container(
                                                width: dimensWidth() * 5,
                                                height: dimensWidth() * 5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    dimensWidth(),
                                                  ),
                                                ),
                                                alignment: Alignment.centerLeft,
                                                child:
                                                    Image.asset(DImages.mono),
                                              ),
                                              SizedBox(
                                                width: dimensWidth(),
                                              ),
                                              Text(
                                                translate(
                                                    context, "payment_by_momo"),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              )
                                            ],
                                          ),
                                          value: PaymentMethod.Momo,
                                          groupValue: checkMomo,
                                          onChanged: (PaymentMethod? value) {
                                            setState(() {
                                              checkMomo = PaymentMethod.Momo;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: dimensHeight() * 3,
                                        ),
                                        ElevatedButtonWidget(
                                            text:
                                                translate(context, 'recharge'),
                                            onPressed: rechargeController
                                                        .text.isEmpty &&
                                                    checkMomo ==
                                                        PaymentMethod.Momo
                                                ? null
                                                : () {
                                                    String temp =
                                                        rechargeController.text;
                                                    temp = temp.replaceAll(
                                                        '.', '');
                                                    temp = temp.replaceAll(
                                                        '₫', '');
                                                    int? amount =
                                                        int.tryParse(temp);
                                                    if (amount != null) {
                                                      context
                                                          .read<WalletCubit>()
                                                          .recharge(
                                                              amount: amount);
                                                    }
                                                  })
                                      ],
                                    ),
                                    ListView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(
                                          left: dimensWidth() * 3,
                                          right: dimensWidth() * 3,
                                          top: dimensHeight() * 3),
                                      children: [
                                        TextFieldWidget(
                                          suffix: const Text("VNĐ"),
                                          controller: withdrawController,
                                          textInputType: const TextInputType
                                              .numberWithOptions(
                                            signed: false,
                                          ),
                                          label: translate(context, 'withdraw'),
                                          onChanged: (p0) {
                                            String temp =
                                                withdrawController.text;
                                            temp = temp.replaceAll('.', '');
                                            temp = temp.replaceAll('₫', '');
                                            int? num = int.tryParse(temp);
                                            if (num != null) {
                                              withdrawController.text =
                                                  convertToVND(num);
                                              int l = withdrawController
                                                  .text.length;
                                              if (l > 2) l -= 2;
                                              withdrawController.selection =
                                                  TextSelection.fromPosition(
                                                TextPosition(offset: l),
                                              );
                                            } else {
                                              withdrawController.text = "";
                                            }
                                          },
                                          validate: (value) => null,
                                        ),
                                        SizedBox(
                                          height: dimensHeight() * 3,
                                        ),
                                        ElevatedButtonWidget(
                                            text:
                                                translate(context, 'withdraw'),
                                            onPressed: withdrawController
                                                        .text.isEmpty
                                                ? null
                                                : () {
                                                    String temp =
                                                        withdrawController.text;
                                                    temp = temp.replaceAll(
                                                        '.', '');
                                                    temp = temp.replaceAll(
                                                        '₫', '');
                                                    int? amount =
                                                        int.tryParse(temp);
                                                    if (amount != null) {
                                                      context
                                                          .read<WalletCubit>()
                                                          .withdraw(
                                                              amount: amount);
                                                    }
                                                  })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
