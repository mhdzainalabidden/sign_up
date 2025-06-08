// lib/app/core/constants.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class AppConstants {
  /// Base API URL يتغير تلقائيًا حسب المنصة
  static String get apiBaseUrl {
    if (kIsWeb) {
      // عند التشغيل على الويب
      return 'http://localhost:8000/api/';
    } else {
      // على الموبايل (محاكي أندرويد / iOS simulator / جهاز حقيقي)
      if (Platform.isAndroid) {
        // محاكي أندرويد يستخدم 10.0.2.2 للوصول للـ localhost
        return 'http://10.0.2.2:8000/api/';
      } else if (Platform.isIOS) {
        // iOS simulator يصل للـ localhost عبر 127.0.0.1
        return 'http://127.0.0.1:8000/api/';
      } else {
        // أي منصة أخرى نستخدم العنوان الافتراضي
        return 'http://localhost:8000/api/';
      }
    }
  }

  static const String getAllOrdersEndpoint = 'getAllOrders';
  static const String getOrdersByStatusEndpoint = 'restaurant-orders/status/';
  static const String approveOrderEndpoint = 'approveOrderBYSupervisor';
  static const String rejectOrderEndpoint = 'rejectOrderBYSupervisor';
  static const String getOrdersByDateRangeEndpoint = 'getOrdersByDateRange';

  static const String getAllInvoicesEndpoint = 'getAllInvoices';

  static const String getAllMenuItemsEndpoint = 'getListMenuItems';
  static const String addMenuItemEndpoint = 'AddMenuItem';
  static const String deleteMenuItemEndpoint = 'DeleteMenuItem';

  static const String loginEndpoint = 'login';

  //–– UI: Dimensions
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 32.0;

  //–– UI: Durations
  static const Duration animationDuration = Duration(milliseconds: 300);

  //–– Assets
  static const String logoPng = 'assets/images/logo.png';
  static const String loginLottie = 'assets/lottie/login.json';

  //–– Strings
  static const String appName = 'رعاية بلس';
  static const String loginTitle = 'Welcome Back';
  static const String loginButton = 'Log In';
  static const String errorNetwork = 'Please check your internet connection';

  //–– Validation
  static const int passwordMinLength = 6;

  //–– Colors
  static const Color primaryColor = Color(0xFF0066CC);
  static const Color accentColor = Color(0xFF00CC99);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  //–– TextStyles (optional—you can also keep in theme)
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );
}
