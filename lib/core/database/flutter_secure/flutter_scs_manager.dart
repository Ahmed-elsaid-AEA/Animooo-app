// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class FlutterSecureStorageManager {
//   final FlutterSecureStorage storage;
//
//   FlutterSecureStorageManager(this.storage);
//
//   Future<void> writeData(String key, dynamic value) async {
//     await storage.write(key: key, value: value);
//   }
//
//   Future<dynamic> readData(String key) async {
//     return await storage.read(key: key);
//   }
//
//   Future<void> deleteData(String key) async {
//     return await storage.delete(key: key);
//   }
//
//   Future<void> deleteAllData() async {
//     return await storage.deleteAll();
//   }
//
//   Future<void> updateData(String key, dynamic value) async {
//     return await storage.write(key: key, value: value);
//   }
// }

import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:animooo/core/resources/conts_values.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';

class FlutterSecureStorageManager {
  final FlutterSecureStorage storage;

  const FlutterSecureStorageManager(this.storage);

  Future<String?> getAccessToken() async {
    final box = await _openEncryptedBoxAccessToken();
    final encryptedToken = box.get(ConstsValuesManager.accessTokenKeyHive);
    return encryptedToken;
  }

  Future<void> writeAccessToken(String token) async {
    var box = await _openEncryptedBoxAccessToken();
    await box.put(ConstsValuesManager.accessTokenKeyHive, token);
  }

  Future<String?> getRefreshToken() async {
    final box = await _openEncryptedBoxRefreshToken();
    final encryptedToken = box.get(ConstsValuesManager.refreshTokenKeyHive);
    return encryptedToken;
  }

  Future<void> writeRefreshToken(String token) async {
    var box = await _openEncryptedBoxRefreshToken();
    await box.put(ConstsValuesManager.refreshTokenKeyHive, token);
  }

  Future<Box<String>> _openEncryptedBoxAccessToken() async {
    String? encodedKey = await storage.read(
      key: ConstsValuesManager.accessTokenKeySecured,
    );

    if (encodedKey == null) {
      final newKey = _generateSecureKey();
      encodedKey = base64UrlEncode(newKey);
      await storage.write(
        key: ConstsValuesManager.accessTokenKeySecured,
        value: encodedKey,
      );
    }
    return Hive.openBox<String>(
      ConstsValuesManager.accessTokenBoxName,
      encryptionCipher: HiveAesCipher(base64Url.decode(encodedKey)),
    );
  }

  Future<Box<String>> _openEncryptedBoxRefreshToken() async {
    String? encodedKey = await storage.read(
      key: ConstsValuesManager.refreshTokenKeySecured,
    );

    if (encodedKey == null) {
      final newKey = _generateSecureKey();
      encodedKey = base64UrlEncode(newKey);
      await storage.write(
        key: ConstsValuesManager.refreshTokenKeySecured,
        value: encodedKey,
      );
    }
    return Hive.openBox<String>(
      ConstsValuesManager.refreshTokenBoxName,
      encryptionCipher: HiveAesCipher(base64Url.decode(encodedKey)),
    );
  }

  Uint8List _generateSecureKey() {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(32, (_) => random.nextInt(256)),
    );
  }

  Future<void> deleteAccessToken() async {
    var box = await _openEncryptedBoxAccessToken();
    await box.delete(ConstsValuesManager.accessTokenKeyHive);
    await storage.delete(key: ConstsValuesManager.accessTokenKeySecured);
  }

  Future<void> deleteRefreshToken() async {
    var box = await _openEncryptedBoxRefreshToken();
    await box.delete(ConstsValuesManager.refreshTokenKeyHive);
    await storage.delete(key: ConstsValuesManager.refreshTokenKeySecured);
  }
}
