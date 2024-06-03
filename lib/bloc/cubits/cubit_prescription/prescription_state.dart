part of 'prescription_cubit.dart';

sealed class PrescriptionState {
  const PrescriptionState({required this.blocState, this.error});
  final BlocState blocState;
  final String? error;
}

final class PrescriptionInitial extends PrescriptionState {
  PrescriptionInitial({required super.blocState, super.error});
}

final class GetInfoDrugState extends PrescriptionState {
  GetInfoDrugState({required super.blocState, super.error, this.data});
  final DrugResponse? data;
}

final class FetchPrescriptionState extends PrescriptionState {
  FetchPrescriptionState({required super.blocState, super.error, this.data});
  final PrescriptionResponse? data;
}

final class CreatePrescriptionState extends PrescriptionState {
  CreatePrescriptionState({
    required super.blocState,
    super.error,
  });
}


final class SearchDrugState extends PrescriptionState {
  SearchDrugState({
    required super.blocState,
    super.error,
  });
}
