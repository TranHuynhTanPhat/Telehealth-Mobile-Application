part of 'docs_vaccination_cubit.dart';

class DocsVaccinationState {
  final List<Disease> diseaseAdult;
  final List<Disease> diseaseChild;
  final BlocState blocState;

  DocsVaccinationState(
      {required this.diseaseAdult,
      required this.diseaseChild,
      required this.blocState});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
        .addAll({'diseaseAdult': diseaseAdult.map((x) => x.toMap()).toList()});
    result
        .addAll({'diseaseChild': diseaseChild.map((x) => x.toMap()).toList()});
    result.addAll({'blocState': blocState.name});

    return result;
  }

  factory DocsVaccinationState.fromMap(Map<String, dynamic> map) {
    return DocsVaccinationState(
      diseaseAdult: List<Disease>.from(
          map['diseaseAdult']?.map((x) => Disease.fromMap(x))),
      diseaseChild: List<Disease>.from(
          map['diseaseChild']?.map((x) => Disease.fromMap(x))),
      blocState: BlocState.values.byName(map['blocState']),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory DocsVaccinationState.fromJson(String source) => DocsVaccinationState.fromMap(json.decode(source));
}

final class DocsVaccinationInitial extends DocsVaccinationState {
  DocsVaccinationInitial(
      {required super.diseaseAdult,
      required super.diseaseChild,
      required super.blocState});
}

final class FetchDocsVaccinationState extends DocsVaccinationState{
  FetchDocsVaccinationState({required super.diseaseAdult, required super.diseaseChild, required super.blocState, this.error});
  String? error;
}