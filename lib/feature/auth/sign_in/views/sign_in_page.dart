import 'package:anniet2020/core/constant/app_text_styles.dart';
import 'package:anniet2020/core/constant/widgets/primary_button.dart';
import 'package:anniet2020/feature/auth/forgot_password/views/forgot_password_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/constant/app_colors.dart';
import '../../sign_up/views/sign_up_page.dart';
import '../controllers/sign_in_controller.dart';

class SignInPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(SignInController());

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
        child: Column(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.064),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title + Subtitle
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Let’s Sign you in",
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
                        /// Email
                        Text("Email Address", style: AppTextStyles.body3(context).copyWith(color: AppColors.subTextColor)),
                        SizedBox(height: 6.h),
                        TextFormField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Enter your email address",
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

                        /// Remember Me + Forgot Password
                        Row(
                          children: [
                            Obx(() => Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                value: controller.rememberMe.value,
                                onChanged: (v) => controller.rememberMe.value = v!,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                              ),
                            )),
                            SizedBox(width: 8.w),
                            Text("Remember Me", style: AppTextStyles.body3_400(context)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => Get.to(() => ForgotPasswordPage()),
                              child: Text(
                                "Forgot Password",
                                style: AppTextStyles.body3_400(context).copyWith(color: AppColors.redColor),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        /// SIGN IN BUTTON
                        PrimaryButton(
                          onPressed: () => controller.signIn(_formKey),
                          text: "Sign In",
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15.h),

                  /// SIGN UP LINK
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don’t have an account? ", style: AppTextStyles.body3(context).copyWith(fontSize: 16.sp)),
                      GestureDetector(
                        onTap: () => Get.to(() => SignUpPage()),
                        child: Text(
                          "Sign Up", style: AppTextStyles.body3(context).copyWith(fontSize: 16.sp, color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// TERMS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.064),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.body3(context), // default style
                    children: [
                      TextSpan(text: "By signing up you agree to our ", ),
                      /// TERMS
                      TextSpan(
                          text: "Terms",
                          style: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor, fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                        //..onTap = () => Get.to(() => TermsPage()),
                      ),
                      TextSpan(text: " and ", ),
                      /// CONDITIONS OF USE
                      TextSpan(
                          text: "Conditions of Use",
                          style: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor, fontWeight: FontWeight.w600),
                          recognizer: TapGestureRecognizer()
                        //..onTap = () => Get.to(() => ConditiosPage()),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: sh * 0.02),
          ],
        ),
      ),
    );
  }
}
