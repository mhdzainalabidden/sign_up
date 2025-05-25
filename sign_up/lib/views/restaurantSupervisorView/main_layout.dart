import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_up/views/restaurantSupervisorView/sidebar_menu.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(), // ثابت في جميع الصفحات
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: child, // يتغير حسب الصفحة
            ),
          ),
        ],
      ),
    );
  }
}
