// import 'dart:io';

// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthline/utils/alice_inspector.dart';
// import 'package:healthline/data/api/api_constants.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:healthline/app/app_controller.dart';
import 'package:healthline/app/healthline_app.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // Dart client
  // IO.Socket socket = IO.io(ApiConstants.SOCKET_URL);
  // print("CHECKKKK");
  // print(socket.connected);
  // socket.onConnect((_) {
  //   print('connect');
  //   socket.emit('msg', 'message');
  // });
  // socket.on('hello', (data) => print("CHEKKKKK"));
  // socket.onDisconnect((_) => print('jdisconnect'));
  // socket.on('fromServer', (_) => print(_));

  await dotenv.load();
  await AppController.instance.init();
  AliceInspector().init();


  // HttpOverrides.global = MyHttpOverrides();
  // Sentry
  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.get('SENTRY_DSN');

      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );
}

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }