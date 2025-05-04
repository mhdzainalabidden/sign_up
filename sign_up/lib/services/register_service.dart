import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:sign_up/models/registrar_model.dart';

class RegisterService {
  final String _baseUrl = 'https://your-api.com'; // replace with your baseurl
  final http.Client _client;

  RegisterService({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$_baseUrl/register');
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    final Map<String, dynamic> body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final result = RegistrarModel.fromJson(body);

      // Persist token in local storage
      final box = GetStorage();
      await box.write('token', result.token);
      return body;
    } else {
      // Bubble up error message
      final errorMsg = body['message'] ?? 'Registration failed';
      throw Exception(errorMsg);
    }
  }
}
