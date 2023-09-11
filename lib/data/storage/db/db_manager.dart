import 'dart:io';


import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DbManager {
  late Directory document;
  init() async {
    document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    initAdapter();
  }

  initAdapter() {
    // Hive.registerAdapter(UserAdapter());
  //   Hive.registerAdapter(DepartmentItemAdapter());
  }

  clearAll() {
    Hive.deleteBoxFromDisk(document.path);
  }

  // saveUser(User item) async {
  //   var box = await Hive.openBox<User>(TABLE_USER);
  //   box.clear();
  //   box.add(item);
  // }

  // Future<User?> getUser() async {
  //   var box = await Hive.openBox<User>(TABLE_USER);
  //   User? items = box.get(0);
  //   return items;
  // }

  // clearUser() async{
  //   var box = await Hive.openBox<User>(TABLE_USER);
  //   box.clear();
  // }

  // saveListDepartment(
  //     {required String hospitalId, required List<DepartmentItem> items}) async {
  //   var box = await Hive.openBox<List<DepartmentItem>>(TABLEL_DEPARTMENT);
  //   box.put(hospitalId, items);
  // }

  // Future<List<DepartmentItem>> getListDepartment(
  //     {required String hospitalId}) async {
  //   var box = await Hive.openBox<List<DepartmentItem>>(TABLEL_DEPARTMENT);
  //   final items = box.get(hospitalId);
  //   return items ?? [];
  // }
}
