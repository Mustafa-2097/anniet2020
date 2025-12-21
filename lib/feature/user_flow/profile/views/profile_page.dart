import 'dart:io';
import 'package:anniet2020/feature/user_flow/profile/views/pages/certificate_page.dart';
import 'package:anniet2020/feature/user_flow/profile/views/pages/contact_us_page.dart';
import 'package:anniet2020/feature/user_flow/profile/views/pages/educate_employees_page.dart';
import 'package:anniet2020/feature/user_flow/profile/views/pages/help_support_page.dart';
import 'package:anniet2020/feature/user_flow/profile/views/pages/personal_info_page.dart';
import 'package:anniet2020/feature/user_flow/profile/views/pages/privacy_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/widgets/logout_button.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final controller = Get.put(ProfileController());

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
                Obx(() {
                  final avatar = controller.avatarUrl.value;
                  final bool hasApiImage = avatar != null && avatar.isNotEmpty && avatar.startsWith('http');
                  return CircleAvatar(
                    radius: 28.r,
                    backgroundColor: AppColors.boxTextColor,
                    backgroundImage: hasApiImage ? NetworkImage(avatar) : null,
                    child: hasApiImage
                        ? null
                        : Icon(Icons.person, size: 40.r, color: Colors.white),
                  );
                }),
                SizedBox(width: 14.w),

                // Name + Username
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(
                        controller.userName.value,
                        style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                      )),
                      Obx(() => Text(
                        controller.userHandle.value,
                        style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w400, color: AppColors.subTextColor),
                      )),
                    ],
                  ),
                ),

                // Edit Icon
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
              onTap: () => Get.to(() => EducateEmployeesPage()),
              child: _menuItem(
                icon: Icons.school_outlined,
                title: "Educate your employees",
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
            LogoutButton(),
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
