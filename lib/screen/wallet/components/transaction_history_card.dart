import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/bloc/cubits/cubit_wallet/wallet_cubit.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/currency_util.dart';
import 'package:healthline/utils/date_util.dart';
import 'package:healthline/utils/translate.dart';

class TransactionHistoryCard extends StatelessWidget {
  const TransactionHistoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Column(
          children: [
            ...state.transactions.map((e) => ListTile(
                  // leading: CircleAvatar(
                  //   backgroundColor: primary,
                  //   backgroundImage: AssetImage(DImages.placeholder),
                  //   radius: dimensHeight() * 3,
                  //   onBackgroundImageError: (exception, stackTrace) {
                  //     logPrint(exception);
                  //   },
                  // ),
                  title: Text(
                    translate(
                        context,
                        e.typePaid == "CashIn"
                            ? "recharge"
                            : e.typePaid == "CashOut"
                                ? "withdraw"
                                : e.typePaid == "Send"
                                    ? "send"
                                    : "receive"),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (e.typePaid == "Send" && AppController().authState==AuthState.PatientAuthorized)
                        Text("${translate(context, 'to')} ${e.doctor?.fullName}")
                      else if (e.typePaid == "Receive" && AppController().authState==AuthState.PatientAuthorized)
                        Text("${translate(context, 'from')} ${e.doctor?.fullName}")
                      else if (e.typePaid == "Send" && AppController().authState==AuthState.DoctorAuthorized)
                        Text("${translate(context, 'to')} ${e.user?.fullName}")
                      else if (e.typePaid == "Receive" && AppController().authState==AuthState.DoctorAuthorized)
                        Text("${translate(context, 'from')} ${e.user?.fullName}"),
                      Text(
                        formatFullDate(
                            context,
                            convertStringToDateTime(e.createdAt!) ??
                                DateTime.now()),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        convertToVND(e.amount ?? 0),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )),
          ],
        );
      },
    );
  }
}
