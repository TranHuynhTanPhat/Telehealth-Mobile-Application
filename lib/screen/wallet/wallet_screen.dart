import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubit_wallet/wallet_cubit.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_pages.dart';
import 'package:healthline/screen/wallet/components/exports.dart';
import 'package:healthline/screen/wallet/pay_screen.dart';
import 'package:healthline/utils/translate.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // late TextEditingController _controller;
  @override
  void initState() {
    if (!mounted) return;
    tabController = TabController(length: 2, vsync: this);

    // _controller = TextEditingController();
    if (AppController().authState == AuthState.PatientAuthorized) {
      context.read<PatientProfileCubit>().fetchProfile();
    }
    if (AppController().authState == AuthState.DoctorAuthorized) {
      context.read<DoctorProfileCubit>().fetchProfile();
    }
    context.read<WalletCubit>().transaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state.blocState == BlocState.Pending) {
          EasyLoading.show(maskType: EasyLoadingMaskType.black);
        } else if (state.blocState == BlocState.Successed) {
          EasyLoading.showToast(translate(context, 'successfully'));
        } else if (state.blocState == BlocState.Failed) {
          EasyLoading.showToast(translate(context, 'failure'));
        }
      },
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state.blocState == BlocState.Pending,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              extendBody: true,
              backgroundColor: white,
              body: CustomScrollView(shrinkWrap: true, slivers: [
                if (AppController().authState == AuthState.DoctorAuthorized)
                  const WalletCardDoctor(),
                if (AppController().authState == AuthState.PatientAuthorized)
                  const WalletCardPatient(),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: false,
                  toolbarHeight: dimensHeight() * 15,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: dimensWidth(),
                                  vertical: dimensHeight(),
                                ),
                                margin:
                                    EdgeInsets.only(bottom: dimensHeight() * 2),
                                child: InkWell(
                                  onTap: () async {
                                    Navigator.pushNamed(context, payName)
                                        .then((value) {
                                      if (AppController().authState ==
                                          AuthState.PatientAuthorized) {
                                        context
                                            .read<PatientProfileCubit>()
                                            .fetchProfile();
                                      }
                                      if (AppController().authState ==
                                          AuthState.DoctorAuthorized) {
                                        context
                                            .read<DoctorProfileCubit>()
                                            .fetchProfile();
                                      }
                                    });
                                  },
                                  focusColor: transparent,
                                  hoverColor: transparent,
                                  splashColor: transparent,
                                  child: Column(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.rightFromBracket,
                                        size: dimensIcon(),
                                        color: secondary,
                                      ),
                                      Text(
                                        "${translate(context, 'recharge')}/${translate(context, 'withdraw')}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensHeight() * 2),
                            child: Text(
                              translate(context, 'transaction_history'),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          // TabBar(
                          //   controller: tabController,
                          //   tabs: [
                          //     Tab(
                          //       text: translate(context, "booking_history"),
                          //     ),
                          //     Tab(
                          //       text: translate(context, 'cash_flow'),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const TransactionHistoryCard(),
                      SizedBox(
                        height: dimensHeight() * 30,
                      ),
                    ],
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: Container(
                //     padding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
                //     height: MediaQuery.of(context).size.height,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Expanded(
                //           child: TabBarView(
                //             controller: tabController,
                //             children: [
                //               const TransactionHistoryCard(),
                //               Column(
                //                 children: [
                //                   const BarChartWidget(
                //                     groupData: [
                //                       0.0,
                //                       0.0,
                //                       0.0,
                //                       300000.0,
                //                       0.0,
                //                       0.0,
                //                       0.0,
                //                       0.0,
                //                       0.0,
                //                       0.0,
                //                       0.0,
                //                       0.0
                //                     ],
                //                     bottomTitles: [
                //                       "Jan",
                //                       "Feb",
                //                       "Mar",
                //                       "Apr",
                //                       "May",
                //                       "Jun",
                //                       "Jul",
                //                       "Aug",
                //                       "Sep",
                //                       "Oct",
                //                       "Nov",
                //                       "Dec"
                //                     ],
                //                   ),
                //                   Padding(
                //                     padding: EdgeInsets.symmetric(
                //                         horizontal: dimensWidth() * 3),
                //                     child: Column(
                //                       children: [
                //                         Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.end,
                //                           children: [
                //                             const Text("Tổng chi tiêu"),
                //                             Text(
                //                               convertToVND(10),
                //                               style: Theme.of(context)
                //                                   .textTheme
                //                                   .labelMedium,
                //                             ),
                //                           ],
                //                         ),
                //                         Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.end,
                //                           children: [
                //                             const Text("So với tháng trước"),
                //                             Text(
                //                               "10%",
                //                               style: Theme.of(context)
                //                                   .textTheme
                //                                   .labelMedium
                //                                   ?.copyWith(color: Colors.red),
                //                             ),
                //                           ],
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ]),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> showInputRechargeWithdraw() {
    return showModalBottomSheet(
        context: context,
        builder: (ctx) {
          WalletCubit walletCubit = context.read<WalletCubit>();

          return BlocProvider(
            create: (context) => walletCubit,
            child: const PayScreen(),
          );
        });
  }
}
