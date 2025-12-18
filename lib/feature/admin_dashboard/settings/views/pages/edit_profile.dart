import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/image_path.dart';
import '../../controllers/edit_profile_controller.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});
  final controller = Get.put(EditProfileController());

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
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 45.w,
                          backgroundImage: controller.pickedImage.value != null
                              ? FileImage(File(controller.pickedImage.value!.path))
                              : const AssetImage(ImagePath.user),
                        ),

                        GestureDetector(
                          onTap: controller.pickImage,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.camera_alt_outlined, size: 16, color: Colors.blue),
                          ),
                        ),
                      ],
                    );
                  }),

                  SizedBox(height: 10.h),

                  Obx(() {
                    return Text(
                      controller.fullName.value,
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
              child: Column(
                children: [
                  /// PERSONAL INFO CARD
                  Card(
                    elevation: 1,
                    margin: EdgeInsets.symmetric(horizontal: 16.r),
                    color: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle(Icons.person_outline, "Personal Information"),
                          SizedBox(height: 10.h),
                          _inputField(
                            label: "Full Name",
                            initialValue: controller.fullName.value,
                            onChanged: (v) => controller.fullName.value = v,
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  /// CONTACT INFO CARD
                  Card(
                    elevation: 1,
                    margin: EdgeInsets.symmetric(horizontal: 16.r),
                    color: AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle(Icons.mail_outline, "Contact Information"),
                          SizedBox(height: 10.h),
                          _inputField(
                            label: "Email Address",
                            initialValue: controller.email.value,
                            onChanged: (v) => controller.email.value = v,
                          ),
                          SizedBox(height: 10.h),
                          _inputField(
                            label: "Phone Number",
                            initialValue: controller.phone.value,
                            onChanged: (v) => controller.phone.value = v,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                ],
              ),
            ),


          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                onPressed: controller.saveProfile,
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
  Widget _inputField({
    required String label,
    required String initialValue,
    TextInputType keyboard = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500, color: AppColors.boxTextColor)),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: TextFormField(
            initialValue: initialValue,
            keyboardType: keyboard,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: InputBorder.none
            ),
          ),
        ),
      ],
    );
  }
}
