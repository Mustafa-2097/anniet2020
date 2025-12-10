import 'package:anniet2020/feature/user_flow/profile/views/pages/certificate_page.dart';
import 'package:anniet2020/feature/user_flow/profile/views/pages/contact_us_page.dart';
import 'package:anniet2020/feature/user_flow/profile/views/pages/help_support_page.dart';
import 'package:anniet2020/feature/user_flow/profile/views/pages/personal_info_page.dart';
import 'package:anniet2020/feature/user_flow/profile/views/pages/privacy_page.dart';
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
      backgroundColor: AppColors.whiteColor,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Image
                Image.asset(ImagePath.user, width: 56.w, fit: BoxFit.contain),
                SizedBox(width: 14.w),

                // Name + Username
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Brooklyn Simmons",
                        style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                      ),
                      Text(
                        "@Brokklyn",
                        style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.subTextColor),
                      ),
                    ],
                  ),
                ),

                /// Edit Icon
                IconButton(
                  onPressed: () => Get.to(() => PersonalInfoPage()),
                  icon: Icon(Icons.edit_outlined, size: 22.r, color: AppColors.blackColor),
                ),
              ],
            ),

            SizedBox(height: 25.h),

            /// Setting Title
            Text(
              "Setting",
              style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.boxTextColor),
            ),

            SizedBox(height: 10.h),

            /// Menu List Items
            GestureDetector(
              onTap: () => Get.to(() => CertificatePage()),
              child: _menuItem(
                icon: Icons.insert_drive_file_outlined,
                title: "Certificate",
              ),
            ),

            GestureDetector(
              onTap: () => Get.to(() => ContactUsPage()),
              child: _menuItem(
                icon: Icons.chat_bubble_outline,
                title: "Contact Us",
              ),
            ),

            GestureDetector(
              onTap: () => Get.to(() => HelpSupportPage()),
              child: _menuItem(
                icon: Icons.help_outline,
                title: "Help and Support",
              ),
            ),

            GestureDetector(
              onTap: () => Get.to(() => PrivacyPage()),
              child: _menuItem(
                icon: Icons.article_outlined,
                title: "Legal and Policies",
              ),
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
                      insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 100.h),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 40.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ///Image
                            Image.asset(ImagePath.logoutIcon, height: 120.h),
                            SizedBox(height: 6.h),

                            /// Title
                            Text(
                              'Are You Sure?',
                              style: GoogleFonts.plusJakartaSans(color: AppColors.blackColor, fontSize: 18.sp, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8.h),

                            /// Subtitle
                            Text(
                              "Do you want to log out ?",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.plusJakartaSans(color: AppColors.subTextColor, fontSize: 14.sp, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 20.h),

                            /// Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 40.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24.r),
                                        side: BorderSide(width: 1.3.w)
                                      ),
                                      backgroundColor: AppColors.whiteColor,
                                    ),
                                    onPressed: () {}, // go to sign in page...
                                    child: Text(
                                      "Log Out",
                                      style: GoogleFonts.plusJakartaSans(color: AppColors.redColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 40.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24.r),
                                      ),
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      "Cancel",
                                      style: GoogleFonts.plusJakartaSans(color: AppColors.whiteColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
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
                  style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.redColor),
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
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Divider(thickness: 1.w, color: AppColors.boxTextColor),
      ],
    );
  }
}
