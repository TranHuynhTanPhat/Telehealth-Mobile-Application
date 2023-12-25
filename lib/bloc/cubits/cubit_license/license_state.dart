part of 'license_cubit.dart';

sealed class LicenseState {
  final BlocState blocState;

  const LicenseState({required this.blocState});
}

final class LicenseInitial extends LicenseState {
  LicenseInitial({required super.blocState});
}

final class FAQState extends LicenseState {
  FAQState({required super.blocState, required this.faqs});
  List<Map<String, String>> faqs;
}

final class PrivacyPolicyState extends LicenseState {
  PrivacyPolicyState({required super.blocState, required this.policies});
  Map<String, String> policies;
}

final class TermAndConditionState extends LicenseState {
  TermAndConditionState({required super.blocState, required this.content});
  List<Map<String, String>> content;
}

final class BugReportState extends LicenseState {
  BugReportState({required super.blocState});
}
