import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/auth_controller.dart';

class SignupView extends GetView<AuthController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (_, child) {
        return Scaffold(
          backgroundColor: Color(0xFFFFF8F0), // light beige background
          body: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 800.w),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // If width is narrow, stack vertically
                    bool isMobile = constraints.maxWidth < 600.w;
                    return isMobile
                        ? _buildMobileLayout()
                        : _buildDesktopLayout();
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Desktop layout: side-by-side panels
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left White Panel (Form)
        Expanded(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(32.w),
            child: _buildForm(),
          ),
        ),
        // Right Blue Panel (Decoration)
        Expanded(
          child: Container(
            color: Color(0xFF007AFF), // Bright blue panel
            child: Stack(
              children: [
                // Big gradient circle (partially visible)
                Positioned(
                  top: -100.h,
                  right: -150.w,
                  child: Container(
                    width: 300.w,
                    height: 300.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF634AFF), Color(0xFFFF8C88)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                // Small gradient circle at bottom right
                Positioned(
                  bottom: 50.h,
                  right: 50.w,
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF634AFF), Color(0xFFFF8C88)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                // Text on blue panel
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Text(
                      'Hey\nRegister\nYourself',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Mobile layout: vertical stack (blue panel on top)
  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Blue panel as top banner
        Container(
          color: Color(0xFF007AFF),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Text(
              'Hey Register Yourself',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        // White form panel
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(24.w),
          child: _buildForm(),
        ),
      ],
    );
  }

  // The signup form with Name, Email, Password fields
  Widget _buildForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Signup',
            style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24.h),
          // Name (optional)
          Text('Name', style: TextStyle(fontSize: 14.sp)),
          TextFormField(
            controller: controller.nameController,
            decoration: InputDecoration(
              hintText: 'Enter your full name',
              prefixIcon: Icon(Icons.person_outline),
            ),
            // Name is optional, so no validator
          ),
          SizedBox(height: 16.h),
          // Email
          Text('Email', style: TextStyle(fontSize: 14.sp)),
          TextFormField(
            controller: controller.emailController,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email is required';
              // Simple email regex
              if (!GetUtils.isEmail(value.trim())) return 'Enter a valid email';
              return null;
            },
          ),
          SizedBox(height: 16.h),
          // Password
          Text('Password', style: TextStyle(fontSize: 14.sp)),
          Obx(
            () => TextFormField(
              controller: controller.passwordController,
              obscureText: controller.obscurePassword.value,
              decoration: InputDecoration(
                hintText: 'Create password',
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 24.h),
          // Sign Up button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: controller.login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF007AFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.w),
                ),
              ),
              child: Text('Sign up', style: TextStyle(fontSize: 18.sp)),
            ),
          ),
          SizedBox(height: 16.h),
          // Already have account?
          Center(
            child: Wrap(
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(fontSize: 14.sp),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to login page if exists
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(fontSize: 14.sp, color: Color(0xFFFF8C00)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
