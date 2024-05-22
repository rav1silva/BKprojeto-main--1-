import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();

  factory DioClient() {
    return _singleton;
  }

  DioClient._internal();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://future-burguer-novo.onrender.com",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      sendTimeout: const Duration(milliseconds: 3000),
    ),

  );

  Future<Response> login(String email, String password) async {
    return await dio.post('/auth/login', data: {
      'email': email,
      'password': password
    });
  }
}
