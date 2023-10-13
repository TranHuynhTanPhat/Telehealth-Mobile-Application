import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'doctor_profile_state.dart';

class DoctorProfileCubit extends Cubit<DoctorProfileState> {
  DoctorProfileCubit() : super(DoctorProfileInitial());
}
