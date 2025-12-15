import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../forgot_password/views/pages/create_new_password.dart';
import '../../sign_up/views/widgets/success_dialog.dart';

enum OtpType { signup, resetPassword }

class OtpController extends GetxController {
  final String email;
  final OtpType type;
  OtpController({required this.email, required this.type});
  final AuthRepository _repository = AuthRepository();
  static OtpController get instance => Get.find();

  /// OTP value
  var otp = "".obs;

  /// Timer countdown
  var secondsRemaining = 60.obs;
  Timer? _timer;

  /// Whether user can resend OTP
  var canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  /// Start countdown
  void startTimer() {
    secondsRemaining.value = 60;
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
  Future<void> verifyOtp({required VoidCallback onOtpVerified}) async {
    final error = validateOtp();
    if (error != null) {
      Get.snackbar("Error", error, backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    EasyLoading.show(status: "Verifying...");

    try {
      if (type == OtpType.signup) {
        /// Verify OTP via repository
        await _repository.verifySignUpOtp(email: email, otp: otp.value);
        EasyLoading.dismiss();

        /// Show Success Dialog
        SuccessDialog.show(
          subtitle: "OTP Verified Successfully!",
          onContinue: () {
            Get.back();
            onOtpVerified(); // Usually navigate to SignInPage
          },
        );
      } else {
        /// Reset password flow
        final resetToken = await _repository.verifyResetOtp(email: email, otp: otp.value);
        EasyLoading.dismiss();

        SuccessDialog.show(
          subtitle: "OTP Verified Successfully!",
          onContinue: () {
            Get.back();
            Get.offAll(() => CreateNewPassword(resetToken: resetToken));
          },
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  /// Resend OTP for resest password
  Future<void> resendOtp() async {
    if (!canResend.value || type != OtpType.resetPassword) return;
    EasyLoading.show(status: "Sending new code...");

    try {
      await _repository.sendResetOtp(email);

      EasyLoading.dismiss();
      startTimer();
      Get.snackbar("Check Your Email", "New Code Sent!", backgroundColor: Colors.green);
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
