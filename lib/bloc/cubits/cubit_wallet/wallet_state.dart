part of 'wallet_cubit.dart';

sealed class WalletState {
  const WalletState({required this.blocState,  this.error, required this.transactions});
  final BlocState blocState;
  final String? error;
  final List<TransactionResponse> transactions;
}

final class WalletInitial extends WalletState {
  WalletInitial({required super.blocState,  super.error, required super.transactions});
}

final class WalletRecharge extends WalletState {
  WalletRecharge({required super.blocState,  super.error, required super.transactions});
}
final class WalletWithdraw extends WalletState {
  WalletWithdraw({required super.blocState,  super.error, required super.transactions});
}
final class WalletTransaction extends WalletState {
  WalletTransaction({required super.blocState,  super.error, required super.transactions});
}
