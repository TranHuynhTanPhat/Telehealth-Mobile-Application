part of 'side_menu_cubit.dart';

sealed class SideMenuState extends Equatable {
  const SideMenuState();

  @override
  List<Object> get props => [];
}

final class SideMenuInitial extends SideMenuState {}

final class SideMenuLoading extends SideMenuState {}

final class SideMenuLoaded extends SideMenuState {}

final class SideMenuError extends SideMenuState {}

final class SideMenuActionState extends SideMenuState{}

final class WalletActionState extends SideMenuActionState{}

final class LogoutActionState extends SideMenuActionState{}

final class ErrorActionState extends SideMenuActionState{}