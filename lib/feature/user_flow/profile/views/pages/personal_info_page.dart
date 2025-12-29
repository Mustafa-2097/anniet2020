import 'dart:io';
import 'package:anniet2020/feature/user_flow/profile/controllers/personal_info_controller.dart';
import 'package:anniet2020/feature/user_flow/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constant/app_colors.dart';
import 'package:get/get.dart';

class PersonalInfoPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(PersonalInfoController());
  final profile = Get.find<ProfileController>();
  PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
        ),
      ),

      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // ---------- BLUE HEADER ----------
            Container(
              height: 180.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff0A4C9C), Color(0xff0A6AC0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  /// Profile Image
                  Obx(() {
                    ImageProvider? image;
                    if (controller.previewImagePath.value != null) {
                      image = FileImage(File(controller.previewImagePath.value!));
                    } else if (profile.avatarUrl.value != null && profile.avatarUrl.value!.isNotEmpty) {
                      image = profile.avatarUrl.value!.startsWith('http')
                          ? NetworkImage(profile.avatarUrl.value!)
                          : FileImage(File(profile.avatarUrl.value!));
                    }
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 45.w,
                          backgroundColor: Colors.grey.shade400,
                          backgroundImage: image,
                          child: image == null
                              ? Icon(Icons.person, size: 50.r, color: Colors.white)
                              : null,
                        ),
                        // In the GestureDetector for camera icon:
                        Obx(() {
                          return GestureDetector(
                            onTap: controller.isPickingImage.value ? null : controller.pickImage,
                            child: CircleAvatar(
                              radius: 15.r,
                              backgroundColor: Colors.white,
                              child: controller.isPickingImage.value
                                  ? SizedBox(
                                width: 16.r,
                                height: 16.r,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                                  : Icon(Icons.camera_alt_outlined, size: 16.r, color: Colors.blue),
                            ),
                          );
                        }),
                      ],
                    );
                  }),

                  SizedBox(height: 10.h),

                  Obx(() {
                    return Text(
                      profile.userName.value,
                      style: TextStyle(color: Colors.white, fontSize: 17.sp),
                    );
                  }),
                ],
              ),
            ),

            // ---------- CARDS BELOW HEADER ----------
            Positioned(
              top: 160.h,   // ⬅ Overlap adjust height
              left: 0,
              right: 0,
              child: Card(
                elevation: 1,
                margin: EdgeInsets.symmetric(horizontal: 16.r),
                color: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(Icons.person_outline, "Personal Information"),
                        SizedBox(height: 12.h),

                        /// Full Name
                        Text("Full Name", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 6.h),
                        _formField(
                          controller: controller.nameController,
                          hint: "Enter your full name",
                          keyboard: TextInputType.name,
                          validator: (v) => controller.validateName(v!.trim()),
                        ),

                        SizedBox(height: 20.h),

                        _sectionTitle(Icons.mail_outline, "Contact Information"),
                        SizedBox(height: 12.h),

                        /// Email (Disabled)
                        Text("Email", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 6.h),
                        _formField(
                          controller: controller.emailController,
                          hint: "Your email",
                          enabled: false,
                          suffix: const Icon(Icons.lock_outline),
                        ),

                        SizedBox(height: 15.h),

                        /// Phone
                        Text("Phone", style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            /// Country Code
                            Container(
                              width: 80.w,
                              height: 52.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(controller.countryCode),
                            ),
                            SizedBox(width: 10.w),

                            /// Phone Input
                            Expanded(
                              child: _formField(
                                controller: controller.phoneController,
                                hint: "xxx xxx xxx",
                                keyboard: TextInputType.phone,
                                validator: (v) => controller.validatePhone(v!.trim()),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h, bottom: 20.h),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            /// CANCEL BUTTON
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () => Get.back(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.close, size: 18.r, color: Colors.black),
                    SizedBox(width: 4.w),
                    Text("Cancel", style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.w),
            /// SAVE BUTTON
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                onPressed: () => controller.infoChange(_formKey),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_outlined, size: 18, color: Colors.white),
                    SizedBox(width: 4.w),
                    Text("Save Changes", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Title Widget
  Widget _sectionTitle(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor),
        SizedBox(width: 8.w),
        Text(text, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
      ],
    );
  }

  /// Reusable Input Field
  Widget _formField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboard = TextInputType.text,
    String? Function(String?)? validator,
    bool enabled = true,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: validator,
      enabled: enabled,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF6F6F6),
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

}


