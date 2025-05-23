import 'package:get/get.dart';
import 'package:sign_up/models/order_model.dart';
import '../services/orders_archive_service.dart';

class OrdersArchiveContrller extends GetxController {
  final OrderArchiveService _service = Get.find();

  var isLoading = false.obs;
  var orders = <Datum>[].obs;

  // قيم التواريخ بصيغة YYYY-MM-DD
  var startDate = ''.obs;
  var endDate = ''.obs;

  Future<void> fetchByDateRange() async {
    if (startDate.isEmpty || endDate.isEmpty) {
      Get.snackbar('Error', 'Please select both start and end dates');
      return;
    }
    isLoading.value = true;
    try {
      final model = await _service.getOrdersByDateRange(
        startDate.value,
        endDate.value,
      );
      orders.value = model.data;
    } catch (e) {
      Get.snackbar('Error loading orders', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
