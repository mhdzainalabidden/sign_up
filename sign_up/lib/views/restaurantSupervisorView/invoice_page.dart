import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/invoices_controller.dart';
import 'main_layout.dart';
import 'invoices_componant/invoice_filters.dart';
import 'invoices_componant/invoice_card.dart';

class InvoicesPage extends GetView<InvoicesController> {
  const InvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invoices',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            InvoiceFilters(),
            SizedBox(height: 16.h),
            Expanded(child: _buildList()),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.filteredInvoices.isEmpty) {
        return Center(child: Text('No invoices'));
      }
      return ListView.separated(
        itemCount: controller.filteredInvoices.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder:
            (_, i) => InvoiceCard(invoice: controller.filteredInvoices[i]),
      );
    });
  }
}
