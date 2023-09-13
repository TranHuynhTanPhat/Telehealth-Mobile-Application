import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthline/data/api/rest_client.dart';

part 'side_menu_state.dart';

class SideMenuCubit extends Cubit<SideMenuState> {
  SideMenuCubit() : super(SideMenuInitial());

  Future<void> logoutActionState() async {
    try {
      RestClient().logout();
      emit(LogoutActionState());
    } catch (e) {
      emit(ErrorActionState());
    }
  }
}
