import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_text_styles.dart';

class OtpBox extends StatelessWidget {
  final Function(String)? onChanged;
  const OtpBox({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      keyboardType: TextInputType.number,
      cursorColor: AppColors.primaryColor,
      textStyle: AppTextStyles.header24(context).copyWith(
        color: Colors.black,
      ),
      animationType: AnimationType.fade,

      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(24.r),

        fieldHeight: 55.h,
        fieldWidth: 55.w,

        borderWidth: 1,

        /// Inactive state — NO BORDER
        inactiveColor: Colors.transparent,
        inactiveFillColor: Colors.grey.shade300,

        /// Selected state — Primary border + white fill
        selectedColor: AppColors.primaryColor,
        selectedFillColor: Colors.white,

        /// Active (typed) state — Primary border + white fill
        activeColor: AppColors.primaryColor,
        activeFillColor: Colors.white,
      ),

      enableActiveFill: true,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      onChanged: onChanged,
    );
  }
}
