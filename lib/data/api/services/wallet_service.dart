import 'dart:convert';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/responses/momo_response.dart';
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
}
