import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../views/widgets/success_dialog.dart';

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

    // Simulated success example
    if (emailController.text == "new@example.com") {
      EasyLoading.dismiss();

      SuccessDialog.show(
        subtitle: "Your account has been successfully created!",
        onContinue: () {
          Get.back();
          // Navigate to sign-in page
          // Get.offAll(() => SignInPage());
        }
      );

    } else {
      EasyLoading.dismiss();
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
