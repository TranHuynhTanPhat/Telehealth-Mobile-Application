part of 'consultation_cubit.dart';

sealed class ConsultationState {
  final BlocState blocState;
  final String? error;
  final List<int> timeline;
  final ConsultationRequest request;
  final String? doctorName;
  final String? patientName;
  // final AllConsultationResponse consultations;

  ConsultationState(
      {required this.blocState,
      this.error,
      required this.timeline,
      required this.request,
      required this.doctorName,
      required this.patientName});
}

final class ConsultationInitial extends ConsultationState {
  ConsultationInitial(
      {required super.blocState,
      super.error,
      required super.timeline,
      required super.request,
      required super.doctorName,
      required super.patientName});
}

final class FetchTimelineState extends ConsultationState {
  FetchTimelineState(
      {required super.blocState,
      super.error,
      required super.timeline,
      required super.request,
      required super.doctorName,
      required super.patientName});
}

final class CreateConsultationState extends ConsultationState {
  CreateConsultationState(
      {required super.blocState,
      super.error,
      required super.timeline,
      required super.request,
      required super.doctorName,
      required super.patientName});
}

final class FetchConsultationState extends ConsultationState {
  FetchConsultationState(
      {required super.blocState,
      required super.timeline,
      required super.request,
      required super.doctorName,
      required super.patientName,
      super.error, required this.consultations});
  final AllConsultationResponse consultations;
}
