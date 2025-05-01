import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sign_up/models/login_model.dart';

class AuthService {
  static const _baseUrl = 'https://api.escuelajs.co/api/v1/auth';

  /// Calls POST /login and returns a parsed [LoginResponse].
  Future<LoginResponse> login(String email, String password) async {
    final uri = Uri.parse('$_baseUrl/login');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (resp.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(resp.body));
    } else {
      throw Exception('Failed to login: ${resp.statusCode}');
    }
  }
}
