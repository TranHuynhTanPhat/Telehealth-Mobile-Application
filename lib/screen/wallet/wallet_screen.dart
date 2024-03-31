import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/wallet/components/exports.dart';
import 'package:healthline/screen/widgets/elevated_button_widget.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/log_data.dart';
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
                        children: [const TransactionHistoryCard()],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                        child: Column(
                          children: [
                            const BarChartWidget(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text("Tổng chi tiêu"),
                                Text(
                                  convertToVND(10),
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
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
                      )
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

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    super.key,
  });
  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 0,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );
  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: black26,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mn';
        break;
      case 1:
        text = 'Te';
        break;
      case 2:
        text = 'Wd';
        break;
      case 3:
        text = 'Tu';
        break;
      case 4:
        text = 'Fr';
        break;

      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: black26,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 5) {
      text = '5K';
    } else if (value == 10) {
      text = '10K';
    } else if (value == 15) {
      text = '15K';
    } else if (value == 20) {
      text = '20K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            interval: 1,
            getTitlesWidget: leftTitles,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => Container(),
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );
  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          right: BorderSide.none,
          top: BorderSide.none,
          bottom: BorderSide(width: 1),
          left: BorderSide(width: 1),
        ),
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
                toY: 8,
                color: colorF2F5FF,
                width: dimensWidth() * 4,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(dimensWidth()),
                    topRight: Radius.circular(dimensWidth()))),
          ],
          // showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
                toY: 10,
                color: colorF2F5FF,
                width: dimensWidth() * 4,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(dimensWidth()),
                    topRight: Radius.circular(dimensWidth()))),
          ],
          // showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                toY: 14,
                color: colorF2F5FF,
                width: dimensWidth() * 4,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(dimensWidth()),
                    topRight: Radius.circular(dimensWidth()))),
          ],
          // showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
                toY: 15,
                color: colorF2F5FF,
                width: dimensWidth() * 4,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(dimensWidth()),
                    topRight: Radius.circular(dimensWidth()))),
          ],
          // showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
                toY: 13,
                color: Colors.deepOrange,
                width: dimensWidth() * 4,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(dimensWidth()),
                    topRight: Radius.circular(dimensWidth()))),
          ],
          showingTooltipIndicators: [0],
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
        ),
      ),
    );
  }
}

class TransactionHistoryCard extends StatelessWidget {
  const TransactionHistoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: primary,
        backgroundImage: AssetImage(DImages.placeholder),
        radius: dimensHeight() * 3,
        onBackgroundImageError: (exception, stackTrace) {
          logPrint(exception);
        },
      ),
      title: Text(
        "${translate(context, "make_an_appointment_with")}Dr. John",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "12:56 - 32/03/2024",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            convertToVND(10),
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
