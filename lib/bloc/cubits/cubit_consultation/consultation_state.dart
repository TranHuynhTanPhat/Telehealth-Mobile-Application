part of 'consultation_cubit.dart';

sealed class ConsultationState {
  final BlocState blocState;
  final String? error;
  final List<int> timeline;
  final ConsultationRequest request;
  final String? doctorName;
  final String? patientName;
  final AllConsultationResponse? consultations;

  ConsultationState(
      {required this.blocState,
      this.error,
      required this.timeline,
      required this.request,
      required this.doctorName,
      required this.patientName, required this.consultations});
}

final class ConsultationInitial extends ConsultationState {
  ConsultationInitial(
      {required super.blocState,
      super.error,
      required super.timeline,
      required super.request,
      required super.doctorName,
      required super.patientName, required super.consultations});
}

final class FetchTimelineState extends ConsultationState {
  FetchTimelineState(
      {required super.blocState,
      super.error,
      required super.timeline,
      required super.request,
      required super.doctorName,
      required super.patientName, required super.consultations});
}

final class CreateConsultationState extends ConsultationState {
  CreateConsultationState(
      {required super.blocState,
      super.error,
      required super.timeline,
      required super.request,
      required super.doctorName,
      required super.patientName, required super.consultations});
}

final class FetchConsultationState extends ConsultationState {
  FetchConsultationState(
      {required super.blocState,
      required super.timeline,
      required super.request,
      required super.doctorName,
      required super.patientName,
      super.error, required super.consultations});
}
final class CancelConsultationState extends ConsultationState {
  CancelConsultationState(
      {required super.blocState,
      required super.timeline,
      required super.request,
      required super.doctorName,
      required super.patientName,
      super.error, required super.consultations});
}
