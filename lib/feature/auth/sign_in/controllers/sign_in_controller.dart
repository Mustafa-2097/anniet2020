import 'package:anniet2020/feature/user_flow/dashboard/customer_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_colors.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();
  /// Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Observables
  var rememberMe = false.obs;
  var obscurePassword = true.obs;

  /// Email Validation
  String? validateEmail(String value) {
    if (value.isEmpty) return "Email is required";
    if (!GetUtils.isEmail(value)) return "Enter a valid email";
    return null;
  }

  /// Password Validation
  String? validatePassword(String value) {
    if (value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  /// Sign In Logic
  Future<void> signIn(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    EasyLoading.show(status: 'Signing In...');

    await Future.delayed(const Duration(seconds: 2)); // mock API call

    // Example login success condition
    if (emailController.text == "test@gmail.com" && passwordController.text == "123456") {
      EasyLoading.dismiss();
      Get.snackbar("Success", "Logged in successfully", backgroundColor: AppColors.primaryColor);
      // Navigate to dashboard
      Get.offAll(() => CustomerDashboard());
    } else {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Invalid email or password", backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  /// Clear controllers on disposing
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
