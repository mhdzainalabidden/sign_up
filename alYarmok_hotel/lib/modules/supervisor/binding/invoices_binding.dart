import 'package:get/get.dart';
import 'package:alyarmok_hotel/modules/supervisor/controllers/invoices_controller.dart';
import 'package:alyarmok_hotel/modules/supervisor/services/invoice_service.dart';

class InvoicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceService>(() => InvoiceService());
    Get.lazyPut<InvoicesController>(() => InvoicesController());
  }
}
