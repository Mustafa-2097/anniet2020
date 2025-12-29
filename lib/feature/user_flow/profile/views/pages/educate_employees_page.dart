import 'package:anniet2020/core/constant/app_colors.dart';
import 'package:anniet2020/core/constant/app_text_styles.dart';
import 'package:anniet2020/core/constant/widgets/primary_button.dart';
import 'package:anniet2020/feature/user_flow/profile/controllers/educate_employees_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class EducateEmployeesPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(EducateEmployeesController());
  EducateEmployeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.r),
          child: BackButton(color: AppColors.blackColor),
        ),
        title: Text(
          "Educate Employee",
          style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// FULL NAME
              Text("Full Name", style: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor)),
              SizedBox(height: 6.h),
              TextFormField(
                controller: controller.nameController,
                enabled: false,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.lock_outline),
                  filled: true,
                  fillColor: const Color(0xFFF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              /// EMAIL
              Text("Email", style: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor)),
              SizedBox(height: 6.h),
              TextFormField(
                controller: controller.emailController,
                enabled: false,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.lock_outline),
                  filled: true,
                  fillColor: const Color(0xFFF6F6F6),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 15.h),

              /// COMPANY NAME
              Text("Company Name", style: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor)),
              SizedBox(height: 6.h),
              TextFormField(
                controller: controller.companyController,
                decoration: _inputDecoration("Your Company", context).copyWith(hintStyle: TextStyle(color: AppColors.boxTextColor))
                    .copyWith(contentPadding: EdgeInsets.all(16.w)),
                validator: (v) => controller.validateCompany(v!.trim()),
              ),
              SizedBox(height: 15.h),

              /// EMPLOYEE COUNT — DROPDOWN
              Text("How many employees do you want to educate?", style: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor)),
              SizedBox(height: 6.h),
              Obx(() => Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: DropdownButton<String>(
                  value: controller.employeeCount.value,
                  isExpanded: true,
                  underline: const SizedBox(),
                  items: [
                    "1-10",
                    "11-50",
                    "51-200",
                    "200+"
                  ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) => controller.employeeCount.value = value!,
                ),
              ),
              ),

              SizedBox(height: 15.h),

              /// MESSAGE BOX
              Text("How can we help?", style: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor)),
              SizedBox(height: 6.h),
              TextFormField(
                controller: controller.messageController,
                maxLines: 6,
                decoration: _inputDecoration("Write your message...", context).copyWith(hintStyle: TextStyle(color: AppColors.boxTextColor))
                    .copyWith(contentPadding: EdgeInsets.all(16.w)),
                validator: (v) => controller.validateMessage(v!.trim()),
              ),

              SizedBox(height: 20.h),

              /// SEND BUTTON
              PrimaryButton(
                onPressed: () => controller.educateEmployee(_formKey),
                text: "Send",
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable Input Decoration
  InputDecoration _inputDecoration(String hint, BuildContext context) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.body3(context).copyWith(color: AppColors.blackColor),
      filled: true,
      fillColor: const Color(0xFFF6F6F6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.r),
        borderSide: BorderSide.none,
      ),
    );
  }
}
