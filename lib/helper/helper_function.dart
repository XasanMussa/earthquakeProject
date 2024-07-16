import 'package:shared_preferences/shared_preferences.dart';

class helperFunctions {
  static String userLoginKey = "USERLOGINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String emailKey = "EMAILKEY";

  static Future<bool> saveUserLogedInStatus(bool isUserLogedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoginKey, isUserLogedIn);
  }

  static Future<bool> saveUserName(String username) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, username);
  }

  static Future<bool> saveEmail(String email) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(emailKey, email);
  }

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoginKey);
  }
}
