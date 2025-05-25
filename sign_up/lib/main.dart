import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sign_up/routes/app_pages.dart';
import 'package:sign_up/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize persistent storage&#8203;:contentReference[oaicite:13]{index=13}
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // Adjust for your design resolution
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (_, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hotel Management',
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Arial'),
            initialRoute: AppRoutes.LOGIN,
            getPages: AppPages.pages,
          ),
    );
  }
}
