import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'local_storage.dart';

class SecureLocalStorage implements LocalStorage {
  static final SecureLocalStorage _instance = SecureLocalStorage._internal();
  final dynamic _storage = FlutterSecureStorage();

  factory SecureLocalStorage() {
    return _instance;
  }

  SecureLocalStorage._internal() {
    print('SecureLocalStorage id = $_storage.hashCode');
  }

  @override
  void saveValue(String key, value) async {
    await _storage.write(key: key, value: json.encode(value));
  }

  @override
  Future<String> readValue(String key) async {

    final String value = await _storage.read(key: key);

    return  json.decode(value) ;
  }

  @override
  void deleteAll() async {
    await _storage.deleteAll();
  }
}