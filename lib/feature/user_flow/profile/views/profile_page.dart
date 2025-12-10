import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        title: Text("Profile", style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color:  AppColors.blackColor)),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Section
            Row(
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 32.r,
                  backgroundImage: AssetImage("assets/profile.png"),
                ),
                SizedBox(width: 14.w),

                // Name + Username
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Brooklyn Simmons",
                        style: GoogleFonts.plusJakartaSans(fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "@Brokklyn",
                        style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),

                /// Edit Icon
                Icon(Icons.edit_outlined, size: 22.r, color: AppColors.blackColor),
              ],
            ),

            SizedBox(height: 25.h),

            /// Setting Title
            Text(
              "Setting",
              style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
            ),

            SizedBox(height: 10.h),

            /// Menu List Items
            _menuItem(
              icon: Icons.insert_drive_file_outlined,
              title: "Certificate",
            ),

            _menuItem(
              icon: Icons.chat_bubble_outline,
              title: "Contact Us",
            ),

            _menuItem(
              icon: Icons.help_outline,
              title: "Help and Support",
            ),

            _menuItem(
              icon: Icons.article_outlined,
              title: "Legal and Policies",
            ),

            SizedBox(height: 25.h),

            /// Logout Button
            Center(
              child: TextButton(
                onPressed: () {
                  Get.dialog(
                    Dialog(
                      backgroundColor: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      insetPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 100.h),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 40.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ///Image
                            Image.asset(ImagePath.successLogo, height: 140.h),
                            SizedBox(height: 12.h),

                            /// Title
                            Text(
                              'Success',
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.blackColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),

                            /// Subtitle
                            Text(
                              "subtitle",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.subTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 15.h),

                            /// Continue Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.r),
                                ),
                                backgroundColor: AppColors.primaryColor,
                              ),
                              onPressed: () {},
                              child: Text(
                                "Continue",
                                style: GoogleFonts.plusJakartaSans(color: AppColors.whiteColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    barrierDismissible: true,
                  );
                },
                child: Text(
                  "Logout",
                  style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.redColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Single Menu Item Widget
  Widget _menuItem({required IconData icon, required String title}) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        Row(
          children: [
            Icon(icon, size: 22.r, color: AppColors.blackColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Divider(thickness: 1, color: AppColors.greyColor),
      ],
    );
  }
}
