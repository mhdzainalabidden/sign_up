import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'bindings/auth_binding.dart';
import 'views/signup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // Initialize persistent storage&#8203;:contentReference[oaicite:13]{index=13}
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Signup App',
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      home: SignupView(),
    );
  }
}
