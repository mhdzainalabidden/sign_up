import 'package:get/get.dart';
import 'package:alyarmok_hotel/modules/supervisor/controllers/orders_archive_controllers.dart';
import 'package:alyarmok_hotel/modules/supervisor/services/orders_archive_service.dart';

class OrderArchiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OrderArchiveService>(OrderArchiveService());
    Get.put<OrdersArchiveContrller>(OrdersArchiveContrller());
  }
}
//   }