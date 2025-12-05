import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../sign_in/views/sign_in_page.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();

  /// OTP value
  var otp = "".obs;

  /// Timer countdown 20 seconds
  var secondsRemaining = 20.obs;
  Timer? _timer;

  /// Whether user can resend OTP
  var canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  /// Start 20-second countdown
  void startTimer() {
    secondsRemaining.value = 20;
    canResend.value = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  /// Validate OTP
  String? validateOtp() {
    if (otp.value.length != 4) return "Enter the 4-digit code";
    return null;
  }

  /// Verify OTP
  Future<void> verifyOtp() async {
    final error = validateOtp();

    if (error != null) {
      Get.snackbar("Error", "Please fill all the fields", backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    EasyLoading.show(status: "Verifying...");

    try {
      await Future.delayed(const Duration(seconds: 2)); // for API

      EasyLoading.dismiss();

      Get.snackbar("Success", "OTP Verified Successfully");
      await Future.delayed(Duration(milliseconds: 600)); // for not to navigate immediately
      /// Navigate to Reset Password Page
      Get.offAll(() => SignInPage());

    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Error",
        "Something went wrong. Try again.",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  /// Resend OTP
  Future<void> resendOtp() async {
    if (!canResend.value) return;
    EasyLoading.show(status: "Sending new code...");
    await Future.delayed(const Duration(seconds: 2));
    Get.snackbar("Success", "New Code Sent!");
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
