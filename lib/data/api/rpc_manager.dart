import 'dart:async';

import 'package:dart_amqp/dart_amqp.dart';

class RpcManager {
  final Completer connected = Completer();
  late Client _client;
  late ConnectionSettings _settings;
  final Map<String, Completer> _pendingOperations = <String, Completer>{};
  late Queue _serverQueue;
  late String _replyQueueName;

  RpcManager._internal();

  static final RpcManager instance = RpcManager._internal();

  factory RpcManager() {
    return instance;
  }

  Future<void> init() async {
    _settings = ConnectionSettings(
      host: "armadillo.rmq.cloudamqp.com",
      virtualHost: 'fxqsrbcd',
      authProvider: const PlainAuthenticator(
          "fxqsrbcd", "IQdQplBIB_pJboPQw5_Mvw8Lzk_qYK3I"),
    );
    _client = Client(settings: _settings);
    Channel channel = await _client.channel();
    _serverQueue = await channel.queue("test", durable: true, passive: true);
    // Allocate a private queue for server responses
    Queue queue = await _serverQueue.channel.privateQueue();
    Consumer consumer = await queue.consume();
    _replyQueueName = consumer.queue.name;
    consumer.listen(handleResponse);
    connected.complete();
  }

  void handleResponse(AmqpMessage message) {
    // Ignore if the correlation id is unknown
    // Get the payload as a string
    print(" [x] Received string: ${message.payloadAsString}");

    // Or unserialize to json
    print(" [x] Received json: ${message.payloadAsJson}");

    // Or just get the raw data as a Uint8List
    print(" [x] Received raw: ${message.payload}");

    // The message object contains helper methods for
    // replying, ack-ing and rejecting
    // message.reply("world");
    if (!_pendingOperations.containsKey(message.properties?.corellationId)) {
      return;
    }

    _pendingOperations
        .remove(message.properties?.corellationId)!
        .complete(int.parse(message.payloadAsString));
  }

  Future<int> call(int n) async {
    // Make sure we are connected before sending the request
    await connected.future;

    // String uuid = "${_nextCorrelationId++}";
    Completer<int> completer = Completer<int>();

    // MessageProperties properties = MessageProperties()
    //   ..replyTo = _replyQueueName
    //   ..corellationId = uuid;

    // _pendingOperations[uuid] = completer;

    // _serverQueue.publish({"n": n}, properties: properties);

    return completer.future;
  }

  Future close() {
    // Kill any pending responses
    _pendingOperations.forEach((_, Completer completer) =>
        completer.completeError("RPC client shutting down"));
    _pendingOperations.clear();

    return _client.close();
  }
}
