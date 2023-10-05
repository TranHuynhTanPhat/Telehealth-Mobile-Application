import 'package:healthline/data/storage/models/vaccination_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'vaccination_state.dart';

class VaccinationCubit extends HydratedCubit<VaccinationState> {
  VaccinationCubit() : super(const VaccinationInitial([], []));

  Future<void> fetchData() async {
    emit(VaccinationLoading(state.diseaseAdult, state.diseaseChild));
    try {
      List<Disease> diseases = await VaccinationModel().fetchData();
      List<Disease> diseaseAdult =
          diseases.where((disease) => !disease.isChild).toList();
      List<Disease> diseaseChild =
          diseases.where((disease) => disease.isChild).toList();
      emit(VaccinationInitial(diseaseAdult, diseaseChild));
    } catch (e) {
      emit(VaccinationError(state.diseaseAdult, state.diseaseChild,
          message: e.toString()));
    }
  }

  @override
  VaccinationState? fromJson(Map<String, dynamic> json) {
    return VaccinationState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(VaccinationState state) {
    return state.toMap();
  }
}
