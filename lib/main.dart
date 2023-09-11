import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/app/app_routes.dart';
import 'package:healthline/app/healthline_app.dart';
import 'package:healthline/res/colors.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: transparent));
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBloc.storage = storage;

  await dotenv.load();
  await AppController.instance.init();

  // Sentry
  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.get('SENTRY_DSN');

      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp(
      appRoute: AppRoute(),
    )),
  );

  // runApp(MyApp(
  //   appRoute: AppRoute(),
  // ));
}
