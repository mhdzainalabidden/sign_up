import 'package:get/get.dart';
import 'package:sign_up/controllers/invoices_controller.dart';
import 'package:sign_up/services/invoice_service.dart';

class InvoicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceService>(() => InvoiceService());
    Get.lazyPut<InvoicesController>(() => InvoicesController());
  }
}
