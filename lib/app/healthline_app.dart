import 'package:flutter/material.dart';
import 'package:healthline/app/app_pages.dart';
import 'package:healthline/app/app_routes.dart';
import 'package:healthline/res/dimens.dart';
import 'package:healthline/res/language/app_localizations_setup.dart';
import 'package:healthline/res/theme/app_theme.dart';
import 'package:healthline/ui/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRoute});
  final AppRoute appRoute;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "healthline",
          home: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1.0,
            ),
            child: const SplashScreen(),
          ),
          theme: AppThemes.appThemeData[AppTheme.lightTheme],
          onGenerateRoute: appRoute.onGeneralRoute,
          initialRoute: splashId,
          supportedLocales: AppLocalizationsSetup.supportedLocales,
          localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
          locale: const Locale('vi'),
        );
      },
    );
  }
}
