// lib/app/core/constants.dart

import 'package:flutter/material.dart';

class AppConstants {
  //–– API
  static const String apiBaseUrl = 'https://api.example.com/';
  static const String loginEndpoint = 'auth/login';
  static const String userProfileEndpoint = 'user/profile';

  //–– UI: Dimensions
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 32.0;

  //–– UI: Durations
  static const Duration animationDuration = Duration(milliseconds: 300);

  //–– Assets
  static const String logoPng = 'assets/images/logo.png';
  static const String loginLottie = 'assets/lottie/login.json';

  //–– Strings
  static const String appName = 'رعاية بلس';
  static const String loginTitle = 'Welcome Back';
  static const String loginButton = 'Log In';
  static const String errorNetwork = 'Please check your internet connection';

  //–– Validation
  static const int passwordMinLength = 6;

  //–– Colors
  static const Color primaryColor = Color(0xFF0066CC);
  static const Color accentColor = Color(0xFF00CC99);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  //–– TextStyles (optional—you can also keep in theme)
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );
}
