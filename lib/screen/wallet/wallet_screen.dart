import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/wallet/components/exports.dart';
import 'package:healthline/screen/widgets/bar_chart.dart';
import 'package:healthline/utils/currency_util.dart';
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
    tabController = TabController(length: 2, vsync: this);
    // _controller = TextEditingController();
    if (AppController.instance.authState == AuthState.PatientAuthorized) {
      context.read<PatientProfileCubit>().fetProfile();
    }
    if (AppController.instance.authState == AuthState.DoctorAuthorized) {
      context.read<DoctorProfileCubit>().fetchProfile();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(shrinkWrap: true, slivers: [
        SliverAppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(translate(context, 'budget')),
          foregroundColor: white,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [StretchMode.zoomBackground],
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [primary, color9D4B6C],
                  stops: [0, 1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ),
        if (AppController().authState == AuthState.DoctorAuthorized)
          const WalletCardDoctor(),
        if (AppController().authState == AuthState.PatientAuthorized)
          const WalletCardPatient(),
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          floating: false,
          toolbarHeight: dimensHeight() * 3,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    translate(context, 'transaction_history'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TabBar(
                    controller: tabController,
                    tabs: [
                      Tab(
                        text: translate(context, "booking_history"),
                      ),
                      Tab(
                        text: translate(context, 'cash_flow'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      const Column(
                        children: [TransactionHistoryCard()],
                      ),
                      Column(
                        children: [
                          const BarChartWidget(
                            groupData: [
                              0.0,
                              0.0,
                              0.0,
                              300000.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0,
                              0.0
                            ],
                            bottomTitles: [
                              "Jan",
                              "Feb",
                              "Mar",
                              "Apr",
                              "May",
                              "Jun",
                              "Jul",
                              "Aug",
                              "Sep",
                              "Oct",
                              "Nov",
                              "Dec"
                            ],
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: dimensWidth()*3),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text("Tổng chi tiêu"),
                                    Text(
                                      convertToVND(10),
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text("So với tháng trước"),
                                    Text(
                                      "10%",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(color: Colors.red),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
