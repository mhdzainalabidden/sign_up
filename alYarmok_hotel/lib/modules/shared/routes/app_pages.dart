// lib/routes/app_pages.dart

import 'package:alyarmok_hotel/modules/auth/login_screen.dart';
import 'package:alyarmok_hotel/modules/auth/register_screen.dart';
import 'package:get/get.dart';
import 'package:alyarmok_hotel/modules/supervisor/binding/invoices_binding.dart';
import 'package:alyarmok_hotel/modules/auth/binding/login_binding.dart';
import 'package:alyarmok_hotel/modules/supervisor/binding/menu_binding.dart';
import 'package:alyarmok_hotel/modules/supervisor/binding/orders_archive_binding.dart';
import 'package:alyarmok_hotel/modules/supervisor/binding/orders_binding.dart';
import 'package:alyarmok_hotel/modules/auth/binding/register_binding.dart';
import 'package:alyarmok_hotel/modules/supervisor/view/invoice_page.dart';
import 'package:alyarmok_hotel/modules/supervisor/view/menu_page.dart';
import 'package:alyarmok_hotel/modules/supervisor/view/orders_archive_page.dart';
import 'package:alyarmok_hotel/modules/supervisor/view/orders_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    //authentication routes
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

    //supervisor routes
    GetPage(
      name: AppRoutes.GET_ORDERS_PAGE,
      page: () => const OrdersPage(),
      binding: OrdersBinding(),
    ),

    GetPage(
      name: AppRoutes.GET_ORDERS_ARCHIVE,
      page: () => OrdersArchivePage(),
      binding: OrderArchiveBinding(),
    ),
    GetPage(
      name: AppRoutes.GET_ALL_INVOICES,
      page: () => InvoicesPage(),
      binding: InvoicesBinding(),
    ),
    GetPage(
      name: AppRoutes.GET_ALL_MENU_ITEMS,
      page: () => MenuPage(),
      binding: MenuBinding(),
    ),

    //admin routes
  ];
}
