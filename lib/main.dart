import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'core/constant/app_colors.dart';
import 'feature/user_flow/profile/controllers/profile_controller.dart';
import 'my_app.dart';
import 'package:get/get.dart';

void main() {
  /// Register services globally so they can be found anywhere
  configEasyLoading();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MyApp(),
    ),
  );
}

void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = AppColors.blackColor
    ..textColor = AppColors.whiteColor
    ..indicatorColor = AppColors.whiteColor
    ..maskColor = AppColors.primaryColor
    ..indicatorSize = 45
    ..radius = 10
    ..userInteractions = false
    ..dismissOnTap = false;
}
