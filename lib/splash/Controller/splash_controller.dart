import 'package:anniet2020/feature/auth/sign_in/views/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/offline_storage/shared_pref.dart';
import '../../feature/admin_dashboard/admin_dashboard.dart';
import '../../feature/user_flow/dashboard/customer_dashboard.dart';
import '../../onboarding/view/onboarding_screen.dart';

class SplashController extends GetxController {
  static SplashController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    _startSplash();
  }

  Future<void> _startSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    try {
      final onboardingDone = await SharedPreferencesHelper.isOnboardingCompleted();

      final rememberMe = await SharedPreferencesHelper.isRememberMe();
      final token = await SharedPreferencesHelper.getToken();
      final role = await SharedPreferencesHelper.getRole();

      debugPrint('Onboarding Completed: $onboardingDone');
      debugPrint('Token: $token');
      debugPrint("Role: $role");

      /// Run navigation after frame renders
      Future.microtask(() {
        if (!onboardingDone) {
          // First time so Show Onboarding
          Get.offAll(() => OnboardingScreen());
        } else if (!rememberMe || token == null || token.isEmpty) {
          // Onboarding done but no token so go to Login
          Get.offAll(() => SignInPage());
        } else if (role == 'ADMIN') {
            Get.offAll(() => AdminDashboard());
        } else if (role == 'USER') {
          Get.offAll(() => CustomerDashboard());
        } else{
          Get.offAll(()=> SignInPage());
        }

      });

    } catch (e) {
      debugPrint('Error in splash logic: $e');

      /// Fallback navigation
      Future.microtask(() {
        Get.offAll(() => SignInPage());
      });

    }
  }
}




