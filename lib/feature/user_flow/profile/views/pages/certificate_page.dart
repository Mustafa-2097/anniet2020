import 'package:anniet2020/core/constant/image_path.dart';
import 'package:anniet2020/feature/user_flow/profile/controllers/help_support_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../../../core/constant/app_colors.dart';

class CertificatePage extends StatelessWidget {
  CertificatePage({super.key});
  final controller = Get.put(HelpSupportController());

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
          "Certificate",
          style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2.w, color: AppColors.greyColor),
            borderRadius: BorderRadius.circular(20.r), // rounded corners
          ),
          elevation: 0,
          color: AppColors.whiteColor,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h, top: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Blue container (top part)
                Container(
                  height: 110.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "The Don’t Blow Your License",
                        style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, height: 1.5, color: AppColors.whiteColor),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Certificate",
                        style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.5, color: AppColors.greenColor),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // Date row
                Row(
                  children: [
                    Icon(Icons.calendar_month_outlined, size: 20.r, color: AppColors.boxTextColor),
                    SizedBox(width: 5.w),
                    Text(
                      "Until 31 Jul, 2030",
                      style: TextStyle(color: AppColors.boxTextColor, fontSize: 12.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                // Download Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            insetPadding: EdgeInsets.zero,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Your Certificate",
                                    style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                                  ),
                                  SizedBox(height: 10),
                                  // Certificate Image
                                  Image.asset(
                                    ImagePath.certificate,
                                    width: 300,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () => Get.back(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24.r),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                                    ),
                                    child: Text(
                                      "Close",
                                      style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, height: 1.5, color: AppColors.whiteColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                    ),
                    child: Text(
                      "Download Certificate",
                      style: GoogleFonts.plusJakartaSans(fontSize: 14.sp, fontWeight: FontWeight.w600, height: 1.5, color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
      ,
    );
  }
}
