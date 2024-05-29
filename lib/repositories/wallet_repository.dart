// ignore_for_file: unused_field
import 'package:healthline/data/api/models/responses/momo_response.dart';
import 'package:healthline/data/api/services/wallet_service.dart';
import 'package:healthline/repositories/base_repository.dart';

class WalletRepository extends BaseRepository {
  final WalletService _walletService = WalletService();

  Future<MomoResponse> recharge({required amount}) async {
    return await _walletService.recharge(amount: amount);
  }
}
