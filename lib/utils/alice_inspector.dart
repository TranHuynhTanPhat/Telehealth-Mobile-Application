import 'package:alice/alice.dart';

class AliceInspector {
  final Alice _alice = Alice(
    showNotification: false,
    showInspectorOnShake: false,
    darkTheme: false,
    maxCallsCount: 1000,
  );
  Alice get alice => _alice;

  // singleton
  static final AliceInspector instance = AliceInspector._internal();

  factory AliceInspector() {
    return instance;
  }

  AliceInspector._internal();
}
