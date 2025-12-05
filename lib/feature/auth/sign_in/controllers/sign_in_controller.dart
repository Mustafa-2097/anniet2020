import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

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
    if (emailController.text == "test@example.com" && passwordController.text == "123456") {
      EasyLoading.dismiss();
      Get.snackbar("Success", "Logged in successfully");
      // Navigate to dashboard
      // Get.offAll(() => HomePage());
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
