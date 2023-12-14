part of 'consultation_cubit.dart';

sealed class ConsultationState {
  final BlocState blocState;
  final String? error;
  final List<int> timeline;


  ConsultationState({required this.blocState, this.error, required this.timeline});
}

final class ConsultationInitial extends ConsultationState {
  ConsultationInitial({required super.blocState, super.error, required super.timeline});
}

final class FetchTimelineState extends ConsultationState {
  FetchTimelineState(
      {required super.blocState, super.error, required super.timeline});
}
