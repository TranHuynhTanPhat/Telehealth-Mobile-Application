import 'dart:developer';

import 'package:healthline/utils/log_data.dart';
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
      "https://health-forum-truongne.koyeb.app/${port?.name}",
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

  void sendEventData({required String event, required dynamic data}) {
    socket.emit(event, data);
  }

  void sendEvent({required String event}) {
    socket.emit(event);
  }

  void sendData({required dynamic data}) {
    socket.send(data);
  }

  void sendEventDataWithAck(
      {required String event,
      required dynamic data,
      required Function(dynamic) listen}) {
    socket.emitWithAck(event, data, ack: (data) {
      listen(data);
    });
  }

  void stopEvent({required String event}) {
    socket.off(event);
  }

  void addListener(
      {required String event, required Function(dynamic) listener}) {
    socket.on(event, listener);
  }

  void dispose() {
    try {
      socket.dispose();
    } catch (e) {
      logPrint(e);
    }
  }

  void destroy() {
    try {
      socket.destroy();
    } catch (e) {
      logPrint(e);
    }
  }
}
