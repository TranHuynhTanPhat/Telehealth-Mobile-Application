import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:healthline/data/storage/models/vaccination_model.dart';

part 'vaccination_state.dart';

class VaccinationCubit extends HydratedCubit<VaccinationState> {
  VaccinationCubit()
      : super(VaccinationInitial(diseaseAdult: [], diseaseChild: []));

  Future<void> fetchVaccinationFromStorage() async {
    emit(VaccinationLoading(
        diseaseAdult: state.diseaseAdult, diseaseChild: state.diseaseChild));
    try {
      List<Disease> diseases = await VaccinationModel().fetchData();
      List<Disease> diseaseAdult =
          diseases.where((disease) => !disease.isChild).toList();
      List<Disease> diseaseChild =
          diseases.where((disease) => disease.isChild).toList();
      emit(
        VaccinationLoaded(
            diseaseAdult: diseaseAdult, diseaseChild: diseaseChild),
      );
    } catch (e) {
      emit(VaccinationError(
        message:e.toString(),
        diseaseAdult: state.diseaseAdult,
        diseaseChild: state.diseaseChild,
      ));
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
