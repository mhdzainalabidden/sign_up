import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alyarmok_hotel/modules/shared/routes/app_routes.dart';
import 'controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return Scaffold(
      backgroundColor: const Color(0xFFFDF1E8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: isMobile ? 0.9.sw : 900.w,
                height: isMobile ? null : 650.h,
                padding: EdgeInsets.symmetric(vertical: isMobile ? 24.h : 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10),
                  ],
                ),
                child:
                    isMobile
                        ? Column(
                          children: [_FormSection(controller), _SidePanel()],
                        )
                        : Row(
                          children: [
                            Expanded(flex: 3, child: _FormSection(controller)),
                            Expanded(flex: 2, child: _SidePanel()),
                          ],
                        ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  final RegisterController controller;
  const _FormSection(this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Register',
            style: TextStyle(
              color: const Color.fromARGB(255, 69, 13, 255),
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40.h),

          // Name
          SizedBox(
            width: double.infinity,
            height: 60.h,
            child: TextField(
              onChanged: (v) => controller.name.value = v,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                filled: true,
                fillColor: const Color(0xFFF2F2F2),
                prefixIcon: const Icon(Icons.person_outline),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 14.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),

          // Email
          SizedBox(
            width: double.infinity,
            height: 60.h,
            child: TextField(
              onChanged: (v) => controller.email.value = v,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                filled: true,
                fillColor: const Color(0xFFF2F2F2),
                prefixIcon: const Icon(Icons.email_outlined),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 14.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),

          // Password
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 60.h,
              child: TextField(
                onChanged: (v) => controller.password.value = v,
                obscureText: !controller.showPassword.value,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color(0xFFF2F2F2),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.showPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 14.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),

          // Sign Up Button
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 60.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A4CD7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                onPressed:
                    controller.isLoading.value ? null : controller.register,
                child:
                    controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Link to Login
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account? "),
              TextButton(
                onPressed: () => Get.offNamed(AppRoutes.LOGIN),
                child: const Text(
                  "Log in",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SidePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        // final isMobile = constraints.maxWidth < 600;
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF027AFF),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -100,
                left: -40,
                child: Container(
                  width: 85.w,
                  height: 300.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.pink, Colors.purple],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                right: 30,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.orange],
                    ),
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Hey\nWelcome\nBack',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
