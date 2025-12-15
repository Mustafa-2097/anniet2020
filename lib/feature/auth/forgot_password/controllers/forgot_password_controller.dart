import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../otp_page/controllers/otp_controller.dart';
import '../../otp_page/views/otp_page.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();
  final AuthRepository _repository = AuthRepository();
  /// Text Controllers
  final emailController = TextEditingController();

  /// Email Validation
  String? validateEmail(String value) {
    if (value.isEmpty) return "Email is required";
    if (!GetUtils.isEmail(value)) return "Enter a valid email";
    return null;
  }

  /// Logic Submit Email
  Future<void> submit(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    try {
      EasyLoading.show(status: "Sending OTP...");

      await _repository.sendResetOtp(emailController.text.trim());

      EasyLoading.dismiss();
      Get.snackbar("Success", "OTP sent successfully", backgroundColor: Colors.green, colorText: Colors.white);
      /// Navigate to OTP page
      Get.to(() => OtpPage(
        email: emailController.text.trim(),
        type: OtpType.resetPassword,
        onOtpVerified: () {},
      ));

    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  /// Clear controllers on disposing
  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
