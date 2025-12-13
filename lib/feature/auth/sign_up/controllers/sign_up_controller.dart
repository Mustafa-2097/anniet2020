import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../otp_page/views/otp_page.dart';
import '../../sign_in/views/sign_in_page.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  /// Repository
  final AuthRepository _repository = AuthRepository();

  /// Text Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  /// Observables
  final obscurePassword = true.obs;
  final isTermsAccepted = false.obs;

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

  /// Password Validation (MATCH BACKEND)
  String? validatePassword(String value) {
    if (value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  /// Sign Up Logic
  Future<void> signUp(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    if (!isTermsAccepted.value) {
      Get.snackbar("Terms Required", "Please agree to the Terms & Conditions", backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    try {
      EasyLoading.show(status: 'Creating Account...');

      await _repository.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      EasyLoading.dismiss();

      /// Navigate to OTP page
      Get.to(() => OtpPage(
        onOtpVerified: () {
          Get.offAll(() => SignInPage());
        },
      ));
    } catch (e) {
      EasyLoading.dismiss();

      Get.snackbar("Registration Failed", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  /// Dispose
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
