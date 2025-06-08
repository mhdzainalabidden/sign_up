import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:alyarmok_hotel/modules/supervisor/controllers/orders_archive_controllers.dart';
import 'package:alyarmok_hotel/modules/supervisor/models/order_model.dart';
import 'package:alyarmok_hotel/modules/supervisor/view/main_layout.dart';

class OrdersArchivePage extends StatelessWidget {
  final OrdersArchiveContrller ctrl = Get.put(OrdersArchiveContrller());

  OrdersArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Orders Archive',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),

            // التاريخ والزر
            Column(
              children: [
                Row(
                  children: [
                    _buildDatePicker(
                      label: 'Start Date',
                      dateObs: ctrl.startDate,
                    ),
                    SizedBox(width: 8.w),
                    _buildDatePicker(label: 'End Date', dateObs: ctrl.endDate),
                    SizedBox(width: 55.w),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          48.w,
                          48.h,
                        ), // More practical size for various screens
                        backgroundColor: const Color.fromARGB(
                          255,
                          235,
                          235,
                          235,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                      ),
                      onPressed: ctrl.fetchByDateRange,
                      child: FittedBox(
                        // Ensures text fits within the button responsively
                        child: Text(
                          'Fetch',
                          style: TextStyle(
                            fontSize: 7.sp,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // قائمة الطلبات
            Expanded(child: _buildOrdersList()),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker({required String label, required RxString dateObs}) {
    return Obx(() {
      return InkWell(
        onTap: () async {
          final picked = await showDatePicker(
            // ignore: deprecated_member_use
            barrierColor: Colors.blueAccent.withOpacity(0.5),
            context: Get.context!,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );
          if (picked != null) {
            dateObs.value = picked.toIso8601String().split('T').first;
          }
        },
        child: Container(
          height: 45.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 144, 199, 250),
            border: Border.all(color: const Color(0xFFE9CBCC)),
            borderRadius: BorderRadius.circular(20.r),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateObs.value.isEmpty ? label : dateObs.value,
                style: TextStyle(fontSize: 6.sp),
              ),
              Icon(Icons.calendar_today, size: 6.sp),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildOrdersList() {
    return Obx(() {
      if (ctrl.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (ctrl.orders.isEmpty) {
        return const Center(child: Text('No orders found'));
      }
      return ListView.separated(
        itemCount: ctrl.orders.length,
        separatorBuilder: (_, _) => SizedBox(height: 12.h),
        itemBuilder: (_, i) => _orderCard(ctrl.orders[i]),
      );
    });
  }

  Widget _orderCard(Datum o) {
    final badgeColor =
        {
          'pending': Colors.orange,
          'preparing': Colors.blue,
          'cancelled': Colors.red,
          'approved': Colors.green,
        }[o.status]!;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                o.orderType == 'table'
                    ? 'Table ${o.tableNumber}'
                    : 'Room ${o.roomNumber}',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: badgeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  o.status.capitalize!,
                  style: TextStyle(
                    color: badgeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 9.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 4.h),
          Text('By: ${o.user.name}', style: TextStyle(fontSize: 8.sp)),
          Text(
            'Date: ${o.preferredTime.toLocal().toString().split(' ')[0]}',
            style: TextStyle(fontSize: 8.sp),
          ),
          Text('Total: \$${o.totalPrice}', style: TextStyle(fontSize: 8.sp)),

          SizedBox(height: 8.h),
          ...o.orderItems.map(
            (item) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.menuItem.enName, style: TextStyle(fontSize: 8.sp)),
                  Text(
                    '\$${item.totalPrice}',
                    style: TextStyle(fontSize: 8.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
