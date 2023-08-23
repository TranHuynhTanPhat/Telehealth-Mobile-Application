import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:telehealth/res/colors.dart';
import 'package:telehealth/utils/config_loading.dart';

import '../app/telehealth_app.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: transparent
  ));

  runApp(const MyApp());
  configLoading();
}