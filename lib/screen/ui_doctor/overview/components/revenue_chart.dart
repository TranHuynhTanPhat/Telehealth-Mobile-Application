import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:healthline/data/api/models/responses/money_chart_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/widgets/bar_chart.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

class RevenueChart extends StatefulWidget {
  const RevenueChart({super.key, required this.moneyChartResponse});
  final MoneyChartResponse moneyChartResponse;

  @override
  State<RevenueChart> createState() => _RevenueChartState();
}

class _RevenueChartState extends State<RevenueChart> {
  @override
  Widget build(BuildContext context) {
    List<double>? data;
    List<String>? title;
    try {
      data = widget.moneyChartResponse.moneyByMonth!
          .map(
            (e) => (e.totalMoneyThisMonth ?? 0).toDouble(),
          )
          .toList();
    } catch (e) {
      logPrint(e);
    }
    try {
      title = widget.moneyChartResponse.moneyByMonth!.map((e) {
        String month = DateFormat('MMM').format(DateTime(0, e.month ?? 0));

        return month;
      }).toList();
    } catch (e) {
      logPrint(e);
    }
    if (data != null && title != null && data.length == title.length) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
            child: Text(
              translate(context, 'revenue_chart'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          BarChartWidget(
            groupData: data,
            bottomTitles: title,
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
