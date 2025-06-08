import 'dart:convert';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:alyarmok_hotel/modules/supervisor/models/menu_add_image_model.dart';
import '../models/menu_model.dart';
import '../../shared/utils/constants.dart';

class MenuService {
  final box = GetStorage();
  final String baseUrl = AppConstants.apiBaseUrl;
  final String menuList = AppConstants.getAllMenuItemsEndpoint;
  final String addEndpoint = AppConstants.addMenuItemEndpoint;
  final String deleteEndpoint = AppConstants.deleteMenuItemEndpoint;

  Map<String, String> get _headers {
    final token = box.read<String>('token') ?? '';
    // '5|ZeAKf2GgyZyDDfJoMTecDYG0uN16469uH5ptURDo';

    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<MenuModel>> fetchMenuItems() async {
    final uri = Uri.parse('$baseUrl$menuList');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      final List jsonList = json.decode(res.body);
      return jsonList.map((e) => MenuModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load menu items');
    }
  }

  // Future<bool> addMenuItem(MenuAddImageModel item) async {
  //   try {
  //     if (item.photo.bytes == null || item.photo.name.isEmpty) {
  //       Get.snackbar('error', 'photo field is required');
  //       return false;
  //     }
  //     if (item.enName.trim().isEmpty ||
  //         item.arName.trim().isEmpty ||
  //         item.enDescription.trim().isEmpty ||
  //         item.arDescription.trim().isEmpty ||
  //         item.type.trim().isEmpty ||
  //         item.price.trim().isEmpty) {
  //       Get.snackbar('error', 'all fields are required');
  //       return false;
  //     }
  //     final uri = Uri.parse('$baseUrl$addEndpoint');
  //     final request =
  //         http.MultipartRequest('POST', uri)
  //           ..headers.addAll(_headers)
  //           ..fields.addAll(
  //             item.toJson().map(
  //               (key, value) => MapEntry(key, value.toString()),
  //             ),
  //           )
  //           // هنا بنضيف ملف الصورة
  //           ..files.add(
  //             http.MultipartFile.fromBytes(
  //               'photo', // هذا اسم الحقل اللي السيرفر متوقعه
  //               item.photo.bytes!, // بيانات الصورة
  //               filename: item.photo.name, // اسم الملف
  //               contentType: MediaType('image', item.photo.extension ?? 'jpeg'),
  //             ),
  //           );

  //     // إرسال الطلب
  //     final response = await request.send();
  //     final responseBody = await response.stream.bytesToString();

  //     if (response.statusCode == 200) {
  //       final decoded = jsonDecode(responseBody);
  //       return decoded['url'];
  //     }
  //     return response.statusCode == 200;
  //   } catch (e) {
  //     debugPrint('Upload exception: $e');
  //     return false;
  //   }
  // }
  Future<bool> addMenuItem(MenuAddImageModel item) async {
    try {
      final uri = Uri.parse('$baseUrl$addEndpoint');
      final request =
          http.MultipartRequest('POST', uri)
            ..headers.addAll(_headers)
            ..fields.addAll(
              item.toJson().map((k, v) => MapEntry(k, v.toString())),
            )
            ..files.add(
              http.MultipartFile.fromBytes(
                'photo',
                item.photo.bytes!,
                filename: item.photo.name,
                contentType: MediaType('image', item.photo.extension ?? 'jpeg'),
              ),
            );

      final response = await request.send();
      // final body = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return true;
      }
      // debugPrint('Upload failed (${response.statusCode}): $body');
      // return false;
      return false;
    } catch (e) {
      debugPrint('Upload exception: $e');
      return false;
    }
  }

  Future<bool> deleteMenuItem(int id) async {
    final uri = Uri.parse('$baseUrl$deleteEndpoint/$id');
    final res = await http.delete(uri, headers: _headers);
    return res.statusCode == 200;
  }
}
