import 'package:anniet2020/core/constant/app_text_styles.dart';
import 'package:anniet2020/feature/auth/forgot_password/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/primary_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ForgotPasswordController());
  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    //final sh = MediaQuery.of(context).size.height;
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.064),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title + Subtitle
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Forgot Password",
                  style: AppTextStyles.header24(context),
                ),
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Recove your account password",
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
                    /// Email
                    Text("Email", style: AppTextStyles.body3(context).copyWith(color: AppColors.subTextColor)),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: AppTextStyles.body3(context),
                        filled: true,
                        fillColor: Color(0xFFF6F6F6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (v) => controller.validateEmail(v!.trim()),
                    ),

                    SizedBox(height: 30.h),

                    /// Next BUTTON
                    PrimaryButton(
                      onPressed: () => controller.submit(_formKey),
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
