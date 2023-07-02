import 'package:shared_preferences/shared_preferences.dart';

class MobileLoginUtils{

  static Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token);
  }

// Function for retrieving JWT token from SharedPreferences
  static Future<String?> retrieveToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }

// Function for checking if JWT token exists in SharedPreferences
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken')!=null;
  }
}