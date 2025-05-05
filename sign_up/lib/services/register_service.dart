import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:sign_up/models/registrar_model.dart';
import 'package:sign_up/utils/constants.dart';

class RegisterService {
  final http.Client _client;
  static const String apiBaseUrl = AppConstants.apiBaseUrl; // Use your base URL

  RegisterService({http.Client? client}) : _client = client ?? http.Client();

  Future<RegistrarModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('$apiBaseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    final RegistrarModel body = jsonDecode(response.body);

    // Check if the response is successful
    // and handle the response accordingly
    if (response.statusCode == 200) {
      final result = RegistrarModel.fromJson(json.decode(response.body));
      // Persist token in local storage
      final box = GetStorage();
      await box.write('token', result.token);
      return body;
    } else {
      // Bubble up error message
      final errorMsg = body.message;
      throw Exception(errorMsg);
    }
  }
}
