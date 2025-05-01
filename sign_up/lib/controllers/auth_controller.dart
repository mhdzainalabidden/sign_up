import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sign_up/views/admin_dashboard_page.dart';
import 'package:sign_up/views/kitchen_dashboard_page.dart';
import 'package:sign_up/views/receptionist_dashboard_page.dart';
import '../models/signup_model.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final box = GetStorage();

  // Text controllers for inputs
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Password visibility toggle
  var obscurePassword = true.obs;

  // Toggle password show/hide
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Login action: validate and call API
  void login() async {
    if (!formKey.currentState!.validate()) {
      return; // Validation failed
    }
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Call login API
    String? token = await _authService.login(email, password);
    if (token == null) {
      Get.snackbar(
        'Error',
        'Invalid credentials',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Store token using GetStorage
    await box.write(
      'token',
      token,
    ); // See example usage&#8203;:contentReference[oaicite:6]{index=6}

    // Fetch user profile to get role
    User? user = await _authService.fetchUserProfile(token);
    if (user == null) {
      Get.snackbar(
        'Error',
        'Failed to fetch user profile',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Navigate based on role
    switch (user.role) {
      case 'admin':
        Get.offAll(() => AdminDashboardPage());
        break;
      case 'receptionist':
        Get.offAll(() => ReceptionistDashboardPage());
        break;
      case 'kitchen supervisor':
        Get.offAll(() => KitchenDashboardPage());
        break;
      default:
        Get.snackbar(
          'Error',
          'Unknown role: ${user.role}',
          snackPosition: SnackPosition.BOTTOM,
        );
    }
  }
}
