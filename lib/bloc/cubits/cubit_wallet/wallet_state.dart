part of 'wallet_cubit.dart';

sealed class WalletState {
  const WalletState({required this.blocState,  this.error});
  final BlocState blocState;
  final String? error;
}

final class WalletInitial extends WalletState {
  WalletInitial({required super.blocState,  super.error});
}

final class WalletRecharge extends WalletState {
  WalletRecharge({required super.blocState,  super.error});
}
