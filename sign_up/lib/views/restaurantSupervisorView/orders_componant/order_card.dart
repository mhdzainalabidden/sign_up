import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controllers/orders_controller.dart';
import '../../../models/order_model.dart';

class OrderCard extends StatelessWidget {
  final Datum order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<OrdersController>();
    final badgeColor =
        {
          'pending': Colors.orange,
          'preparing': Colors.blue,
          'cancelled': Colors.red,
          'approved': Colors.green,
        }[order.status] ??
        Colors.grey;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      padding: EdgeInsets.all(6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    order.orderType == 'table'
                        ? 'Table ${order.tableNumber}'
                        : 'Room ${order.roomNumber}',
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '     ${order.user.name}',
                    style: TextStyle(
                      fontSize: 3.5.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: badgeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  order.status.capitalize!,
                  style: TextStyle(
                    color: badgeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text('people : ${order.numberOfPeople}'),
          Text(
            'date : ${order.preferredTime.toLocal().toString().split(' ')[0]}',
          ),
          Text(
            'time : ${order.preferredTime.toLocal().toString().split(' ')[1].substring(0, 5)}',
          ),
          SizedBox(height: 12.h),
          // Items
          Card(
            margin: EdgeInsets.zero,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:
                    order.orderItems.map((item) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(item.menuItem.enName)),
                            Text(
                              '\$${double.parse(item.totalPrice).toStringAsFixed(2)}',
                            ),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total price : \$${order.totalPrice}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (order.status == 'pending')
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => ctrl.approve(order),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: const Text('Accept Order'),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => ctrl.reject(order),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    child: const Text('Reject Order'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
