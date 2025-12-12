import 'package:anniet2020/core/constant/image_path.dart';
import 'package:anniet2020/feature/admin_dashboard/admin_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../Educate/views/educate_page.dart';

class CustomAppDrawer extends StatelessWidget {
  final void Function()? onLogoutTap;

  const CustomAppDrawer({super.key, this.onLogoutTap});

  @override
  Widget build(BuildContext context) {
    //final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    return Drawer(
      child: SafeArea(
        child: Container(
          color: AppColors.whiteColor,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: sw*0.076),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Icon
              Image.asset(ImagePath.splashLogo, color: AppColors.primaryColor,),
              SizedBox(height: 30.h),
              _DrawerItem(
                icon: Icons.dashboard_outlined,
                label: 'Dashboard',
                onTap: () => Get.offAll(() => AdminDashboard(initialIndex: 0)),
              ),
              SizedBox(height: 10.h),
              _DrawerItem(
                icon: Icons.people_alt_outlined,
                label: 'User',
                onTap: () => Get.offAll(() => AdminDashboard(initialIndex: 1)),
              ),

              SizedBox(height: 10.h),
              _DrawerItem(
                icon: Icons.payment_outlined,
                label: 'Payment List',
                onTap: () => Get.offAll(() => AdminDashboard(initialIndex: 2)),
              ),
              SizedBox(height: 10.h),
              _DrawerItem(
                icon: Icons.messenger_outline,
                label: 'Contact Request',
                onTap: () => Get.offAll(() => AdminDashboard(initialIndex: 3)),
              ),

              SizedBox(height: 10.h),
              _DrawerItem(
                icon: Icons.school_outlined,
                label: 'Educate Request',
                onTap: () => Get.offAll(() => EducatePage()),
              ),
              SizedBox(height: 10.h),
              _DrawerItem(
                icon: Icons.reviews_outlined,
                label: 'Review',
                onTap: () {},
              ),
              SizedBox(height: 10.h),
              _DrawerItem(
                icon: Icons.lock_outline,
                label: 'Setting',
                onTap: () => Get.offAll(() => AdminDashboard(initialIndex: 4)),
              ),

              SizedBox(height: 30.h),

              /// Logout Button
              GestureDetector(
                onTap: () {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Color(0xFFDF1C41), size: 16.r, fontWeight: FontWeight.bold),
                    SizedBox(width: 6.w),
                    Text(
                      'Logout',
                      style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function()? onTap;

  const _DrawerItem({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            Icon(icon, size: 24.r, color: AppColors.blackColor.withOpacity(0.8)),
            SizedBox(width: 16.w),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
