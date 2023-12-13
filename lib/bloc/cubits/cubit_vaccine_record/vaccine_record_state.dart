part of 'vaccine_record_cubit.dart';

class VaccineRecordState {
  final List<VaccinationResponse> vaccinations;
  final List<InjectedVaccinationResponse> injectedVaccinations;
  final int age;
  final String medicalRecord;
  final BlocState blocState;
  String? error;
  VaccineRecordState({
    required this.vaccinations,
    required this.injectedVaccinations,
    required this.age,
    required this.medicalRecord,
    required this.blocState,
    this.error
  });
}

final class VaccineRecordInitial extends VaccineRecordState {
  VaccineRecordInitial(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord,
      required super.blocState});
}

class FetchVaccinationState extends VaccineRecordState {
  FetchVaccinationState(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord,
      required super.blocState,
      super.error});
}

class FetchVaccinationRecordState extends VaccineRecordState {
  FetchVaccinationRecordState(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord,
      required super.blocState,
      super.error});
}

class CreateVaccinationRecordState extends VaccineRecordState {
  CreateVaccinationRecordState(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord,
      required super.blocState,
      super.error});
}

class UpdateVaccinationRecordState extends VaccineRecordState {
  UpdateVaccinationRecordState(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord,
      required super.blocState,
      super.error});
}

class DeleteVaccinationRecordState extends VaccineRecordState {
  DeleteVaccinationRecordState(
      {required super.vaccinations,
      required super.injectedVaccinations,
      required super.age,
      required super.medicalRecord,
      required super.blocState,
      super.error});
}
