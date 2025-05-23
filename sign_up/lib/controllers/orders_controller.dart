// ignore_for_file: avoid_print

import 'dart:async';

import 'package:get/get.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

enum OrderFilter { all, pending, approved, cancelled }

class OrdersController extends GetxController {
  final OrderService _service = Get.find();

  // كل الطلبات من الـ API
  var allOrders = <Datum>[].obs;
  // الطلبات المعروضة بعد الفلترة
  var orders = <Datum>[].obs;

  var isLoading = false.obs;
  var activeFilter = OrderFilter.all.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllOrders();
    Timer.periodic(Duration(seconds: 30), (_) => fetchAllOrders());
  }

  Future<void> fetchAllOrders() async {
    isLoading.value = true;
    try {
      final model = await _service.getAllOrders();
      allOrders.value = model.data;
      _applyFilter();
    } catch (e) {
      Get.snackbar(
        'Error loading orders',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void changeFilter(OrderFilter filter) {
    activeFilter.value = filter;
    _applyFilter();
  }

  void _applyFilter() {
    List<Datum> filtered;
    switch (activeFilter.value) {
      case OrderFilter.pending:
        filtered = allOrders.where((o) => o.status == 'pending').toList();
        break;
      case OrderFilter.approved:
        filtered = allOrders.where((o) => o.status == 'preparing').toList();
        break;
      case OrderFilter.cancelled:
        filtered = allOrders.where((o) => o.status == 'cancelled').toList();
        break;
      case OrderFilter.all:
        filtered = List.from(allOrders);
    }
    orders.value = filtered;
  }

  Future<void> approve(Datum order) async {
    final ok = await _service.approveOrder(order.id);
    if (ok) {
      order.status = 'preparing';
      _applyFilter();
      Get.snackbar('Success', 'Order approved');
    } else {
      Get.snackbar('Error', 'Failed to approve');
    }
  }

  Future<void> reject(Datum order) async {
    final ok = await _service.rejectOrder(order.id);
    if (ok) {
      order.status = 'cancelled';
      _applyFilter();
      Get.snackbar('Success', 'Order rejected');
    } else {
      Get.snackbar('Error', 'Failed to reject');
    }
  }
}
