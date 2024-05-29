import 'package:bloc/bloc.dart';
import 'package:healthline/data/api/models/responses/momo_response.dart';
import 'package:healthline/repositories/wallet_repository.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:url_launcher/url_launcher.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial(blocState: BlocState.Successed));
  final WalletRepository _walletRepository = WalletRepository();
  @override
  void onChange(Change<WalletState> change) {
    super.onChange(change);
    logPrint("$change: ${state.blocState}");
  }

  Future<void> recharge({required int amount}) async {
    emit(WalletRecharge(blocState: BlocState.Pending));
    try {
      MomoResponse response = await _walletRepository.recharge(amount: amount);
      Uri? uri = Uri.tryParse(response.applink ?? '');
      if (!await launchUrl(
        uri!,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception("failed");
      }
      emit(WalletRecharge(blocState: BlocState.Successed));
    } catch (e) {
      emit(WalletRecharge(blocState: BlocState.Failed, error: 'failed'));
    }
  }
}
