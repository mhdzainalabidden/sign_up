import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alyarmok_hotel/modules/supervisor/view/main_layout.dart';
import 'package:alyarmok_hotel/modules/supervisor/view/orders_componant/order_card.dart';
import 'package:alyarmok_hotel/modules/supervisor/view/orders_componant/orders_filter.dart';
import '../controllers/orders_controller.dart';

class OrdersPage extends GetView<OrdersController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: controller.fetchAllOrders,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            const OrderFilters(),
            SizedBox(height: 16.h),
            Expanded(child: _buildOrdersList()),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.orders.isEmpty) {
        return const Center(child: Text('No orders found'));
      }
      return ListView.separated(
        itemCount: controller.orders.length,
        separatorBuilder: (_, _) => SizedBox(height: 12.h),
        itemBuilder: (_, idx) => OrderCard(order: controller.orders[idx]),
      );
    });
  }
}
