import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthline/app/app_controller.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/data_constants.dart';
import 'package:healthline/res/enum.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketManager {
  late Socket socket;

  late bool isConnected;

  SocketManager._internal();

  void init() {
    String? jwtToken;
    if (AppController.instance.authState == AuthState.PatientAuthorized) {
      LoginResponse response = LoginResponse.fromJson(
          AppStorage().getString(key: DataConstants.PATIENT)!);
      jwtToken = response.jwtToken;
    } else if (AppController.instance.authState == AuthState.DoctorAuthorized) {
      LoginResponse response = LoginResponse.fromJson(
          AppStorage().getString(key: DataConstants.DOCTOR)!);
      jwtToken = response.jwtToken;
    }
    socket = io(
      dotenv.get('SOCKET_URL', fallback: ''),
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect()
          .setExtraHeaders(
              {'Authorization': 'Bearer $jwtToken'}) // disable auto-connection
          .build(),
    );
    socket.connect();
    // Event listeners.
    socket.onConnect((_) {
      isConnected = true;

      log('Connected to the socket server');
    });

    socket.onDisconnect((_) {
      isConnected = false;

      log('Disconnected from the socket server');
    });
  }

  static final SocketManager instance = SocketManager._internal();

  factory SocketManager() {
    return instance;
  }

  void sendData({required String event, required dynamic data}) {
    socket.emit(event, data);
  }

  void sendDataWithAck(
      {required String event,
      required dynamic data,
      required Function(dynamic) listen}) {
    socket.emitWithAck(event, data, ack: (data) {
      listen(data);
    });
  }

  void addListener(
      {required String event, required Function(dynamic) listener}) {
    socket.on(event, listener);
  }

  void close() {
    socket.disconnect();
    socket.dispose();
  }
}
