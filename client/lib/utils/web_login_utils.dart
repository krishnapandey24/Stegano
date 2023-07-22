import "package:universal_html/html.dart" as html;

class WebLoginUtils{

  static void storeToken(String token) {
    html.window.localStorage['jwtToken'] = token;
  }

  static bool isLoggedIn() {
    final token = html.window.localStorage['jwtToken'];
    return token != null && token.isNotEmpty;
  }

  static String? retrieveToken() {
    return html.window.localStorage['jwtToken'];
  }

}