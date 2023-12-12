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

// final class FetchVaccinationLoading extends VaccineRecordLoadingState {
//   FetchVaccinationLoading(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord});
// }

// final class FetchVaccinationLoaded extends FetchVaccination {
//   FetchVaccinationLoaded(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord});
// }

// final class FetchVaccinationError extends FetchVaccination {
//   final String message;

//   FetchVaccinationError(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord,
//       required this.message});
// }

// final class FetchInjectedVaccinationLoading extends VaccineRecordLoadingState {
//   FetchInjectedVaccinationLoading(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord});
// }

// final class FetchInjectedVaccinationLoaded extends FetchInjectedVaccination {
//   FetchInjectedVaccinationLoaded(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord});
// }

// final class FetchInjectedVaccinationError extends FetchInjectedVaccination {
//   final String message;

//   FetchInjectedVaccinationError(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord,
//       required this.message});
// }

// final class CreateInjectedVaccinationLoading extends VaccineRecordLoadingState {
//   CreateInjectedVaccinationLoading(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord});
// }

// final class CreateInjectedVaccinationLoaded extends CreateInjectedVaccination {
//   CreateInjectedVaccinationLoaded({
//     required super.vaccinations,
//     required super.injectedVaccinations,
//     required super.age,
//     required super.medicalRecord,
//   });
// }

// final class CreateInjectedVaccinationError extends CreateInjectedVaccination {
//   final String message;

//   CreateInjectedVaccinationError(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord,
//       required this.message});
// }

// final class DeleteInjectedVaccinationLoading extends VaccineRecordLoadingState {
//   DeleteInjectedVaccinationLoading(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord});
// }

// final class DeleteInjectedVaccinationLoaded extends DeleteInjectedVaccination {
//   DeleteInjectedVaccinationLoaded({
//     required super.vaccinations,
//     required super.injectedVaccinations,
//     required super.age,
//     required super.medicalRecord,
//   });
// }

// final class DeleteInjectedVaccinationError extends DeleteInjectedVaccination {
//   final String message;

//   DeleteInjectedVaccinationError(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord,
//       required this.message});
// }

// final class UpdateInjectedVaccinationLoading extends VaccineRecordLoadingState {
//   UpdateInjectedVaccinationLoading(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord});
// }

// final class UpdateInjectedVaccinationLoaded extends UpdateInjectedVaccination {
//   UpdateInjectedVaccinationLoaded({
//     required super.vaccinations,
//     required super.injectedVaccinations,
//     required super.age,
//     required super.medicalRecord,
//   });
// }

// final class UpdateInjectedVaccinationError extends UpdateInjectedVaccination {
//   final String message;

//   UpdateInjectedVaccinationError(
//       {required super.vaccinations,
//       required super.injectedVaccinations,
//       required super.age,
//       required super.medicalRecord,
//       required this.message});
// }
