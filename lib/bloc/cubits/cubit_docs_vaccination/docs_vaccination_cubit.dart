import 'package:healthline/data/storage/models/vaccination_model.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'docs_vaccination_state.dart';

class DocsVaccinationCubit extends HydratedCubit<DocsVaccinationState> {
  DocsVaccinationCubit()
      : super(DocsVaccinationInitial(
            diseaseAdult: [],
            diseaseChild: [],
            blocState: BlocState.Successed));

  @override
  void onChange(Change<DocsVaccinationState> change) {
    super.onChange(change);
    logPrint(change);
  }

  Future<void> fetchVaccinationFromStorage() async {
    emit(FetchDocsVaccinationState(
        diseaseAdult: state.diseaseAdult, diseaseChild: state.diseaseChild, blocState: BlocState.Pending));
    try {
      List<Disease> diseases = await VaccinationModel().fetchData();
      List<Disease> diseaseAdult =
          diseases.where((disease) => !disease.isChild).toList();
      List<Disease> diseaseChild =
          diseases.where((disease) => disease.isChild).toList();
      emit(
        FetchDocsVaccinationState(
            diseaseAdult: diseaseAdult, diseaseChild: diseaseChild, blocState: BlocState.Successed),
      );
    } catch (e) {
      emit(FetchDocsVaccinationState(
        error: e.toString(),
        diseaseAdult: state.diseaseAdult,
        diseaseChild: state.diseaseChild, blocState: BlocState.Failed,
      ));
    }
  }

  @override
  DocsVaccinationState? fromJson(Map<String, dynamic> json) {
    return DocsVaccinationState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(DocsVaccinationState state) {
    return state.toMap();
  }
}
