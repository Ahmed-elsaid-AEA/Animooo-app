import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper<T> {
  String boxName;
  bool _isLocked = false;

  HiveHelper(this.boxName);

  Future<R> _runSafely<R>(Future<R> Function(Box<T>) action) async {
    while (_isLocked) {
      //block code
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _isLocked = true;
    late Box<T> box;
    try {
      box = await _openBox();
      final result = await action(box);
      return result;
    } catch (e) {
      rethrow;
    } finally {
      await _closeBox(box);
      _isLocked = false;
    }
  }

  //?OPEN BOX
  Future<Box<T>> _openBox() async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    }
    return await Hive.openBox<T>(boxName);
  } //?OPEN BOX

  Future<void> _closeBox(Box<T> box) async {
    if (Hive.isBoxOpen(boxName)) {
      return await box.close();
    }
  }

  Future<void> addValue({required String key, required T value}) async {
    await _runSafely((box) async => await box.put(key, value));
  }

  Future<bool> updateValue({required String key, required T value}) async {
    return await _runSafely((box) async {
      if (box.containsKey(key)) {
        await box.put(key, value);
        return true;
      }
      return false;
    });
  }

  Future<bool> deleteValue({required String key}) async {
    return await _runSafely((box) async {
      if (box.containsKey(key)) {
        await box.delete(key);
        return true;
      }
      return false;
    });
  }

  Future<T?> getValue({required String key}) async {
    return await _runSafely((box) async => box.get(key));
  }

  Future<Map<dynamic, T>> getAllData() async {
    return await _runSafely((box) async => box.toMap());
  }
}
