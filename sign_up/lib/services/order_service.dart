// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sign_up/utils/constants.dart';
import '../models/order_model.dart';

class OrderService {
  final box = GetStorage();
  final String baseUrl = AppConstants.apiBaseUrl;
  final String getAllOrdersEndpoint = AppConstants.getAllOrdersEndpoint;
  final String approveOrderEndpoint = AppConstants.approveOrderEndpoint;
  final String rejectOrderEndpoint = AppConstants.rejectOrderEndpoint;

  Map<String, String> get _headers {
    final token = box.read<String>('token') ?? '';
    // '5|ZeAKf2GgyZyDDfJoMTecDYG0uN16469uH5ptURDo';

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<OrderModel> getAllOrders() async {
    final uri = Uri.parse('$baseUrl$getAllOrdersEndpoint');
    print('🔍 [OrderService] GET $uri'); // 🔍
    final res = await http.get(uri, headers: _headers);
    print('🔍 [OrderService] ← ${res.statusCode}: ${res.body}'); // 🔍
    // 🐞 DEBUG LOG:

    if (res.statusCode == 200) {
      return OrderModel.fromJson(json.decode(res.body));
    } else {
      throw Exception('Status ${res.statusCode}: ${res.body}');
    }
  }

  Future<bool> approveOrder(int id) async {
    print('🔍 [OrderService] put $baseUrl$approveOrderEndpoint/$id '); // 🔍
    final urlApprodOrder = Uri.parse('$baseUrl$approveOrderEndpoint/$id');
    final res = await http.put(urlApprodOrder, headers: _headers);
    print('🔍 [OrderService] ← ${res.statusCode}: ${res.body}'); // 🔍
    return res.statusCode == 200;
  }

  Future<bool> rejectOrder(int id) async {
    print('🔍 [OrderService] put $baseUrl$rejectOrderEndpoint/$id '); // 🔍
    final urlRejectOrder = Uri.parse('$baseUrl$rejectOrderEndpoint/$id');

    final res = await http.put(urlRejectOrder, headers: _headers);
    return res.statusCode == 200;
  }
}
