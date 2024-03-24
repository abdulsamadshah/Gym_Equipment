
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/providers/Constant.dart';




class StorageServices {
  late final SharedPreferences _prefs;

  Future<StorageServices> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }


  //
  // bool getIsLoggedIn() {
  //   return _prefs.getString(Constant.STORAGE_USER_TOKEN_KEY) == null
  //       ? false
  //       : true;
  // }
  //


}
