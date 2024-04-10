import 'package:healthline/data/storage/models/consultation_notification_model.dart';
import 'package:healthline/data/storage/provider/notification_provider.dart';

class ConsultationNotificationProvider {
  static final ConsultationNotificationProvider _instance =
      ConsultationNotificationProvider._internal();

  ConsultationNotificationProvider._internal();

  factory ConsultationNotificationProvider() {
    return _instance;
  }

  late NotificationProvider _provider;
  final String _table = "consultation";

  init() async {
    _provider = NotificationProvider();
    await _provider.init(sql: '''
CREATE TABLE IF NOT EXISTS '$_table' (id VARCHAR PRIMARY KEY, time VARCHAR, doctor_name VARCHAR, symptom VARCHAR, medical_history VARCHAR, payload VARCHAR, checked INTEGER)
''');
  }

  Future<int> insert(ConsultationNotificationModel consultation) async {
    return await _provider.insert(table: _table, data: consultation);
  }

  Future<ConsultationNotificationModel?> selectById(String id) async {
    Map<String, dynamic>? map =
        await _provider.selectById(table: _table, id: id);
    if (map != null) {
      return ConsultationNotificationModel.fromMap(map);
    }
    return null;
  }

  Future<List<ConsultationNotificationModel>> selectAll() async {
    List<Map<String, dynamic>> maps = await _provider.selectAll(
      table: _table,
    );
    return maps.map((e) => ConsultationNotificationModel.fromMap(e)).toList();
  }

  Future<int> deleteById(String id) async {
    try {
      return await _provider.deleteById(table: _table, id: id);
    } catch (e) {
      return 0;
    }
  }

  Future<int> update(
      ConsultationNotificationModel consultationNotificationModel) async {
    return await _provider.update(
        table: _table, data: consultationNotificationModel);
  }

  Future<int> deleteAll({required String table}) async {
    return await _provider.deleteAll(table: _table);
  }
}
