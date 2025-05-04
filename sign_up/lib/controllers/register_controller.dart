import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sign_up/routes/app_routes.dart';
import 'package:sign_up/services/register_service.dart';

class RegisterController extends GetxController {
  final RegisterService _service = RegisterService();
  final box = GetStorage();

  // Form fields as Rx
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;

  // UI state
  var isLoading = false.obs;
  var showPassword = false.obs;

  void togglePasswordVisibility() => showPassword.value = !showPassword.value;

  bool _validate() {
    if (name.value.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Name is required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
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

  Future<void> register() async {
    if (!_validate()) return;
    isLoading.value = true;
    try {
      // ignore: unused_local_variable
      final res = await _service.register(
        name: name.value.trim(),
        email: email.value.trim(),
        password: password.value,
      );
      // On success, navigate to Admin Dashboard
      Get.offAllNamed(AppRoutes.ADMIN_DASH);
    } catch (e) {
      Get.snackbar(
        'Registration Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
