// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:healthline/res/enum.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'license_state.dart';

class LicenseCubit extends Cubit<LicenseState> {
  LicenseCubit() : super(LicenseInitial(blocState: BlocState.Successed));

  Future<void> fetchFAQs(String locale) async {
    emit(FAQState(blocState: BlocState.Pending, faqs: []));
    // String filename = "faq";
    try {
      String filename = locale == 'vi' ? "faq-vn" : "faq-en";

      String jsonString =
          await rootBundle.loadString('assets/license/$filename.json');
      // Map<String, dynamic> jsonMap = json.decode(jsonString);
      List<dynamic> listMap = json.decode(jsonString);
      List<Map<String, String>> faqs = listMap.map((e) {
        final Map<String, dynamic> valueJson = json.decode(json.encode(e));
        final Map<String, String> faq = valueJson.map<String, String>(
            (key, value) => MapEntry(key, value.toString()));
        return faq;
      }).toList();
      // listMap.forEach(logPrint);
      emit(FAQState(blocState: BlocState.Successed, faqs: faqs));
    } catch (e) {
      logPrint(e);
      emit(FAQState(blocState: BlocState.Failed, faqs: []));
    }
  }

  Future<void> fetchPolicy(String locale) async {
    emit(PrivacyPolicyState(blocState: BlocState.Pending, policies: {}));
    // String filename = "faq";
    try {
      String filename =
          locale == 'vi' ? "privacy-policy-vn" : "privacy-policy-en";

      String jsonString =
          await rootBundle.loadString('assets/license/$filename.json');
      // Map<String, dynamic> jsonMap = json.decode(jsonString);
      Map<String, dynamic> map = json.decode(jsonString);
      final Map<String, String> policies = map
          .map<String, String>((key, value) => MapEntry(key, value.toString()));
      // List<Map<String, String>> faqs = listMap.map((e) {
      //   final Map<String, dynamic> valueJson = json.decode(json.encode(e));
      //   final Map<String, String> faq = valueJson.map<String, String>(
      //       (key, value) => MapEntry(key, value.toString()));
      //   return faq;
      // }).toList();
      // listMap.forEach(logPrint);
      emit(PrivacyPolicyState(
          blocState: BlocState.Successed, policies: policies));
    } catch (e) {
      logPrint(e);
      emit(PrivacyPolicyState(blocState: BlocState.Failed, policies: {}));
    }
  }

  Future<void> fetchTermCondition(String locale) async {
    emit(TermAndConditionState(blocState: BlocState.Pending, content: []));
    // String filename = "faq";
    try {
      String filename =
          locale == 'vi' ? "term-condition-vn" : "term-condition-en";

      String jsonString =
          await rootBundle.loadString('assets/license/$filename.json');
      // Map<String, dynamic> jsonMap = json.decode(jsonString);
      List<dynamic> listMap = json.decode(jsonString);
      List<Map<String, String>> content = listMap.map((e) {
        final Map<String, dynamic> valueJson = json.decode(json.encode(e));
        final Map<String, String> tc = valueJson.map<String, String>(
            (key, value) => MapEntry(key, value.toString()));
        return tc;
      }).toList();
      emit(TermAndConditionState(
          blocState: BlocState.Successed, content: content));
    } catch (e) {
      logPrint(e);
      emit(TermAndConditionState(blocState: BlocState.Failed, content: []));
    }
  }

  Future<void> reportBugState(
      {required String email,
      required String fullName,
      required String feedback}) async {
    emit(BugReportState(blocState: BlocState.Pending));
    // String filename = "faq";
    try {
      SentryId sentryId = await Sentry.captureMessage("Bug Report");
      final userFeedback = SentryUserFeedback(
        eventId: sentryId,
        comments: feedback,
        email: email,
        name: fullName,
      );

      Sentry.captureUserFeedback(userFeedback);
      emit(BugReportState(blocState: BlocState.Successed));
    } catch (e) {
      logPrint(e);
      emit(BugReportState(blocState: BlocState.Failed));
    }
  }
}
