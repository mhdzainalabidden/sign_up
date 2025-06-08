import 'package:alyarmok_hotel/modules/shared/localization/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:alyarmok_hotel/modules/shared/routes/app_pages.dart';
import 'package:alyarmok_hotel/modules/shared/routes/app_routes.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

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
            supportedLocales: const [Locale('en', ''), Locale('ar', '')],
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              AppLocalization.delegate, // Custom localization delegate
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeListResolutionCallback: (locales, supportedLocales) {
              if (locales != null && locales.isNotEmpty) {
                for (var locale in locales) {
                  if (supportedLocales.contains(locale)) {
                    return locale;
                  }
                }
              }
              return supportedLocales
                  .first; // Default to first supported locale
            },
            title: LocalizationExtension(
              "hotel_management",
            ).tr(context), // Use translation for title
            theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Arial'),
            initialRoute: AppRoutes.LOGIN,
            getPages: AppPages.pages,
          ),
    );
  }
}
