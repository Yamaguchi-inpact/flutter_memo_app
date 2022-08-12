import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> setSharedPreferences(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String> getSharedPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(key);
    if (result == null) {
      return "";
    } else {
      return result;
    }
  }

  static Future<void> setSharedDatePreferences(
      String key, DateTime value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int timestamp = value.millisecondsSinceEpoch;
    prefs.setInt('myTimestampKey', timestamp);
  }

  static Future<DateTime> getSharedDatePreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getInt('myTimestampKey');
    if (result == null) {
      return DateTime.now();
    } else {
      return DateTime.fromMillisecondsSinceEpoch(result);
    }
  }
}