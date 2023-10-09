part of 'vaccine_record_cubit.dart';

class VaccineRecordState {
  final List<VaccinationResponse> vaccinations;
  final List<InjectedVaccinationResponse> injectedVaccinations;
  final int age;
  final String recordId;
  VaccineRecordState({
    required this.vaccinations,
    required this.injectedVaccinations,
    required this.age,
    required this.recordId,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
        .addAll({'vaccinations': vaccinations.map((x) => x.toMap()).toList()});
    result.addAll({
      'injectedVaccination': injectedVaccinations.map((x) => x.toMap()).toList()
    });
    result.addAll({'age': age});
    result.addAll({'recordId': recordId});

    return result;
  }

  factory VaccineRecordState.fromMap(Map<String, dynamic> map) {
    return VaccineRecordState(
      vaccinations: List<VaccinationResponse>.from(
          map['vaccinations']?.map((x) => VaccinationResponse.fromMap(x))),
      injectedVaccinations: List<InjectedVaccinationResponse>.from(
          map['injectedVaccination']
              ?.map((x) => InjectedVaccinationResponse.fromMap(x))),
      age: map['age']?.toInt() ?? 0,
      recordId: map['recordId'] ?? '',
    );
  }
}

final class VaccineRecordInitial extends VaccineRecordState {
  VaccineRecordInitial(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.recordId});
}

abstract class FetchInjectedVaccination extends VaccineRecordState {
  FetchInjectedVaccination(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.recordId});
}

abstract class FetchVaccination extends VaccineRecordState {
  FetchVaccination(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.recordId});
}

final class FetchVaccinationLoading extends FetchVaccination {
  FetchVaccinationLoading(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.recordId});
}

final class FetchVaccinationLoaded extends FetchVaccination {
  FetchVaccinationLoaded(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.recordId});
}

final class FetchVaccinationError extends FetchVaccination {
  final String message;

  FetchVaccinationError(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.recordId,
      required this.message});
}

final class FetchInjectedVaccinationLoading extends FetchInjectedVaccination {
  FetchInjectedVaccinationLoading(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.recordId});
}

final class FetchInjectedVaccinationLoaded extends FetchInjectedVaccination {
  FetchInjectedVaccinationLoaded(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.recordId});
}

final class FetchInjectedVaccinationError extends FetchInjectedVaccination {
  final String message;

  FetchInjectedVaccinationError(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.recordId,
      required this.message});
}

final class CreateInjectedVaccinationLoading extends FetchInjectedVaccination {
  CreateInjectedVaccinationLoading(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.recordId});
}

final class CreateInjectedVaccinationLoaded extends FetchInjectedVaccination {
  CreateInjectedVaccinationLoaded({
    required super.vaccinations,
    required super.injectedVaccinations,
    required super.age,
    required super.recordId,
  });
}

final class CreateInjectedVaccinationError extends FetchInjectedVaccination {
  final String message;

  CreateInjectedVaccinationError(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.recordId,
      required this.message});
}
