import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../otp_page/views/otp_page.dart';
import '../../sign_in/views/sign_in_page.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();
  /// Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Observables
  var obscurePassword = true.obs;

  /// Name Validation
  String? validateName(String value) {
    if (value.isEmpty) return "Full Name is required";
    if (value.length < 3) return "Name must be at least 3 characters";
    return null;
  }

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

  /// Sign Up Logic
  Future<void> signUp(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    EasyLoading.show(status: 'Creating Account...');

    await Future.delayed(const Duration(seconds: 2)); // mock API call

    // Dismiss loader BEFORE branching (recommended)
    EasyLoading.dismiss();

    // Simulated success example
    if (emailController.text == "new@gmail.com") {
      /// Navigate to OTP Page
      Get.to(() => OtpPage(
        onOtpVerified: () {
          // Navigate to Sign-In page after OTP
          Get.offAll(() => SignInPage());
        },
      ));
    } else {
      Get.snackbar("Error", "Email already exists or invalid details", backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  /// Clear controllers on disposing
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
