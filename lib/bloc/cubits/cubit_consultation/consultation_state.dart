part of 'consultation_cubit.dart';

sealed class ConsultationState {
  final BlocState blocState;
  final String? error;
  final List<int> timeline;
  final AllConsultationResponse? consultations;
  final List<FeedbackResponse>? feedbacks;

  ConsultationState(
      {required this.blocState,
      this.error,
      required this.timeline,
      required this.consultations,
      required this.feedbacks});
}

final class ConsultationInitial extends ConsultationState {
  ConsultationInitial(
      {required super.blocState,
      super.error,
      required super.timeline,
      required super.consultations,
      required super.feedbacks});
}

final class FetchTimelineState extends ConsultationState {
  FetchTimelineState(
      {required super.blocState,
      super.error,
      required super.timeline,
      required super.consultations,
      required super.feedbacks});
}

final class CreateConsultationState extends ConsultationState {
  CreateConsultationState(
      {required super.blocState,
      super.error,
      required super.timeline,
      required super.consultations,
      required super.feedbacks});
}

final class FetchConsultationState extends ConsultationState {
  FetchConsultationState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks});
}

final class FetchDetatilDoctorConsultationState extends ConsultationState {
  FetchDetatilDoctorConsultationState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks,
      this.detailDoctorConsultation});
  final ConsultationResponse? detailDoctorConsultation;
}

final class CancelConsultationState extends ConsultationState {
  CancelConsultationState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks});
}

final class FetchFeedbackDoctorState extends ConsultationState {
  FetchFeedbackDoctorState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks});
}

final class FetchFeedbackUserState extends ConsultationState {
  FetchFeedbackUserState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks});
}

final class ConfirmConsultationState extends ConsultationState {
  ConfirmConsultationState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks});
}

final class DenyConsultationState extends ConsultationState {
  DenyConsultationState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks});
}

final class CreateFeebackState extends ConsultationState {
  CreateFeebackState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks});
}

final class GetDasboardState extends ConsultationState {
  GetDasboardState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks,
      this.dashboard});
  final DoctorDasboardResponse? dashboard;
}

final class FetchMoneyChartState extends ConsultationState {
  FetchMoneyChartState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks,
      this.data});
  final MoneyChartResponse? data;
}

final class FetchStatisticTableState extends ConsultationState {
  FetchStatisticTableState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks,
      this.data});
  final StatisticResponse? data;
}

final class GetFamiliarCustomer extends ConsultationState {
  GetFamiliarCustomer(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks,
      this.data});
  final List<UserResponse>? data;
}

final class GetNewCustomer extends ConsultationState {
  GetNewCustomer(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks,
      this.data});
  final List<UserResponse>? data;
}

final class FetchPrescriptionState extends ConsultationState {
  FetchPrescriptionState(
      {required super.blocState,
      required super.timeline,
      super.error,
      required super.consultations,
      required super.feedbacks,
      this.data});
  final PrescriptionResponse? data;
}

final class SearchDrugState extends ConsultationState {
  SearchDrugState({
    required super.blocState,
    required super.timeline,
    super.error,
    required super.consultations,
    required super.feedbacks,
  });
}
final class GetInfoDrugState extends ConsultationState {
  GetInfoDrugState({
    required super.blocState,
    required super.timeline,
    super.error,
    required super.consultations,
    required super.feedbacks,
    this.data
  });
  final DrugResponse? data;
}

final class CreatePrescriptionState extends ConsultationState {
  CreatePrescriptionState({
    required super.blocState,
    required super.timeline,
    super.error,
    required super.consultations,
    required super.feedbacks,
  });
}

final class FetchDiscountState extends ConsultationState {
  FetchDiscountState({
    required super.blocState,
    required super.timeline,
    super.error,
    required super.consultations,
    required super.feedbacks,
    this.data,
  });
  List<DiscountResponse>? data;
}
final class AnnounceBusyState extends ConsultationState {
  AnnounceBusyState({
    required super.blocState,
    required super.timeline,
    super.error,
    required super.consultations,
    required super.feedbacks,
  });
}
