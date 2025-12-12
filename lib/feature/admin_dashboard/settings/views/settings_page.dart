import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/image_path.dart';
import '../../../../core/constant/widgets/logout_button.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Settings",
          style: GoogleFonts.notoSans(
            fontSize: 18.sp,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------------- PROFILE INFO BOX ----------------
            Card(
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.15),
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
                        Icon(Icons.edit, size: 20, color: Colors.blueAccent),
                      ],
                    ),

                    SizedBox(height: 14.h),

                    Row(
                      children: [
                        /// USER IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.r),
                          child: Image.asset(
                            ImagePath.user,
                            height: 60.w,
                            width: 60.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 14.w),

                        /// USER NAME
                        Text(
                          "Joohn Emily Carter",
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
                              "+84 0373467950",
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
                              "giangbanganh@gmail.com",
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
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.15),
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

                    _passwordField("Current Password"),
                    SizedBox(height: 14.h),

                    _passwordField("New Password"),
                    SizedBox(height: 14.h),

                    _passwordField("Confirm New Password"),
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
                        onPressed: () {},
                        child: Text(
                          "Update Password",
                          style: GoogleFonts.notoSans(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
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
      ),
    );
  }

  /// PASSWORD INPUT FIELD
  Widget _passwordField(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label *",
          style: GoogleFonts.notoSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: label,
              suffixIcon: Icon(Icons.visibility_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
