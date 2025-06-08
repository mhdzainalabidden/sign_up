// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../auth/models/login_model.dart';
import '../../shared/utils/constants.dart'; // Make sure to set your baseUrl here

class LoginService extends GetxService {
  final http.Client _client;

  static final String apiBaseUrl = AppConstants.apiBaseUrl; // Use your base URL
  static const String loginEndP =
      AppConstants.loginEndpoint; // Use your login endpoint
  LoginService({http.Client? client}) : _client = client ?? http.Client();

  Future<LoginModel?> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$apiBaseUrl$loginEndP');
    try {
      final response = await _client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print('🔍 [LoginService] GET $uri'); // 🔍
      print(
        '🔍 [LoginService] ← ${response.statusCode}: ${response.body}',
      ); // 🔍
      if (response.statusCode == 200) {
        return LoginModel.fromJson(json.decode(response.body));
      } else {
        // Handle error (e.g., invalid credentials)
        throw Exception('Failed to login');
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }
}
