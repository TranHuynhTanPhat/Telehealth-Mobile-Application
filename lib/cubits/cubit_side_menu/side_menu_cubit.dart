// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/utils/log_data.dart';

part 'side_menu_state.dart';

class SideMenuCubit extends Cubit<SideMenuState> {
  SideMenuCubit() : super(SideMenuInitial());

  Future<void> logout() async {
    emit(SideMenuLoading());
    try {
      await RestClient().logout();
      emit(LogoutActionState());
    } catch (e) {
      logPrint(e);
      emit(LogoutActionState());
    }
  }
}
