import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageManager {
  final FlutterSecureStorage storage;

  FlutterSecureStorageManager(this.storage);

  Future<void> writeData(String key, dynamic value) async {
    await storage.write(key: key, value: value);
  }

  Future<dynamic> readData(String key) async {
    return await storage.read(key: key);
  }

  Future<void> deleteData(String key) async {
    return await storage.delete(key: key);
  }

  Future<void> deleteAllData() async {
    return await storage.deleteAll();
  }

  Future<void> updateData(String key, dynamic value) async {
    return await storage.write(key: key, value: value);
  }
}
