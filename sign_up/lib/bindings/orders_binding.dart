import 'package:get/get.dart';
import '../controllers/orders_controller.dart';
import '../services/order_service.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OrderService>(OrderService());
    Get.put<OrdersController>(OrdersController());
  }
}
//   }