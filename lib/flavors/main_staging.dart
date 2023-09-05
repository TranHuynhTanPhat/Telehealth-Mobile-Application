import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthline/app/app_routes.dart';
import 'package:healthline/app/healthline_app.dart';
import 'package:healthline/res/colors.dart';
import 'package:healthline/utils/config_loading.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: transparent));

  runApp(MyApp(
    appRoute: AppRoute(),
  ));
  configLoading();
}
