import 'package:anniet2020/feature/auth/otp_page/views/widgets/otp_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_text_styles.dart';
import '../../../../core/constant/widgets/primary_button.dart';
import '../controllers/otp_controller.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    // final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.textColor,
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.064, vertical: 10.h),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.blackColor, size: 24.r),
            onPressed: () => Get.back(),
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.064),
          child: Column(
            children: [
              /// Title + Subtitle
              SizedBox(height: 8.h),
              Text(
                "Enter OTP",
                style: AppTextStyles.header24(context),
              ),
              SizedBox(height: 8.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "We’ve just sent you 4 digit code via your email  ",
                  style: AppTextStyles.body3_400(context).copyWith(color: AppColors.subTextColor),
                  children: [
                    TextSpan(
                      text: "example@gmail.com",
                      style: AppTextStyles.body3_400(context).copyWith(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              /// OTP Code Input
              OtpBox(onChanged: (value) => controller.otp.value = value),

              SizedBox(height: 20.h),

              /// Verify Button
              PrimaryButton(
                text: "Verify",
                onPressed: controller.verifyOtp,
              ),
              SizedBox(height: 24.h),

              /// Resend Code again Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => GestureDetector(
                    onTap: controller.canResend.value ? controller.resendOtp : null,
                    child: Text(
                      "Didn't receive code?",
                      style: TextStyle(
                        color: controller.canResend.value
                            ? AppColors.textColor
                            : AppColors.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        decoration: controller.canResend.value
                            ? TextDecoration.underline
                            : null,
                        decorationColor: AppColors.textColor,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                  ),
                  SizedBox(width: 6.w),
                  Obx(() => Text(
                    controller.canResend.value
                        ? "Resend Code"
                        : "00:${controller.secondsRemaining.value.toString().padLeft(2, '0')}",
                    style: AppTextStyles.body3(context),
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


