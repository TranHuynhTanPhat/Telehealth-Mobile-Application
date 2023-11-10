import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketManager {
  final WebSocketChannel channel =
      IOWebSocketChannel.connect(ApiConstants.SOCKET_URL);
  late bool isConnected;
  final List<Function(dynamic)> _messageListeners = [];

  SocketManager._internal() {
    // print(channel.ready);
    isConnected = true;
    channel.stream.listen((data) {
      _handleMessage(data);
      logPrint("CHEKKKKK");
      logPrint(data);
      // addMessageListener(_handleCreateGroup);
      // log(data);
    });
    channel.sink.done.then((_) {
      isConnected = false;
      logPrint("WebSocket connection closed.");
    });
  }

  static final SocketManager instance = SocketManager._internal();

  factory SocketManager() {
    return instance;
  }

  Stream<dynamic> get onMessage => channel.stream;

  void sendData(String data) {
    // print(data);
    channel.sink.add(data);
  }

  void addMessageListener(Function(dynamic) listener) {
    _messageListeners.add(listener);
  }

  void removeMessageListener(Function(dynamic) listener) {
    _messageListeners.remove(listener);
  }

  void _handleMessage(dynamic data) {
    for (final listener in _messageListeners) {
      listener(data);
    }
  }

  void close() {
    channel.sink.close();
  }
}
