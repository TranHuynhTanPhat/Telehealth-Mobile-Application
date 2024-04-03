import 'package:flutter/material.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/translate.dart';

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
