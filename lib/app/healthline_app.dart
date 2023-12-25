import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:healthline/bloc/cubits/cubits_export.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/routes/app_routes.dart';
import 'package:healthline/screen/splash/splash_screen.dart';
import 'package:healthline/utils/alice_inspector.dart';
import 'package:healthline/utils/config_loading.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

final GlobalKey<NavigatorState>? navigatorKey =AliceInspector().dev
                    ? AliceInspector().alice.getNavigatorKey()
                    : GlobalKey<NavigatorState>();
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = AppRoute();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    configLoading(context);

    late Locale locale;
    if (Platform.localeName.contains('vi')) {
      locale = const Locale('vi');
    } else {
      locale = const Locale('en');
    }
    // Platform.localeName != 'vi_VN' || Platform.localeName != 'vi'
    //     ? const Locale('en')
    //     : const Locale('vi');

    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig().init(constraints);
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ResCubit(locale),
            ),
            BlocProvider(
              create: (context) => ApplicationUpdateCubit(),
            ),
          ],
          child: BlocBuilder<ResCubit, ResState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: "healthline",
                home: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: const SplashScreen(),
                ),
                theme: AppThemes.appThemeData[AppTheme.LightTheme],
                onGenerateRoute: _router.onGeneralRoute,
                supportedLocales: AppLocalizationsSetup.supportedLocales,
                localizationsDelegates:
                    AppLocalizationsSetup.localizationsDelegates,
                locale: state.locale,
                builder: EasyLoading.init(),
                navigatorKey: navigatorKey,
                navigatorObservers: [SentryNavigatorObserver()],
              );
            },
          ),
        );
      },
    );
  }
}
