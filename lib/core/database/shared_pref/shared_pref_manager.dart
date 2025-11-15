import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  final SharedPreferences prefs;

  SharedPrefManager(this.prefs);

  Future<void> writeData(String key, dynamic value) async {
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  Future<dynamic> readData(String key) async {
     if (prefs.containsKey(key)) {
      if (prefs.get(key) is int) {
        return prefs.getInt(key);
      } else if (prefs.get(key) is double) {
        return prefs.getDouble(key);
      } else if (prefs.get(key) is bool) {
        return prefs.getBool(key);
      } else if (prefs.get(key) is String) {
        return prefs.getString(key);
      } else if (prefs.get(key) is List<String>) {
        return prefs.getStringList(key);
      }
    } else {
      return null;
    }
  }

  Future<bool> deleteData(String key) async {
    return await prefs.remove(key);
  }
}
