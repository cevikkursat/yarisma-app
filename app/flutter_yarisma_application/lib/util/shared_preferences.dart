import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Preferences {
  static late SharedPreferences _preferences;
  static const _keyIsLogin = 'isLogin';
  static const _keyRole = 'role';
  static const _keyID = 'id';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setIsLogin(bool data) async =>
      await _preferences.setBool(_keyIsLogin, data);
  static bool getIsLogin() => _preferences.getBool(_keyIsLogin) ?? false;
  static removeIsLogin() => _preferences.remove(_keyIsLogin);

  static Future setRole(String data) async {
    Map<String, dynamic> payload = Jwt.parseJwt(data);
    return await _preferences.setString(_keyRole, payload["role"]);
  }

  static String getRole() => _preferences.getString(_keyRole) ?? "-1";
  static removeRole() => _preferences.remove(_keyRole);

  static Future setID(String data) async {
    Map<String, dynamic> payload = Jwt.parseJwt(data);
    return await _preferences.setString(_keyID, payload["id"]);
  }

  static String getID() => _preferences.getString(_keyID) ?? "-1";
  static removeID() => _preferences.remove(_keyID);
}
