import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/currency_util.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({
    super.key,
    required this.groupData,
    this.bottomTitles,
    this.colorBar,
  });
  final List<String>? bottomTitles;
  final List<double> groupData;
  final Color? colorBar;

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  late double maxValue;
  late int exp;

  late int maxStep;

  late double maxY;

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
            if (rod.toY != 0) {
              return BarTooltipItem(
                convertToVND(rod.toY * pow(10, exp)),
                const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              );
            }return null;
          },
        ),
      );

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: black26,
      fontWeight: FontWeight.normal,
      fontSize: 10,
    );
    if (widget.bottomTitles == null) return Container();
    String text = widget.bottomTitles![value.toInt()];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: black26,
      fontWeight: FontWeight.normal,
      fontSize: 8,
    );

    String text;
    if (value % maxStep == 0) {
      text = convertToVND((value * pow(10, exp)));
    } else {
      return const SizedBox.shrink();
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
            getTitlesWidget: getBottomTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: 1,
            getTitlesWidget: getLeftTitles,
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
        ...widget.groupData.asMap().map(
          (key, value) {
            // print(key);
            // print(value / (10 ^ exp));
            return MapEntry(
              key,
              BarChartGroupData(
                x: key,
                barRods: [
                  BarChartRodData(
                    toY: value / pow(10, exp),
                    color: widget.colorBar ?? primary,
                    width: dimensWidth() * 3,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(dimensWidth()),
                      topRight: Radius.circular(dimensWidth()),
                    ),
                  ),
                ],
                showingTooltipIndicators: [0],
              ),
            );
          },
        ).values,
        // BarChartGroupData(
        //   x: 0,

        //   // showingTooltipIndicators: [0],
        // ),
        // BarChartGroupData(
        //   x: 1,
        //   barRods: [
        //     BarChartRodData(
        //         toY: 10,
        //         color: colorF2F5FF,
        //         width: dimensWidth() * 4,
        //         borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(dimensWidth()),
        //             topRight: Radius.circular(dimensWidth()))),
        //   ],
        //   // showingTooltipIndicators: [0],
        // ),
        // BarChartGroupData(
        //   x: 2,
        //   barRods: [
        //     BarChartRodData(
        //         toY: 14,
        //         color: colorF2F5FF,
        //         width: dimensWidth() * 4,
        //         borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(dimensWidth()),
        //             topRight: Radius.circular(dimensWidth()))),
        //   ],
        //   // showingTooltipIndicators: [0],
        // ),
        // BarChartGroupData(
        //   x: 3,
        //   barRods: [
        //     BarChartRodData(
        //         toY: 15,
        //         color: colorF2F5FF,
        //         width: dimensWidth() * 4,
        //         borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(dimensWidth()),
        //             topRight: Radius.circular(dimensWidth()))),
        //   ],
        //   // showingTooltipIndicators: [0],
        // ),
        // BarChartGroupData(
        //   x: 4,
        //   barRods: [
        //     BarChartRodData(
        //         toY: 13,
        //         color: Colors.deepOrange,
        //         width: dimensWidth() * 4,
        //         borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(dimensWidth()),
        //             topRight: Radius.circular(dimensWidth()))),
        //   ],
        //   showingTooltipIndicators: [0],
        // ),
      ];

  @override
  Widget build(BuildContext context) {
    maxValue = widget.groupData
        .reduce((currentMax, next) => currentMax > next ? currentMax : next);
    exp = 0;
    double m = maxValue;
    while (m > 10000) {
      exp++;
      m /= 10;
    }

    maxStep = 5;
    while ((maxValue / pow(10, exp)) / maxStep > 10) {
      if (maxStep < 25) {
        maxStep += 5;
      } else if (maxStep < 50) {
        maxStep += 25;
      } else {
        maxStep *= 10;
      }
    }

    maxY = 0;
    while ((maxValue / pow(10, exp)) > maxY) {
      maxY += maxStep;
    }

    // print(maxValue / pow(10, exp));
    // print(maxStep);
    // print(maxY);
    // print(exp);
    // return SizedBox.shrink();
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
          maxY: maxY,
        ),
      ),
    );
  }
}
