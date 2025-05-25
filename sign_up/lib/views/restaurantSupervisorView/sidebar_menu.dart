import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_up/routes/app_routes.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;

    return Container(
      width: 100.w,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      padding: EdgeInsets.only(left: 8.w, right: 16.w, top: 45.h, bottom: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Restaurant Supervisor',
            style: TextStyle(
              fontSize: 7.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.white24, thickness: 1),
          SizedBox(height: 8.h),

          _SidebarItem(
            label: 'Orders',
            icon: Icons.list_alt_rounded,
            route: AppRoutes.GET_ORDERS_PAGE,
            isSelected: currentRoute == AppRoutes.GET_ORDERS_PAGE,
          ),
          _SidebarItem(
            label: 'Orders Archive',
            icon: Icons.archive_rounded,
            route: AppRoutes.GET_ORDERS_ARCHIVE,
            isSelected: currentRoute == AppRoutes.GET_ORDERS_ARCHIVE,
          ),
          _SidebarItem(
            label: 'invoices',
            icon: Icons.list_alt_rounded,
            route: AppRoutes.GET_ALL_INVOICES,
            isSelected: currentRoute == AppRoutes.GET_ALL_INVOICES,
          ),
          _SidebarItem(
            label: 'Menu Items',
            icon: Icons.restaurant_menu_rounded,
            route: AppRoutes.GET_ALL_MENU_ITEMS,
            isSelected: currentRoute == AppRoutes.GET_ALL_MENU_ITEMS,
          ),

          const Spacer(),

          _SidebarItem(
            label: 'Logout',
            icon: Icons.logout_rounded,
            isSelected: false,
            onTap: () => Get.offAllNamed(AppRoutes.LOGIN),
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

  const _SidebarItem({
    required this.label,
    required this.icon,
    this.route,
    this.onTap,
    this.isSelected = false,
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
                    ? Colors.teal.shade700.withValues(alpha: 0.6)
                    : Colors.blueGrey.shade800.withValues(alpha: 0.3),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 6.sp),
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
          ),
        ),
      ),
    );
  }
}
