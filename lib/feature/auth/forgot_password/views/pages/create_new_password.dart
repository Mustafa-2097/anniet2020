import 'package:anniet2020/core/constant/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/widgets/primary_button.dart';
import '../../controllers/create_new_password_controller.dart';

class CreateNewPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(CreateNewPasswordController());

  CreateNewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    //final sh = MediaQuery.of(context).size.height;
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.064),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Subtitle
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Create a New Password",
                  style: AppTextStyles.header24(context),
                ),
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Enter your new password",
                  style: AppTextStyles.body3(context),
                ),
              ),

              SizedBox(height: 25.h),

              ///
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// PASSWORD FIELD
                    Text("New Password", style: AppTextStyles.body3(context).copyWith(color: AppColors.subTextColor)),
                    SizedBox(height: 6.h),
                    Obx(() => TextFormField(
                      controller: controller.passwordController,
                      obscureText: controller.obscurePassword.value,
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        hintStyle: AppTextStyles.body3(context),
                        filled: true,
                        fillColor: Color(0xFFF6F6F6),
                        suffixIcon: IconButton(
                          icon: Icon(controller.obscurePassword.value ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => controller.obscurePassword.value = !controller.obscurePassword.value,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (v) => controller.validatePassword(v!.trim()),
                    )),

                    SizedBox(height: 20.h),

                    /// CONFIRM PASSWORD FIELD
                    Text("Confirm Password", style: AppTextStyles.body3(context).copyWith(color: AppColors.subTextColor)),
                    SizedBox(height: 6.h),
                    Obx(() => TextFormField(
                      controller: controller.confirmPasswordController,
                      obscureText: controller.obscureConfirmPassword.value,
                      decoration: InputDecoration(
                        hintText: "Confirm your password",
                        hintStyle: AppTextStyles.body3(context),
                        filled: true,
                        fillColor: Color(0xFFF6F6F6),
                        suffixIcon: IconButton(
                          icon: Icon(controller.obscureConfirmPassword.value ? Icons.visibility_off : Icons.visibility),
                          onPressed: () => controller.obscureConfirmPassword.value = !controller.obscureConfirmPassword.value,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (v) => controller.validateConfirmPassword(v!.trim()),
                    )),

                    SizedBox(height: 30.h),

                    /// Next BUTTON
                    PrimaryButton(
                      onPressed: () => controller.submitNewPassword(_formKey),
                      text: "Next",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
