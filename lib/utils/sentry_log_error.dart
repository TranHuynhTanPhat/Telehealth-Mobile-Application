import 'package:sentry_flutter/sentry_flutter.dart';

class SentryLogError {
  Future<void> additionalException(error, stackTrace) async {
    await Sentry.captureException(error, stackTrace: stackTrace);
  }

  Future<void> additionalMessage(message, leve) async {
    await Sentry.captureMessage(message, level: leve);
  }
}
