import 'package:anniet2020/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/constant/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        /// Override system text scaling globally
        final fixedMediaQuery = MediaQuery.of(context).copyWith(
          textScaler: const TextScaler.linear(1.0),
        );
        return MediaQuery(
          data: fixedMediaQuery,
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            theme: ThemeData.light().copyWith(
              primaryColor: AppColors.primaryColor,
              scaffoldBackgroundColor: AppColors.primaryColor,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: AppColors.textColor),
              ),
              iconTheme: const IconThemeData(
                color: AppColors.textColor,
              ),
            ),
            home: SplashScreen(),
          ),
        );
      },
    );

  }
}
