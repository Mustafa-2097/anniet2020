import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../otp_page/views/otp_page.dart';
import '../views/pages/create_new_password.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();
  /// Text Controllers
  final emailController = TextEditingController();

  /// Email Validation
  String? validateEmail(String value) {
    if (value.isEmpty) return "Email is required";
    if (!GetUtils.isEmail(value)) return "Enter a valid email";
    return null;
  }

  /// Logic
  Future<void> submit(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    EasyLoading.show(status: "Sending OTP...");

    await Future.delayed(const Duration(seconds: 2)); // mock API call

    EasyLoading.dismiss();

    // Success condition
    if (emailController.text.trim() == "test@gmail.com") {
      Get.snackbar("Success", "OTP sent successfully to your email", backgroundColor: Colors.green);
      Get.to(() => OtpPage(
        onOtpVerified: () {
          // Navigate to Create New Password page after OTP
          Get.offAll(() => CreateNewPassword());
        },
      ));
    } else {
      Get.snackbar("Error", "Email not found. Please try again.", backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  /// Clear controllers on disposing
  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
