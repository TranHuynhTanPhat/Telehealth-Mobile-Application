part of 'vaccination_cubit.dart';

class VaccinationState {
 
  final List<Disease> diseaseAdult;
  final List<Disease> diseaseChild;
  VaccinationState({
    required this.diseaseAdult,
    required this.diseaseChild,
  });
 

  

  

  // Map<String, dynamic> toMap() {
  //   final result = <String, dynamic>{};
  
  //   result.addAll({'diseaseAdult': diseaseAdult.map((x) => x.toMap()).toList()});
  //   result.addAll({'diseaseChild': diseaseChild.map((x) => x.toMap()).toList()});
  
  //   return result;
  // }

  // factory VaccinationState.fromMap(Map<String, dynamic> map) {
  //   return VaccinationState(
  //     diseaseAdult: List<Disease>.from(map['diseaseAdult']?.map((x) => Disease.fromMap(x))),
  //     diseaseChild: List<Disease>.from(map['diseaseChild']?.map((x) => Disease.fromMap(x))),
  //   );
  // }

 }

final class VaccinationInitial extends VaccinationState {
  VaccinationInitial({required super.diseaseAdult, required super.diseaseChild});
  
}
final class VaccinationLoading extends VaccinationState {
  VaccinationLoading({required super.diseaseAdult, required super.diseaseChild});
 }

final class VaccinationLoaded extends VaccinationState {
  VaccinationLoaded({required super.diseaseAdult, required super.diseaseChild});
  }

final class VaccinationError extends VaccinationState {
  final String message;

  VaccinationError({required this.message, required super.diseaseAdult, required super.diseaseChild});

  }
