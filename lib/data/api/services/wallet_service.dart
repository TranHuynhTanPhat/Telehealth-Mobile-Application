import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/responses/momo_response.dart';
import 'package:healthline/data/api/models/responses/transaction_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class WalletService extends BaseService {
  Future<MomoResponse> recharge({required amount}) async {
    final response = await post(
      ApiConstants.USER_TRANSACTION,
      data: json.encode(
        {"amount": amount},
      ),
    );

    return MomoResponse.fromMap(response.data);
  }

  Future<List<TransactionResponse>> transaction() async {
    final response = await get(
      ApiConstants.USER_TRANSACTION,
      
    );
    List<TransactionResponse> transactions = response.data
        .map<TransactionResponse>(
            (e) => TransactionResponse.fromMap(e))
        .toList();

    return transactions;
  }
  Future<int?> withdraw({required amount}) async {
    final response = await post(
      ApiConstants.USER_TRANSACTION_CASH_OUT,
      data: json.encode(
        {"amount": amount},
      ),
    );

    return response.code;
  }
}
