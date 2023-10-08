part of 'vaccination_cubit.dart';

class VaccinationState {
  const VaccinationState(
    this.diseaseAdult,
    this.diseaseChild,
    this.vaccinations,
    this.injectedVaccination,
    this.age,
  );
  final List<Disease> diseaseAdult;
  final List<Disease> diseaseChild;
  final List<VaccinationResponse> vaccinations;
  final List<InjectedVaccinationResponse> injectedVaccination;
  final int age;

  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'diseaseAdult': diseaseAdult.map((x) => x.toMap()).toList()});
    result.addAll({'diseaseChild': diseaseChild.map((x) => x.toMap()).toList()});
    result.addAll({'vaccinations': vaccinations.map((x) => x.toMap()).toList()});
    result.addAll({'injectedVaccination': injectedVaccination.map((x) => x.toMap()).toList()});
    result.addAll({'age': age});
  
    return result;
  }

  factory VaccinationState.fromMap(Map<String, dynamic> map) {
    return VaccinationState(
      List<Disease>.from(map['diseaseAdult']?.map((x) => Disease.fromMap(x))),
      List<Disease>.from(map['diseaseChild']?.map((x) => Disease.fromMap(x))),
      List<VaccinationResponse>.from(map['vaccinations']?.map((x) => VaccinationResponse.fromMap(x))),
      List<InjectedVaccinationResponse>.from(map['injectedVaccination']?.map((x) => InjectedVaccinationResponse.fromMap(x))),
      map['age']?.toInt() ?? 0,
    );
  }
}

final class VaccinationInitial extends VaccinationState {
  const VaccinationInitial(
      super.diseaseAdult, super.diseaseChild, super.vaccinations, super.injectedVaccination, super.age);
}

abstract class FetchInjectedVaccination extends VaccinationState {
  FetchInjectedVaccination(
      super.diseaseAdult, super.diseaseChild, super.vaccinations, super.injectedVaccination, super.age);
}

abstract class FetchVaccination extends VaccinationState {
  FetchVaccination(
      super.diseaseAdult, super.diseaseChild, super.vaccinations, super.injectedVaccination, super.age);
}

final class VaccinationLoading extends FetchVaccination {
  VaccinationLoading(
      super.diseaseAdult, super.diseaseChild, super.vaccinations, super.injectedVaccination, super.age);
}

final class VaccinationLoaded extends FetchVaccination {
  VaccinationLoaded(
      super.diseaseAdult, super.diseaseChild, super.vaccinations, super.injectedVaccination, super.age);
}

final class VaccinationError extends FetchVaccination {
  final String message;

  VaccinationError(
      super.diseaseAdult, super.diseaseChild, super.vaccinations, super.injectedVaccination, super.age,
      {required this.message});
}

final class FetchInjectedVaccinationLoading extends FetchInjectedVaccination {
  FetchInjectedVaccinationLoading(
      super.diseaseAdult, super.diseaseChild, super.vaccinations, super.injectedVaccination, super.age);
}

final class FetchInjectedVaccinationLoaded extends FetchInjectedVaccination {
  FetchInjectedVaccinationLoaded(
      super.diseaseAdult, super.diseaseChild, super.vaccinations, super.injectedVaccination, super.age);
}

final class FetchInjectedVaccinationError extends FetchInjectedVaccination {
  final String message;

  FetchInjectedVaccinationError(
      super.diseaseAdult, super.diseaseChild, super.vaccinations, super.injectedVaccination, super.age,
      {required this.message});
}
