import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../sign_in/views/sign_in_page.dart';
import '../../sign_up/views/widgets/success_dialog.dart';

class CreateNewPasswordController extends GetxController {
  static CreateNewPasswordController get instance => Get.find();

  /// Text Controllers
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Observables
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  /// Password Validation
  String? validatePassword(String value) {
    if (value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }

  /// Confirm Password Validation
  String? validateConfirmPassword(String value) {
    if (value.isEmpty) return "Confirm password is required";
    if (value != passwordController.text) return "Passwords do not match";
    return null;
  }

  /// Submit New Password
  Future<void> submitNewPassword(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) return;

    EasyLoading.show(status: "Updating New Password...");

    try {
      await Future.delayed(const Duration(seconds: 2)); // mock API call

      EasyLoading.dismiss();

      // Show Success Dialog
      SuccessDialog.show(
        subtitle: "Your password is successfully created!",
        onContinue: () {
          Get.back(); // close dialog
          Get.offAll(() => SignInPage()); // Navigate to Sign-In page
        },
      );
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "Something went wrong. Please try again.", backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
