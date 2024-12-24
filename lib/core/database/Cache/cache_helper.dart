
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  // static late SharedPreferences sharedPrefernces;
  late SharedPreferences sharedPrefernces;
  // Here The Initialize of Cache

  // static init() async {
  init() async {
    sharedPrefernces = await SharedPreferences.getInstance();
  }

  String? getDataString({
    required String key,
  }) {
    return sharedPrefernces.getString(key);
  }

  // this fun to put data in local data

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPrefernces.setBool(key, value);
    }
    if (value is String) {
      return await sharedPrefernces.setString(key, value);
    }
    if (value is int) {
      return await sharedPrefernces.setInt(key, value);
    } else {
      return await sharedPrefernces.setDouble(key, value);
    }
  }

  // this fun to get data already saved in local database
  dynamic getData({required String key}) {
    return sharedPrefernces.get(key);
  }

  // remove data using specific key
  Future<bool> removeData({required String key}) async {
    return await sharedPrefernces.remove(key);
  }

  Future<bool> containsKey({required String key}) async {
    return sharedPrefernces.containsKey(key);
  }

  // clear data in the local database
  Future<bool> clearData() async {
    return await sharedPrefernces.clear();
  }

  /* Future<dynamic> put({
    required String key,
    required dynamic value,
  }) {} */

  final String _cachedCode = "cachedCode";

  String getCachedLanguage() {
    final code = sharedPrefernces.getString(_cachedCode);
    if (code != null) {
      return code;
    } else {
      return 'ar';
    }
  }

  Future<void> cacheLanguage(String code) async {
    await sharedPrefernces.setString(_cachedCode, code);
  }
}
