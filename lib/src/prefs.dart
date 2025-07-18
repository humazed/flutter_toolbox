import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> prefs() async =>
    await SharedPreferences.getInstance();

Future<void> updatePrefs(String key, dynamic value) async {
  final prefs = await SharedPreferences.getInstance();
  if (value is bool) {
    await prefs.setBool(key, value);
  } else if (value is String) {
    await prefs.setString(key, value);
  } else if (value is double) {
    await prefs.setDouble(key, value);
  } else if (value is int) {
    await prefs.setInt(key, value);
  } else if (value is List<String>) {
    await prefs.setStringList(key, value);
  }
}
