part of 'vaccination_cubit.dart';

class VaccinationState {
  const VaccinationState(this.diseaseAdult, this.diseaseChild);
  final List<Disease> diseaseAdult;
  final List<Disease> diseaseChild;


  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'diseaseAdult': diseaseAdult.map((x) => x.toMap()).toList()});
    result.addAll({'diseaseChild': diseaseChild.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory VaccinationState.fromMap(Map<String, dynamic> map) {
    return VaccinationState(
      List<Disease>.from(map['diseaseAdult']?.map((x) => Disease.fromMap(x))),
      List<Disease>.from(map['diseaseChild']?.map((x) => Disease.fromMap(x))),
    );
  }

}

final class VaccinationInitial extends VaccinationState {
  const VaccinationInitial(super.diseaseAdult, super.diseaseChild);
  
}

final class VaccinationLoading extends VaccinationState{
  const VaccinationLoading(super.diseaseAdult, super.diseaseChild);
}

final class VaccinationError extends VaccinationState{
  final String message;

  const VaccinationError(super.diseaseAdult, super.diseaseChild, {required this.message});
}