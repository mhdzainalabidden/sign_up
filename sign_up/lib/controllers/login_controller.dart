import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sign_up/models/login_model.dart';
import 'package:sign_up/routes/app_routes.dart';
import '../services/login_service.dart';

class LoginController extends GetxController {
  final LoginService loginService = LoginService();

  final box = GetStorage();

  LoginModel? loginData;

  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  var showPassword = false.obs;
  void togglePasswordVisibility() => showPassword.value = !showPassword.value;

  bool _validate() {
    if (email.value.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Email is required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    final emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    if (!RegExp(emailPattern).hasMatch(email.value.trim())) {
      Get.snackbar(
        'Error',
        'Enter a valid email',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    if (password.value.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }

  Future<void> login() async {
    if (!_validate()) return;

    isLoading.value = true;

    final response = await loginService.login(
      email: email.value,
      password: password.value,
    );

    if (response != null) {
      // Store the token in GetStorage
      final box = GetStorage();
      box.write('token', response.token);

      // Navigate based on the role
      switch (response.user.role) {
        case 'Admin':
          Get.offAllNamed(AppRoutes.ADMIN_DASH);
          break;
        case 'Receptionist':
          Get.offAllNamed(AppRoutes.RECEPTIONIST_DASH);
          break;
        case 'Restaurant_Supervisor':
          Get.offAllNamed(AppRoutes.RESTURANT_SUPERVISER_DASH);
          break;
        default:
          Get.snackbar('Error', 'Unknown role');
      }
    } else {
      Get.snackbar('Error', 'Login failed. Please check your credentials');
    }

    isLoading.value = false;
  }
}
