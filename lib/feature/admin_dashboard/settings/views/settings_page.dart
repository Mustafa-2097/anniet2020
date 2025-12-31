import 'package:anniet2020/feature/admin_dashboard/settings/views/pages/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';
import '../../../../core/constant/widgets/logout_button.dart';
import '../controllers/get_me_profile_controller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final controller = Get.put(AdminProfileController());

  @override
  Widget build(BuildContext context) {
    // Fetch profile data when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProfile();
    });

    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Settings",
          style: GoogleFonts.notoSans(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.isError.value) {
          return Center(child: Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red)));
        }
        final profileData = controller.profile.value;
        if (profileData == null) {
          return const Center(child: Text('No profile data available'));
        }
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------------- PROFILE INFO BOX ----------------
              Card(
                elevation: 1,
                shadowColor: Colors.black,
                color: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Profile Information",
                            style: GoogleFonts.notoSans(fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                            onPressed: () => Get.to(() => EditProfilePage()),
                            icon: Icon(Icons.edit, size: 20, color: Colors.blueAccent),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        children: [
                          /// USER IMAGE
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: profileData.profile.avatar != null && profileData.profile.avatar!.isNotEmpty
                                ? Image.network(
                              profileData.profile.avatar!,
                              height: 60.w,
                              width: 60.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                ImagePath.user,
                                height: 60.w,
                                width: 60.w,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Image.asset(
                              ImagePath.user,
                              height: 60.w,
                              width: 60.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 14.w),
                          /// USER NAME
                          Text(
                            profileData.profile.name,
                            style: GoogleFonts.notoSans(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Divider(),
                      SizedBox(height: 6.h),
                      /// CONTACT NUMBER
                      Row(
                        children: [
                          Icon(Icons.phone, size: 20, color: Colors.grey),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Contact",
                                style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.boxTextColor),
                              ),
                              Text(
                                profileData.profile.phone,
                                style: GoogleFonts.notoSans(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      /// EMAIL
                      Row(
                        children: [
                          Icon(Icons.email_outlined, size: 20, color: Colors.grey),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email",
                                style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w400, color: AppColors.boxTextColor),
                              ),
                              Text(
                                profileData.email,
                                style: GoogleFonts.notoSans(fontSize: 14.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // ---------------- CHANGE PASSWORD BOX ----------------
              Card(
                elevation: 1,
                shadowColor: Colors.black,
                color: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Change Password",
                        style: GoogleFonts.notoSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _passwordField("Current Password", 1),
                      SizedBox(height: 14.h),
                      _passwordField("New Password", 2),
                      SizedBox(height: 14.h),
                      _passwordField("Confirm New Password", 3),
                      SizedBox(height: 20.h),
                      // UPDATE PASSWORD BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 45.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff1464C0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          onPressed: () {
                            String oldPass = controller.oldPasswordController.text;
                            String newPass = controller.newPasswordController.text;
                            String confirmPass = controller.confirmPasswordController.text;

                            if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
                              Get.snackbar("Error", "All fields are required", backgroundColor: AppColors.redColor);
                              return;
                            }

                            if (newPass != confirmPass) {
                              Get.snackbar("Error", "New passwords do not match", backgroundColor: AppColors.redColor);
                              return;
                            }

                            controller.changePassword(oldPassword: oldPass, newPassword: newPass);
                          },
                          child: Text("Update Password", style: GoogleFonts.plusJakartaSans(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ---------------- LOGOUT BUTTON ----------------
              LogoutButton(),
            ],
          ),
        );
      }),
    );
  }

  /// PASSWORD INPUT FIELD
  Widget _passwordField(String label, int fieldIndex) {
    return Obx(() {
      bool isVisible = false;
      TextEditingController textController;

      if (fieldIndex == 1) {
        isVisible = controller.showOldPassword.value;
        textController = controller.oldPasswordController;
      } else if (fieldIndex == 2) {
        isVisible = controller.showNewPassword.value;
        textController = controller.newPasswordController;
      } else {
        isVisible = controller.showConfirmPassword.value;
        textController = controller.confirmPasswordController;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label*", style: GoogleFonts.notoSans(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.boxTextColor)),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: textController,
              obscureText: !isVisible,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: label,
                suffixIcon: GestureDetector(
                  onTap: () => controller.togglePassword(fieldIndex),
                  child: Icon(
                    isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 22.r,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}