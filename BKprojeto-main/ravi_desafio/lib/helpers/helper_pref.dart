import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperPref {
  static saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  static saveId(String idUser) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('id_user', idUser);
  }

  static Future<String?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id_user');
  }

  static removeId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id_user');
  }

  static saveIdDto1(String idDto) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('id_dto1', idDto);
  }

  static Future<String?> getIdDto1() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('id_dto1');
  }

  static String getIdByToken(String token) {
    Map<String, dynamic> tokenDecoded = JwtDecoder.decode(token);
    return tokenDecoded['sub'];
  }
}
