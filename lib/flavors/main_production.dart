import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:healthline/app/app_controller.dart';
import 'package:healthline/app/healthline_app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await AppController.instance.init();

// HttpOverrides.global = MyHttpOverrides();
  // Sentry
  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.get('SENTRY_DSN');

      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;

      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
}
