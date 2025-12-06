import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_text_styles.dart';
import '../../../../../core/constant/image_path.dart';

class SuccessDialog {
  static void show({
    required String subtitle,
    required VoidCallback onContinue,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 100.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 40.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///Image
              Image.asset(ImagePath.successLogo, height: 140.h),
              SizedBox(height: 12.h),

              /// Title
              Text(
                'Success',
                 style: GoogleFonts.plusJakartaSans(
                   color: AppColors.blackColor,
                   fontSize: 18.sp,
                   fontWeight: FontWeight.w600,
                 ),
              ),
              SizedBox(height: 8.h),

              /// Subtitle
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.subTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 15.h),

              /// Continue Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  backgroundColor: AppColors.primaryColor,
                ),
                onPressed: onContinue,
                child: Text(
                  "Continue",
                  style: GoogleFonts.plusJakartaSans(color: AppColors.whiteColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}