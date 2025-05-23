// ignore_for_file: avoid_print

import 'package:sign_up/models/order_model.dart';

import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sign_up/utils/constants.dart';

class OrderArchiveService {
  final String baseUrl = AppConstants.apiBaseUrl;

  final String getOrdersByDateRangeEndpoint =
      AppConstants.getOrdersByDateRangeEndpoint;
  Map<String, String> get _headers {
    // final token = box.read<String>('token') ?? '';
    final token =
        '5|ZeAKf2GgyZyDDfJoMTecDYG0uN16469uH5ptURDo'; // Replace with actual token
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // استخدم هذا الدالة لجلب الطلبات حسب التاريخ
  // مثال: getOrdersByDateRange('2023-01-01', '2023-01-31');
  Future<OrderModel> getOrdersByDateRange(String start, String end) async {
    final uri = Uri.parse(
      '$baseUrl$getOrdersByDateRangeEndpoint'
      '?start_date=$start&end_date=$end',
    );
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      return OrderModel.fromJson(json.decode(res.body));
    } else {
      throw Exception('Status ${res.statusCode}: ${res.body}');
    }
  }
}
