import 'package:flutter/material.dart';
import 'package:healthline/data/api/models/responses/statistic_response.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/translate.dart';

class StatisticTable extends StatefulWidget {
  const StatisticTable({super.key, required this.statisticResponse});
  final StatisticResponse statisticResponse;

  @override
  State<StatisticTable> createState() => _StatisticTableState();
}

class _StatisticTableState extends State<StatisticTable> {
  List<String> headers = [
    "type_of_service",
    "quantity",
    "pending",
    "confirmed",
    "sales",
    "finished",
    "discount",
    "denied",
    "cancel",
    "revenue"
  ];


  @override
  Widget build(BuildContext context) {
    List<dynamic> row = [];
    List<dynamic> footers = [];
    StatisticResponse data = widget.statisticResponse;

    row.addAll([
      data.typeOfService,
      data.quantity,
      data.pending,
      data.confirmed,
      data.sales,
      data.finished,
      data.discount,
      data.denied,
      data.canceled,
      data.revenue
    ]);
    footers.addAll([
      data.quantity,
      data.pending,
      data.confirmed,
      data.sales,
      data.finished,
      data.discount,
      data.denied,
      data.canceled,
      data.revenue
    ]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
          child: Text(
            translate(context, 'statistics'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
          child: DataTable(
              border: TableBorder.all(width: 1, color: colorF2F5FF),
              columns: [
                ...headers.map(
                  (e) => DataColumn(
                      label: Expanded(
                    child: Text(
                      translate(context, e),
                      textAlign: TextAlign.center,
                    ),
                  )),
                ),
              ],
              rows: [
                DataRow(
                  cells: row
                      .map((e) => DataCell(
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                translate(context, "$e"),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                DataRow(
                  color: const MaterialStatePropertyAll(colorF2F5FF),
                  cells: [
                    DataCell(
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          translate(context, 'total'),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                    ...footers.map(
                      (e) => DataCell(
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "$e",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]),
        ),
      ],
    );
  }
}
