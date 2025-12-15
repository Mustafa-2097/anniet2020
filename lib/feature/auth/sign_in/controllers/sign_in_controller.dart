import 'package:anniet2020/feature/user_flow/dashboard/customer_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../core/constant/app_colors.dart';
import '../../data/repositories/auth_repository.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  /// Repository
  final AuthRepository _repository = AuthRepository();

  /// Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Observables
  final rememberMe = false.obs;
  final obscurePassword = true.obs;

  /// Email Validation
  String? validateEmail(String value) {
    if (value.isEmpty) return "Email is required";
    if (!GetUtils.isEmail(value)) return "Enter a valid email";
    return null;
  }

  /// Password Validation (MATCH BACKEND)
  String? validatePassword(String value) {
    if (value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  /// Sign In Logic
  Future<void> signIn(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    try {
      EasyLoading.show(status: 'Signing In...');

      await _repository.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      EasyLoading.dismiss();
      Get.snackbar("Success", "Logged in successfully", backgroundColor: AppColors.primaryColor, colorText: Colors.white);
      /// Navigate to dashboard
      Get.offAll(() => CustomerDashboard());

    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Login Failed", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  /// Dispose controllers
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
