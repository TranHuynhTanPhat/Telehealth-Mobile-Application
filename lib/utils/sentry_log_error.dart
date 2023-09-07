import 'package:sentry_flutter/sentry_flutter.dart';

class SentryLogError {
  final transaction = Sentry.startTransaction('processOrderBatch()', 'task');

  Future<void> additionalData(error, stackTrace) async {
    await Sentry.captureException(error, stackTrace: stackTrace);
  }
}
