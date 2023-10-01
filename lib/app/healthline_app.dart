import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healthline/app/app_routes.dart';
import 'package:healthline/app/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/utils/config_loading.dart';

import 'package:healthline/screens/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoute});
  final AppRoute appRoute;

  @override
  Widget build(BuildContext context) {
    configLoading(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return BlocProvider(
          create: (context) => ResCubit(),
          child: BlocBuilder<ResCubit, ResState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "healthline",
                home: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1.0,
                  ),
                  child: const SplashScreen(),
                ),
                theme: AppThemes.appThemeData[AppTheme.LightTheme],
                onGenerateRoute: appRoute.onGeneralRoute,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
                locale: state.locale,
                builder: EasyLoading.init(),
              );
            },
          ),
        );
      },
    );
  }
}
