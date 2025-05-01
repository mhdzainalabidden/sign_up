import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

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
  final LoginController controller;
  const _FormSection(this.controller);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: TextStyle(
                color: const Color(0xFF450DFF),
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40.h),
            // Email
            TextFormField(
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
              onChanged: (val) => controller.email.value = val,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Email is required';
                }
                if (!GetUtils.isEmail(val.trim())) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            // Password
            Obx(
              () => TextFormField(
                obscureText: controller.isPasswordHidden.value,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color(0xFFF2F2F2),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: controller.togglePassword,
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
                onChanged: (val) => controller.password.value = val,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Forgot password flow
                },
                child: const Text(
                  'Forget password',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A4CD7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onPressed:
                      controller.isLoading.value ? null : controller.login,
                  child:
                      controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            'Log in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                TextButton(
                  onPressed: () {
                    // TODO: Navigate to sign up
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SidePanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Container(
          width: isMobile ? double.infinity : 0.w,
          height: isMobile ? double.infinity : 0.h,
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
                left: -80,
                child: Container(
                  width: 300,
                  height: 300,
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
                  width: 70,
                  height: 70,
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
                      fontSize: 26,
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
