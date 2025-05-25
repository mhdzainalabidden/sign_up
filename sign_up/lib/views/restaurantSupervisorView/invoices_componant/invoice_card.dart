import 'package:flutter/material.dart';
import '../../../models/invoices_model.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;

  const InvoiceCard({super.key, required this.invoice});

  Color _getStatusColor(Status status) {
    switch (status) {
      case Status.UNPAID:
        return const Color.fromARGB(255, 8, 136, 57);
      case Status.PAID:
        return Colors.green;
      case Status.CANCELLED:
        return Colors.red;
    }
  }

  String _getStatusText(Status status) {
    switch (status) {
      case Status.UNPAID:
        return ' UNPAID';
      case Status.PAID:
        return 'PAID';
      case Status.CANCELLED:
        return 'CANCELLED';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(invoice.status);
    final statusText = _getStatusText(invoice.status);
    final formattedDate = invoice.date.toLocal().toString().split(' ')[0];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'invoice-ID #${invoice.id}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blueGrey[800],
                  ),
                ),
                Text(formattedDate, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              invoice.description,
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
            const SizedBox(height: 6),

            // Type and Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'itemType: ${invoice.itemType.name}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  '${invoice.price} \$',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Status badge
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
