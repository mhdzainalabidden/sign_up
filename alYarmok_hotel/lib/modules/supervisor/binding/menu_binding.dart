import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:alyarmok_hotel/modules/supervisor/services/menu_service.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuService>(() => MenuService());
    Get.lazyPut<MenuController>(() => MenuController());
  }
}
