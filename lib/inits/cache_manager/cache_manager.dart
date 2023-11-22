import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/models/todo_model.dart';

class CacheManager {
  CacheManager._();

  static const _androidOptions =
      AndroidOptions(encryptedSharedPreferences: true);
  static const _iosOptions =
      IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  static const FlutterSecureStorage _secureStorage =
      FlutterSecureStorage(iOptions: _iosOptions, aOptions: _androidOptions);

  static Future<Set<String>?> getKeys() async =>
      (await _secureStorage.readAll()).keys.toSet();

  static Future<bool> containsKey(String key) async =>
      await _secureStorage.containsKey(key: key);

  static Future<void> setString(String key, String value) async =>
      await _secureStorage.write(key: key, value: value);

  static Future<void> setBool(String key, bool value) async =>
      await _secureStorage.write(key: key, value: value.toString());

  static Future<void> setNum(String key, num value) async =>
      await _secureStorage.write(key: key, value: value.toString());

  static Future<void> _setList<T>(String key, List<T> value) async {
    String buffer = json.encode(value);
    await _secureStorage.write(key: key, value: buffer);
  }

  static Future<void> setStringList(String key, List<String> value) =>
      _setList<String>(key, value);

  static Future<void> setNumList(String key, List<num> value) =>
      _setList<num>(key, value);

  static Future<void> setBoolList(String key, List<bool> value) =>
      _setList<bool>(key, value);

  static Future<String?> getString(String key) async =>
      await _secureStorage.read(key: key);

  static Future<bool?> getBool(String key) async {
    String? string = await _secureStorage.read(key: key);
    if (string == null) return null;
    if (string == 'true') {
      return true;
    } else if (string == 'false') {
      return false;
    } else {
      return null;
    }
  }

  static Future<num?> getNum(String key) async =>
      num.tryParse(await _secureStorage.read(key: key) ?? '');

  static Future<List<T>?> _getList<T>(String key) async {
    String? string = await _secureStorage.read(key: key);
    if (string == null) return null;
    List<T> list = (json.decode(string) as List).cast<T>();
    return list;
  }

  static Future<List<String>?> getStringList(String key) =>
      _getList<String>(key);

  static Future<List<num>?> getNumList(String key) => _getList<num>(key);

  static Future<List<bool>?> getBoolList(String key) => _getList<bool>(key);

  static Future<void> remove(String key) async =>
      await _secureStorage.delete(key: key);

  static Future<void> cacheTodoModel(ToDoModel model) async {
    String json = model.toJson();
    List<String>? lst = await getStringList("openedModels");
    if (lst != null && lst.isNotEmpty) {
      if (lst.contains(json)) {
        return;
      }
      lst.add(json);
      setStringList("openedModels", lst);
    } else {
      setStringList("openedModels", [json]);
    }
  }

  static Future<List<String>> getCachedTodoModels() async {
    List<String>? lst = await getStringList("openedModels");

    if (lst != null) {
      List<String> reversedLst = lst.reversed.toList();
      return reversedLst;
    }
    return [];
  }

  static Future<void> clearAll() async => await _secureStorage.deleteAll();
}
