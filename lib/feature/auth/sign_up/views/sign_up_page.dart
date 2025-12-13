import 'package:anniet2020/core/constant/app_text_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/primary_button.dart';
import '../../../user_flow/profile/views/pages/privacy_page.dart';
import '../controllers/sign_up_controller.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());

  SignUpPage({super.key});

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
                  "Create Account",
                  style: AppTextStyles.header24(context),
                ),
              ),
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Access your account and continue learning.",
                  style: AppTextStyles.body3_400(context),
                ),
              ),

              SizedBox(height: 25.h),

              ///
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name
                    Text("Full Name", style: AppTextStyles.body3(context).copyWith(color: AppColors.subTextColor)),
                    SizedBox(height: 6.h),
                    TextFormField(
                      controller: controller.nameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        hintStyle: AppTextStyles.body3(context),
                        filled: true,
                        fillColor: Color(0xFFF6F6F6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (v) => controller.validateName(v!.trim()),
                    ),

                    SizedBox(height: 15.h),

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

                    SizedBox(height: 15.h),

                    /// PASSWORD FIELD
                    Text("Password", style: AppTextStyles.body3(context).copyWith(color: AppColors.subTextColor)),
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

                    /// TERMS
                    /// TERMS & CONDITIONS
                    Obx(() => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            value: controller.isTermsAccepted.value,
                            onChanged: (value) => controller.isTermsAccepted.value = value ?? false,
                            activeColor: AppColors.primaryColor,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: AppTextStyles.body3(context),
                              children: [
                                const TextSpan(text: "I agree with all "),
                                TextSpan(
                                  text: "Terms",
                                  style: AppTextStyles.body3(context).copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => PrivacyPage()),
                                ),
                                const TextSpan(text: " and "),
                                TextSpan(
                                  text: "Conditions",
                                  style: AppTextStyles.body3(context).copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.blackColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => PrivacyPage()),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),


                    SizedBox(height: 20.h),

                    /// SIGN UP BUTTON
                    PrimaryButton(
                      onPressed: () => controller.signUp(_formKey),
                      text: "Create An Account",
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
