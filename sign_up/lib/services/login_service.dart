import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';
import '../utils/constants.dart'; // Make sure to set your baseUrl here

class LoginService extends GetxService {
  static const String apiBaseUrl = AppConstants.apiBaseUrl; // Use your base URL
  Future<LoginModel?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$apiBaseUrl/login',
        ), // Replace with your actual login endpoint
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(json.decode(response.body));
      } else {
        // Handle error (e.g., invalid credentials)
        throw Exception('Failed to login');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error during login: $e');
      return null;
    }
  }
}
