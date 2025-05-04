import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sign_up/routes/app_routes.dart';
import '../services/login_service.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  final LoginService loginService = Get.find();

  Future<void> login() async {
    isLoading.value = true;

    final response = await loginService.login(email.value, password.value);

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
