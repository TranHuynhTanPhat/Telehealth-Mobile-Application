// ignore_for_file: constant_identifier_names

import 'package:healthline/data/storage/data_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  late SharedPreferences _pref;

  static final AppStorage instance = AppStorage._internal();

  factory AppStorage() {
    return instance;
  }

  AppStorage._internal();

  init() async {
    _pref = await SharedPreferences.getInstance();
  }

  setString({required String key, required String value}) {
    _pref.setString(key, value);
  }

  setBool({required String key, required bool value}) {
    _pref.setBool(key, value);
  }

  String? getString({required String key}) {
    return _pref.getString(key);
  }

  bool? getBool({required String key}) {
    return _pref.getBool(key);
  }

  remove({required String key}) {
    _pref.remove(key);
  }

  clear() {
    _pref.remove(DataConstants.DOCTOR);
    _pref.remove(DataConstants.PATIENT);
    _pref.remove(DataConstants.REMEMBER);
  }

  // Future<void> savePatient({required LoginResponse user}) async {
  //   _pref.setString(PATIENT, user.toJson());
  // }

  // Future<void> saveDoctor({required LoginResponse user}) async {
  //   _pref.setString(DOCTOR, user.toJson());
  // }

  // Future<LoginResponse?> getPatient() async {
  //   try {
  //     LoginResponse user = LoginResponse.fromJson(_pref.getString(PATIENT)!);
  //     return user;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Future<LoginResponse?> getDoctor() async {
  //   try {
  //     LoginResponse user = LoginResponse.fromJson(_pref.getString(DOCTOR)!);
  //     return user;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // clearPatient() async {
  //   _pref.remove(PATIENT);
  // }

  // clearDoctor() async {
  //   _pref.remove(DOCTOR);
  // }
}
