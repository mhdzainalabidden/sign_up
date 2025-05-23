// lib/routes/app_pages.dart

import 'package:get/get.dart';
import 'package:sign_up/bindings/login_binding.dart';
import 'package:sign_up/bindings/orders_archive_binding.dart';
import 'package:sign_up/bindings/orders_binding.dart';
import 'package:sign_up/bindings/register_binding.dart';
import 'package:sign_up/views/login_screen.dart';
import 'package:sign_up/views/restaurantSupervisor/orders_archive_page.dart';
import 'package:sign_up/views/restaurantSupervisor/orders_page.dart';
import 'package:sign_up/views/restaurantSupervisor/restaurant_menu_dashboard.dart';
import '../views/admin_dashboard_page.dart';
import '../views/receptionist_dashboard_page.dart';
import '../views/restaurantSupervisor/kitchen_dashboard_page.dart';
import 'app_routes.dart';
import '../views/register_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    // GetPage(name: AppRoutes.LOGIN, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.ADMIN_DASH, page: () => const AdminDashboardPage()),
    GetPage(
      name: AppRoutes.RECEPTIONIST_DASH,
      page: () => const ReceptionistDashboardPage(),
    ),
    GetPage(
      name: AppRoutes.GET_ORDERS_PAGE,
      page: () => const OrdersPage(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: AppRoutes.RESTURANT_SUPERVISER_DASH,
      page: () => const RestaurantSupervisorDashboard(),
    ),
    GetPage(
      name: AppRoutes.Restaurant_Menu_Dashboard,
      page: () => const RestaurantMenuDashboard(),
    ),
    GetPage(
      name: AppRoutes.GET_ORDERS_ARCHIVE,
      page: () => OrdersArchivePage(),
      binding: OrderArchiveBinding(),
    ),
  ];
}
