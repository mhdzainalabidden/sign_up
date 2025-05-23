import 'package:get/get.dart';
import 'package:sign_up/controllers/orders_archive_controllers.dart';
import 'package:sign_up/services/orders_archive_service.dart';

class OrderArchiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OrderArchiveService>(OrderArchiveService());
    Get.put<OrdersArchiveContrller>(OrdersArchiveContrller());
  }
}
//   }