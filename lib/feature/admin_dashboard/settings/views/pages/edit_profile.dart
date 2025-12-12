import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/edit_profile_controller.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});
  final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),

        title: Text(
          "Edit Profile",
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
        ),

        actions: [
          TextButton(
            onPressed: () {},
            child: Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: controller.saveProfile,
            child: Text(
              "Save",
              style: TextStyle(color: Colors.blue, fontSize: 15.sp),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // --------- BLUE HEADER ---------
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  /// Profile Image
                  Obx(() {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 45.w,
                          backgroundImage: controller.pickedImage.value != null
                              ? FileImage(File(controller.pickedImage.value!.path))
                              : NetworkImage("https://i.pravatar.cc/150?img=45")
                          as ImageProvider,
                        ),

                        /// Camera Icon
                        GestureDetector(
                          onTap: controller.pickImage,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.camera_alt, size: 16, color: Colors.blue),
                          ),
                        ),
                      ],
                    );
                  }),

                  SizedBox(height: 10.h),

                  /// Name Display
                  Obx(() {
                    return Text(
                      controller.fullName.value,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }),

                  SizedBox(height: 20.h),
                ],
              ),
            ),

            // ----------- WHITE CARD AREA -----------
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 10.h),

                  // ---------------- PERSONAL INFO ----------------
                  _sectionTitle("Personal Information"),

                  SizedBox(height: 10.h),
                  _inputField(
                    label: "Full Name",
                    initialValue: controller.fullName.value,
                    onChanged: (val) => controller.fullName.value = val,
                  ),

                  SizedBox(height: 20.h),

                  // ---------------- CONTACT INFO ----------------
                  _sectionTitle("Contact Information"),

                  SizedBox(height: 10.h),
                  _inputField(
                    label: "Email Address",
                    initialValue: controller.email.value,
                    keyboard: TextInputType.emailAddress,
                    onChanged: (val) => controller.email.value = val,
                  ),

                  SizedBox(height: 14.h),

                  _inputField(
                    label: "Phone Number",
                    initialValue: controller.phone.value,
                    keyboard: TextInputType.phone,
                    onChanged: (val) => controller.phone.value = val,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Title Widget
  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  // Reusable Input Field
  Widget _inputField({
    required String label,
    required String initialValue,
    TextInputType keyboard = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),

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
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
