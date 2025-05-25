import 'package:get/get.dart';
import '../models/invoices_model.dart';
import '../services/invoice_service.dart';

enum InvoiceStatusFilter { all, paid, unpaid, cancelled }

class InvoicesController extends GetxController {
  final InvoiceService _service = Get.find();

  var allInvoices = <Invoice>[].obs;
  var filteredInvoices = <Invoice>[].obs;
  var isLoading = false.obs;

  var statusFilter = InvoiceStatusFilter.all.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInvoices();
  }

  Future<void> fetchInvoices() async {
    isLoading(true);
    try {
      final model = await _service.fetchAllInvoices();
      allInvoices.value = model.invoices;
      applyFilters();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void changeStatusFilter(InvoiceStatusFilter f) {
    statusFilter.value = f;
    applyFilters();
  }

  void applyFilters() {
    List<Invoice> list = allInvoices;

    // فلترة حسب الحالة
    switch (statusFilter.value) {
      case InvoiceStatusFilter.paid:
        list = allInvoices.where((i) => i.status == Status.PAID).toList();
        break;
      case InvoiceStatusFilter.unpaid:
        list = allInvoices.where((i) => i.status == Status.UNPAID).toList();
        break;
      case InvoiceStatusFilter.cancelled:
        list = allInvoices.where((i) => i.status == Status.CANCELLED).toList();
        break;
      case InvoiceStatusFilter.all:
        // نترك allInvoices كما هو
        break;
    }

    // فلترة النطاق الزمني كما قبل...
    if (startDate.isNotEmpty && endDate.isNotEmpty) {
      final start = DateTime.parse(startDate.value);
      final end = DateTime.parse(endDate.value);
      list =
          list
              .where(
                (i) =>
                    i.date.isAfter(start.subtract(const Duration(days: 1))) &&
                    i.date.isBefore(end.add(const Duration(days: 1))),
              )
              .toList();
    }

    filteredInvoices.value = list;
  }

  void setStartDate(String d) {
    startDate.value = d;
    applyFilters();
  }

  void setEndDate(String d) {
    endDate.value = d;
    applyFilters();
  }
}
