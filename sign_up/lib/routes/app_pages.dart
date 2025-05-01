// lib/routes/app_pages.dart

import 'package:get/get.dart';
import 'package:sign_up/views/login.dart';
import '../views/admin_dashboard_page.dart';
import '../views/receptionist_dashboard_page.dart';
import '../views/kitchen_dashboard_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.LOGIN, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.ADMIN_DASH, page: () => const AdminDashboardPage()),
    GetPage(
      name: AppRoutes.RECEPTIONIST,
      page: () => const ReceptionistDashboardPage(),
    ),
    GetPage(name: AppRoutes.KITCHEN, page: () => const KitchenDashboardPage()),
  ];
}
