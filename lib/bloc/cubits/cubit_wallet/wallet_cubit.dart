import 'package:bloc/bloc.dart';
import 'package:healthline/data/api/models/responses/momo_response.dart';
import 'package:healthline/data/api/models/responses/transaction_response.dart';
import 'package:healthline/repositories/wallet_repository.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:url_launcher/url_launcher.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit()
      : super(WalletInitial(blocState: BlocState.Successed, transactions: []));
  final WalletRepository _walletRepository = WalletRepository();
  @override
  void onChange(Change<WalletState> change) {
    super.onChange(change);
    logPrint("$change: ${state.blocState}");
  }

  Future<void> recharge({required int amount}) async {
    emit(WalletRecharge(
        blocState: BlocState.Pending, transactions: state.transactions));
    try {
      MomoResponse response = await _walletRepository.recharge(amount: amount);
      Uri? uri = Uri.tryParse(response.applink ?? '');
      if (!await launchUrl(
        uri!,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception("failed");
      }
      emit(WalletRecharge(
          blocState: BlocState.Successed, transactions: state.transactions));
    } catch (e) {
      emit(WalletRecharge(
          blocState: BlocState.Failed,
          error: 'failed',
          transactions: state.transactions));
    }
  }

  Future<void> withdraw({required int amount}) async {
    emit(WalletWithdraw(
        blocState: BlocState.Pending, transactions: state.transactions));
    try {
      await _walletRepository.withdraw(amount: amount);

      emit(WalletWithdraw(
          blocState: BlocState.Successed, transactions: state.transactions));
    } catch (e) {
      emit(WalletWithdraw(
          blocState: BlocState.Failed,
          error: 'failed',
          transactions: state.transactions));
    }
  }

  Future<void> transaction() async {
    emit(WalletTransaction(
        blocState: BlocState.Pending, transactions: state.transactions));
    try {
      List<TransactionResponse> response =
          await _walletRepository.transaction();

      emit(WalletTransaction(
          blocState: BlocState.Successed, transactions: response));
    } catch (e) {
      emit(WalletTransaction(
          blocState: BlocState.Failed,
          error: 'failed',
          transactions: state.transactions));
    }
  }
}
