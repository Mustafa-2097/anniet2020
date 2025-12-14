import 'package:anniet2020/core/constant/image_path.dart';
import 'package:anniet2020/feature/user_flow/profile/controllers/personal_info_controller.dart';
import 'package:anniet2020/feature/user_flow/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_text_styles.dart';
import '../../../../../core/constant/widgets/primary_button.dart';
import 'package:get/get.dart';

class PersonalInfoPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(PersonalInfoController());
  PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.r),
          child: const BackButton(color: Colors.black),
        ),
        title: Text("Personal Info", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Full Name
              Text("Full Name", style: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor)),
              SizedBox(height: 6.h),
              TextFormField(
                controller: controller.nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Enter your full name",
                  hintStyle: AppTextStyles.body3(context),
                  filled: true,
                  fillColor: const Color(0xFFF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (v) => controller.validateName(v!.trim()),
              ),

              SizedBox(height: 15.h),

              /// Email
              Text("Email", style: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor)),
              SizedBox(height: 6.h),
              TextFormField(
                controller: controller.emailController,
                enabled: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Your email",
                  hintStyle: AppTextStyles.body3(context),
                  filled: true,
                  fillColor: const Color(0xFFF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.r),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(Icons.lock_outline),
                ),
              ),

              SizedBox(height: 15.h),

              /// PHONE FIELD
              Text("Phone", style: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor)),
              SizedBox(height: 6.h),
              Row(
                children: [
                  /// Australia Code Box
                  Container(
                    width: 90.w,
                    height: 52.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      controller.countryCode, // +61
                      style: AppTextStyles.body3(context),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  /// Phone Input
                  Expanded(
                    child: TextFormField(
                      controller: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "xxx xxx xxx",
                        hintStyle: AppTextStyles.body3(context),
                        filled: true,
                        fillColor: const Color(0xFFF6F6F6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (v) => controller.validatePhone(v!.trim()),
                    ),
                  ),
                ],
              ),


              SizedBox(height: 130.h),

              /// SIGN UP BUTTON
              PrimaryButton(
                onPressed: () => controller.infoChange(_formKey),
                text: "Save Changes",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
