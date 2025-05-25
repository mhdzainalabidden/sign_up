import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../models/invoices_model.dart';
import '../utils/constants.dart';

class InvoiceService {
  final box = GetStorage();
  final String baseUrl = AppConstants.apiBaseUrl;
  final String endpoint = AppConstants.getAllInvoicesEndpoint;

  Map<String, String> get _headers {
    final token = box.read<String>('token') ?? '';
    // '5|ZeAKf2GgyZyDDfJoMTecDYG0uN16469uH5ptURDo';

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<InvoicesModel> fetchAllInvoices() async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      return InvoicesModel.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to load invoices');
    }
  }
}
