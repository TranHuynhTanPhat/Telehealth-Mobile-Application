// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepository) : super(ProfileInitial());
  final UserRepository _userRepository;

  void fetchData(){
    emit(ProfileLoading());
    try{

    }
    catch(e){
      emit(ProfileError());
    }
  }

  Future<void> updateUser(String fullName, String email, String gender, String birthday, String address, String avatar) async {
    emit(ProfileLoading());
    try{
      await _userRepository.updateAccount(fullName, email, gender, birthday, address, avatar);
      emit(ProfileUpdated());
    }
    catch(e){
      emit(ProfileError());
    }
  }
}
