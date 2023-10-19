import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDataBase {
  final FlutterSecureStorage storage;
  LocalDataBase({required this.storage});

  Future<String?> readValue(String key) {
    return storage.read(key: key);
  }

  Future<Map<String, String>> readAllValue() {
    return storage.readAll();
  }

  Future<void> deleteValue(String key) {
    return storage.delete(key: key);
  }

  Future<void> deleteAllValues() {
    return storage.deleteAll();
  }

  Future<void> write(String key, String value) {
    return storage.write(key: key, value: value);
  }
}
