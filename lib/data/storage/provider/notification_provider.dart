import 'package:sqflite/sqflite.dart';

import 'package:healthline/utils/log_data.dart';

class NotificationProvider {
  // // singleton
  // static final NotificationProvider _instance = NotificationProvider._internal();

  // factory NotificationProvider() {
  //   return _instance;
  // }

  // NotificationProvider._internal();
  late Database db;
  late String databasesPath;

  String join(String databasesPath, String s) {
    return databasesPath + s;
  }

  init({required String sql}) async {
    // Get a location using getDatabasesPath
    databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "healthline.db");

    // // Delete the database
    // await deleteDatabase(path);
    await open(path: path, sql: sql);
  }

  Future open({required String path, required String sql}) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(sql);
    });
  }

  Future<int> insert({required String table, required dynamic data}) async {
    try {
      return await db.insert(table, data.toMap());
    } catch (e) {
      logPrint(e);
      return 0;
    }
  }

  Future<Map<String, dynamic>?> selectById(
      {required String table, required String id}) async {
    List<Map<String, dynamic>> maps =
        await db.query(table, where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> selectAll({required String table}) async {
    List<Map<String, dynamic>> maps = await db.query(
      table,
    );
    return maps;
  }

  Future<int> deleteById({required String table, required String id}) async {
    try {
      return await db.delete(table, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      logPrint(e);
      return 0;
    }
  }

  Future<int> update({required String table, required dynamic data}) async {
    try {
      return await db
          .update(table, data.toMap(), where: 'id = ?', whereArgs: [data.id]);
    } catch (e) {
      logPrint(e);
      return 0;
    }
  }

  Future<int> deleteAll({required String table}) async {
    try{
    return await db.delete(table);
    }
    catch(e){
      logPrint(e);
      return 0;
    }
  }

  Future close() async => db.close();
}
