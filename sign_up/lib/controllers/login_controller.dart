import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../services/auth_service.dart';
import '../views/admin_dashboard_page.dart';
import '../views/receptionist_dashboard_page.dart';
import '../views/kitchen_dashboard_page.dart';
import '../models/login_model.dart';

class LoginController extends GetxController {
  // Form
  final formKey = GlobalKey<FormState>();
  final email = ''.obs;
  final password = ''.obs;

  // UI state
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  final _authService = AuthService();
  final _storage = GetStorage();

  void togglePassword() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    isLoading(true);
    try {
      final response = await _authService.login(
        email.value.trim(),
        password.value,
      );
      if (!response.success) {
        Get.snackbar(
          'Login Failed',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        final token = response.data.token;
        final role = response.data.user.role;
        // Persist
        await _storage.write('token', token);
        await _storage.write('role', role);
        // Navigate
        switch (role) {
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
              'Unknown role: $role',
              snackPosition: SnackPosition.BOTTOM,
            );
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
