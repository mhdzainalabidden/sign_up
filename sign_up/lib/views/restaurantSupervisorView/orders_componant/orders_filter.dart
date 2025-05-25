import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/orders_controller.dart';

class OrderFilters extends StatelessWidget {
  const OrderFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<OrdersController>();
    return Obx(() {
      return Wrap(
        spacing: 12.w,
        runSpacing: 8.h,
        children:
            OrderFilter.values.map((f) {
              final label =
                  {
                    OrderFilter.all: 'All Orders',
                    OrderFilter.pending: 'pending',
                    OrderFilter.approved: 'preparing',
                    OrderFilter.cancelled: 'Rejected',
                  }[f]!;
              final selected = ctrl.activeFilter.value == f;
              return ChoiceChip(
                label: Text(label),
                selected: selected,
                onSelected: (_) => ctrl.changeFilter(f),
                selectedColor: Colors.blue,
                backgroundColor: Colors.grey.shade200,
                labelStyle: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
      );
    });
  }
}
