import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> prefs() async =>
    await SharedPreferences.getInstance();
