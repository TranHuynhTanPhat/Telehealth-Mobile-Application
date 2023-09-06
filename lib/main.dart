import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthline/app/app_routes.dart';
import 'package:healthline/app/healthline_app.dart';
import 'package:healthline/res/colors.dart';
import 'package:healthline/utils/config_loading.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: transparent));
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedBloc.storage = storage;

  runApp(MyApp(
    appRoute: AppRoute(),
  ));
  configLoading();
}
