// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alyarmok_hotel/modules/shared/routes/app_routes.dart';
import 'package:get_storage/get_storage.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  SidebarState createState() => SidebarState();
}

class SidebarState extends State<Sidebar> {
  bool _isOpen = true;

  void _toggleSidebar() {
    setState(() => _isOpen = !_isOpen);
  }

  @override
  void initState() {
    super.initState();
    // نقرأ اللغة الحالية من GetX
    _isEnglish = Get.locale?.languageCode == 'en';
  }

  // نخزن الحالة المحلية هنا
  late bool _isEnglish;

  /// توابع مساعدة لتبديل اللغة

  // الآن نستخدم المفتاح لتبديل اللغة
  void _onLanguageSwitchChanged(bool value) {
    setState(() {
      _isEnglish = value;
    });
    final newLocale = _isEnglish ? const Locale('en') : const Locale('ar');
    Get.updateLocale(newLocale);
    GetStorage().write('lang', newLocale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    final double width = _isOpen ? 100.w : 40.w;

    return AnimatedContainer(
      clipBehavior: Clip.hardEdge,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 0),
      width: width,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      padding: EdgeInsets.only(
        left: 8.w,
        right: _isOpen ? 16.w : 8.w,
        top: 5.h,
        bottom: 12.h,
      ),
      child: Column(
        crossAxisAlignment:
            _isOpen ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          // زر الطي/
          SizedBox(height: 24.h),
          InkWell(
            onTap: _toggleSidebar,
            child: Icon(
              _isOpen ? Icons.arrow_circle_left_outlined : Icons.menu,
              color: Colors.white,
              size: 12.sp,
            ),
          ),
          // عنوان يظهر فقط عند الفتح
          if (_isOpen)
            Text(
              'Restaurant Supervisor',
              style: TextStyle(
                fontSize: 8.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

          if (_isOpen) ...[
            SizedBox(height: 16.h),
            Divider(color: Colors.white24, thickness: 1),
            SizedBox(height: 8.h),
          ],

          // قائمة العناصر
          _SidebarItem(
            label: 'Orders',
            icon: Icons.list_alt_rounded,
            route: AppRoutes.GET_ORDERS_PAGE,
            isSelected: currentRoute == AppRoutes.GET_ORDERS_PAGE,
            isOpen: _isOpen,
          ),
          _SidebarItem(
            label: 'Orders Archive',
            icon: Icons.archive_rounded,
            route: AppRoutes.GET_ORDERS_ARCHIVE,
            isSelected: currentRoute == AppRoutes.GET_ORDERS_ARCHIVE,
            isOpen: _isOpen,
          ),
          _SidebarItem(
            label: 'Invoices',
            icon: Icons.receipt_long_rounded,
            route: AppRoutes.GET_ALL_INVOICES,
            isSelected: currentRoute == AppRoutes.GET_ALL_INVOICES,
            isOpen: _isOpen,
          ),
          _SidebarItem(
            label: 'Menu Items',
            icon: Icons.restaurant_menu_rounded,
            route: AppRoutes.GET_ALL_MENU_ITEMS,
            isSelected: currentRoute == AppRoutes.GET_ALL_MENU_ITEMS,
            isOpen: _isOpen,
          ),
          // هنا زر تغيير اللغة
          // هنا نضيف المفتاح بدل العنصر السابق
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
            child: Row(
              mainAxisAlignment:
                  _isOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: [
                Icon(Icons.language, color: Colors.white, size: 6.sp),
                if (_isOpen) ...[
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Language',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Switch.adaptive(
                    value: _isEnglish,
                    onChanged: _onLanguageSwitchChanged,
                  ),
                ],
              ],
            ),
          ),

          const Spacer(),

          _SidebarItem(
            label: 'Logout',
            icon: Icons.logout_rounded,
            isSelected: false,
            onTap: () => Get.offAllNamed(AppRoutes.LOGIN),
            isOpen: _isOpen,
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? route;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isOpen;

  const _SidebarItem({
    required this.label,
    required this.icon,
    this.route,
    this.onTap,
    this.isSelected = false,
    this.isOpen = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: InkWell(
        onTap:
            onTap ??
            () {
              if (route != null && Get.currentRoute != route) {
                Get.toNamed(route!);
              }
            },
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color:
                isSelected
                    ? Colors.teal.shade700.withOpacity(0.6)
                    : Colors.blueGrey.shade800.withOpacity(0.3),
          ),
          child: Row(
            mainAxisAlignment:
                isOpen ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 6.sp),
              if (isOpen) ...[
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
