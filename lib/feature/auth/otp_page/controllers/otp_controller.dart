import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../sign_up/views/widgets/success_dialog.dart';

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
  Future<void> verifyOtp(VoidCallback onVerified) async {
    final error = validateOtp();

    if (error != null) {
      Get.snackbar("Error", "Please fill all the fields", backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    EasyLoading.show(status: "Verifying...");

    try {
      await Future.delayed(const Duration(seconds: 2)); // for API

      EasyLoading.dismiss();

      /// Show Success Dialog instead of snackbar
      SuccessDialog.show(
        subtitle: "OTP Verified Successfully!",
        onContinue: () {
          Get.back();
          onVerified(); // execute the callback
        },
      );

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
    await Future.delayed(const Duration(seconds: 2)); // Mock Api
    EasyLoading.dismiss();
    Get.snackbar("Check Your Email", "New Code Sent!", backgroundColor: Colors.green);
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
