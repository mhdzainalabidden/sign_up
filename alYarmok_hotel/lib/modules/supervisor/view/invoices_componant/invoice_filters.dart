import 'package:flutter/material.dart';
import 'package:alyarmok_hotel/modules/supervisor/controllers/invoices_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceFilters extends StatelessWidget {
  const InvoiceFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<InvoicesController>();
    return Obx(() {
      return Column(
        children: [
          Wrap(
            spacing: 12.w,
            children:
                InvoiceStatusFilter.values.map((f) {
                  final label =
                      {
                        InvoiceStatusFilter.all: 'All',
                        InvoiceStatusFilter.paid: 'Paid',
                        InvoiceStatusFilter.unpaid: 'Unpaid',
                        InvoiceStatusFilter.cancelled: 'Cancelled',
                      }[f]!;

                  return ChoiceChip(
                    label: Text(label),
                    selected: ctrl.statusFilter.value == f,
                    selectedColor: Colors.blue, // اختر اللون اللي يناسبك
                    backgroundColor:
                        Colors.grey.shade300, // ولون الخلفية غير المحدد
                    labelStyle: TextStyle(
                      color:
                          ctrl.statusFilter.value == f
                              ? Colors.white
                              : Colors.black,
                    ),
                    onSelected: (_) => ctrl.changeStatusFilter(f),
                  );
                }).toList(),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(('Date_range: ')),
              SizedBox(width: 4.w),

              _datePicker(
                label: 'Start date',
                onPick: ctrl.setStartDate,
                dateObs: ctrl.startDate,
              ),
              SizedBox(width: 8.w),
              _datePicker(
                label: 'End date',
                onPick: ctrl.setEndDate,
                dateObs: ctrl.endDate,
              ),
            ],
          ),
        ],
      );
    });
  }
}

Widget _datePicker({
  required String label,
  required void Function(String) onPick,
  required RxString dateObs,
}) {
  return Obx(() {
    return InkWell(
      onTap: () async {
        final d = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );
        if (d != null) onPick(d.toIso8601String().split('T').first);
      },
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.centerLeft,
        child: Text(dateObs.value.isEmpty ? label : dateObs.value),
      ),
    );
  });
}
