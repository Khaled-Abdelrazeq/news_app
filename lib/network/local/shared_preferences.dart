import 'package:shared_preferences/shared_preferences.dart';

// As name in unity :)
class PlayerPref {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setBool(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool? getBool({required String key}) {
    return sharedPreferences.getBool(key);
  }
}