import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart';

import 'package:healthline/app/app_controller.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/data/storage/data_constants.dart';
import 'package:healthline/res/enum.dart';

class SocketManager {
  late Socket socket;

  late bool isConnected;
  SocketManager({PortSocket? port}) {
    _init(port: port);
  }

  void _init({PortSocket? port}) {
    String? jwtToken;
    if (AppController().authState == AuthState.PatientAuthorized) {
      LoginResponse response = LoginResponse.fromJson(
          AppStorage().getString(key: DataConstants.PATIENT)!);
      jwtToken = response.jwtToken;
    } else if (AppController().authState == AuthState.DoctorAuthorized) {
      LoginResponse response = LoginResponse.fromJson(
          AppStorage().getString(key: DataConstants.DOCTOR)!);
      jwtToken = response.jwtToken;
    }
    socket = io(
      "https://health-forum-truongne.koyeb.app/${port!.name}",
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect()
          .setExtraHeaders(
              {'Authorization': 'Bearer $jwtToken'}) // disable auto-connection
          .build(),
    );
    socket.connect();
    socket.onConnect((_) {
      isConnected = true;

      log('Connected to the socket server');
    });

    socket.onDisconnect((_) {
      isConnected = false;
      log('Disconnected from the socket server');
    });
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
