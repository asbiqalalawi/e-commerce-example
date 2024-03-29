import 'package:e_commerce_example/app/service/service_const.dart';

class LoginService {
  Future<String> login(String username, String password) async {
    try {
      final response = await dio.post('$baseURL/auth/login', data: {
        'username': username,
        'password': password,
      });
      return response.data['token'];
    } catch (_) {
      rethrow;
    }
  }
}
