import 'package:anniet2020/feature/auth/otp_page/views/widgets/otp_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_text_styles.dart';
import '../../../../core/constant/widgets/primary_button.dart';
import '../controllers/otp_controller.dart';

class OtpPage extends StatelessWidget {
  final String email;
  final OtpType type;
  final VoidCallback onOtpVerified;

  const OtpPage({super.key, required this.email, required this.type, required this.onOtpVerified});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController(email: email, type: type));
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.r),
          child: const BackButton(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.064),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Text("Enter OTP", style: AppTextStyles.header24(context)),
              SizedBox(height: 8.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "We’ve just sent you 4 digit code via your email  ",
                  style: AppTextStyles.body3_400(context).copyWith(color: AppColors.subTextColor),
                  children: [
                    TextSpan(
                      text: email,
                      style: AppTextStyles.body3_400(context).copyWith(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),

              OtpBox(onChanged: (value) => controller.otp.value = value),
              SizedBox(height: 20.h),

              PrimaryButton(
                text: "Verify",
                onPressed: () => controller.verifyOtp(onOtpVerified: onOtpVerified),
              ),
              SizedBox(height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive code?",
                    style: GoogleFonts.plusJakartaSans(color: AppColors.boxTextColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 6.w),
                  Obx(() => GestureDetector(
                    onTap: controller.canResend.value ? controller.resendOtp : null,
                    child: Text(
                      controller.canResend.value
                          ? "Resend Code"
                          : "00:${controller.secondsRemaining.value.toString().padLeft(2, '0')}",
                      style: GoogleFonts.plusJakartaSans(
                        color: controller.canResend.value ? AppColors.primaryColor : AppColors.boxTextColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
