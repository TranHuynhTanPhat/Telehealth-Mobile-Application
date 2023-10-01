import 'package:healthline/data/api/models/responses/user_response.dart';
import 'package:healthline/data/api/repositories/user_repository.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'health_info_state.dart';

class HealthInfoCubit extends HydratedCubit<HealthInfoState> {
  HealthInfoCubit() : super(HealthInfoInitial([]));
  final UserRepository _userRepository = UserRepository();

  Future<void> fetchProfile() async {
    emit(HealthInfoLoading(state.subUsers));
    try {
      List<UserResponse> userResponses = await _userRepository.fetchProfile();
      emit(HealthInfoLoaded(userResponses));
    } catch (e) {
      logPrint(e.toString());
      emit(HealthInfoError(state.subUsers));
    }
  }

  @override
  HealthInfoState? fromJson(Map<String, dynamic> json) {
    return HealthInfoState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(HealthInfoState state) {
    return state.toMap();
  }
}
