part of 'consultation_cubit.dart';

sealed class ConsultationState {
  final BlocState blocState;
  final String? error;
  final List<int> timeline;
  final ConsultationRequest request;


  ConsultationState({required this.blocState, this.error, required this.timeline, required this.request});
}

final class ConsultationInitial extends ConsultationState {
  ConsultationInitial({required super.blocState, super.error, required super.timeline, required super.request});
}

final class FetchTimelineState extends ConsultationState {
  FetchTimelineState(
      {required super.blocState, super.error, required super.timeline, required super.request});
}

// final class FetchTimelineState extends ConsultationState {
//   FetchTimelineState(
//       {required super.blocState, super.error, required super.timeline});
// }
