import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService {
  static const String _baseUrl = 'https://api.escuelajs.co/api/v1';

  // Call the login API, return access token on success.
  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      // Expected response: { "access_token": "...", "refresh_token": "..." }
      return data['access_token'];
    } else {
      // Handle error (e.g., wrong credentials)
      return null;
    }
  }

  // Fetch user profile using the access token to get the role.
  Future<User?> fetchUserProfile(String token) async {
    final url = Uri.parse('$_baseUrl/auth/profile');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      return null;
    }
  }
}
