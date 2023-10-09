part of 'vaccine_record_cubit.dart';

class VaccineRecordState {
  final List<VaccinationResponse> vaccinations;
  final List<InjectedVaccinationResponse> injectedVaccinations;
  final int age;
  final String medicalRecord;
  VaccineRecordState({
    required this.vaccinations,
    required this.injectedVaccinations,
    required this.age,
    required this.medicalRecord,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
        .addAll({'vaccinations': vaccinations.map((x) => x.toMap()).toList()});
    result.addAll({
      'injectedVaccination': injectedVaccinations.map((x) => x.toMap()).toList()
    });
    result.addAll({'age': age});
    result.addAll({'medicalRecord': medicalRecord});

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
      medicalRecord: map['medicalRecord'] ?? '',
    );
  }
}

final class VaccineRecordInitial extends VaccineRecordState {
  VaccineRecordInitial(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord});
}

abstract class FetchInjectedVaccination extends VaccineRecordState {
  FetchInjectedVaccination(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord});
}

abstract class FetchVaccination extends VaccineRecordState {
  FetchVaccination(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord});
}

abstract class CreateInjectedVaccination extends VaccineRecordState {
  CreateInjectedVaccination(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord});
}

abstract class DeleteInjectedVaccination extends VaccineRecordState {
  DeleteInjectedVaccination(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord});
}

final class FetchVaccinationLoading extends FetchVaccination {
  FetchVaccinationLoading(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord});
}

final class FetchVaccinationLoaded extends FetchVaccination {
  FetchVaccinationLoaded(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord});
}

final class FetchVaccinationError extends FetchVaccination {
  final String message;

  FetchVaccinationError(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord,
      required this.message});
}

final class FetchInjectedVaccinationLoading extends FetchInjectedVaccination {
  FetchInjectedVaccinationLoading(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord});
}

final class FetchInjectedVaccinationLoaded extends FetchInjectedVaccination {
  FetchInjectedVaccinationLoaded(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord});
}

final class FetchInjectedVaccinationError extends FetchInjectedVaccination {
  final String message;

  FetchInjectedVaccinationError(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord,
      required this.message});
}

final class CreateInjectedVaccinationLoading extends CreateInjectedVaccination {
  CreateInjectedVaccinationLoading(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord});
}

final class CreateInjectedVaccinationLoaded extends CreateInjectedVaccination {
  CreateInjectedVaccinationLoaded({
    required super.vaccinations,
    required super.injectedVaccinations,
    required super.age,
    required super.medicalRecord,
  });
}

final class CreateInjectedVaccinationError extends CreateInjectedVaccination {
  final String message;

  CreateInjectedVaccinationError(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord,
      required this.message});
}

final class DeleteInjectedVaccinationLoading extends DeleteInjectedVaccination {
  DeleteInjectedVaccinationLoading(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord});
}

final class DeleteInjectedVaccinationLoaded extends DeleteInjectedVaccination {
  DeleteInjectedVaccinationLoaded({
    required super.vaccinations,
    required super.injectedVaccinations,
    required super.age,
    required super.medicalRecord,
  });
}

final class DeleteInjectedVaccinationError extends DeleteInjectedVaccination {
  final String message;

  DeleteInjectedVaccinationError(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord,
      required this.message});
}
