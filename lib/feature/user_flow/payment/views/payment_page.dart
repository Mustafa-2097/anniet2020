import 'package:anniet2020/core/constant/image_path.dart';
import 'package:anniet2020/core/constant/widgets/primary_button.dart';
import 'package:anniet2020/feature/user_flow/payment/views/pages/add_new_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constant/app_colors.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

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
          "Payment",
          style: GoogleFonts.plusJakartaSans(fontSize: 18.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          children: [
            /// Profile Section
            Row(
              children: [
                // Avatar Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: Image.asset(ImagePath.payment, height: 140.h, width: 150.w, fit: BoxFit.cover),
                ),

                SizedBox(width: 14),

                // Text Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Don’t Blow Your Licence",
                        style: GoogleFonts.plusJakartaSans(fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppColors.blackColor),
                      ),

                      SizedBox(height: 6.h),

                      Text(
                        "Dr. Andrew Collins",
                        style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.blackColor, fontWeight: FontWeight.w600),
                      ),

                      Text(
                        "Senior Road Safety Instructor",
                        style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: AppColors.subTextColor, fontWeight: FontWeight.w400),
                      ),

                      SizedBox(height: 10.h),

                      // Rating Row
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          SizedBox(width: 4),
                          Text(
                            "4.4",
                            style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, color: Color(0xFFFFCD1A), fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: 4),
                          Text(
                            "(532)",
                            style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.subTextColor),
                          ),
                        ],
                      ),

                      // Time & Lesson Row
                      Row(
                        children: [
                          Text(
                            "1h 15m",
                            style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "•",
                            style: TextStyle(fontSize: 24.sp, color: AppColors.primaryColor),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            "06 Lesson",
                            style: GoogleFonts.plusJakartaSans(fontSize: 12.sp, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 30.h),

            ///
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2.w, color: AppColors.greyColor),
                borderRadius: BorderRadius.circular(20.r),
              ),
              elevation: 0,
              color: AppColors.whiteColor,
              child: Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 24.h, top: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Subtotal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subtotal",
                          style: TextStyle(color: AppColors.subTextColor, fontSize: 12.sp, fontWeight: FontWeight.w600),
                        ),

                        Text(
                          "\$248",
                          style: TextStyle(color: AppColors.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    /// Discount
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discount",
                          style: TextStyle(color: AppColors.subTextColor, fontSize: 12.sp, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "-\$40",
                          style: TextStyle(color: AppColors.redColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),
                    Divider(color: AppColors.greyColor),
                    SizedBox(height: 12.h),

                    // Total Cost
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Cost",
                          style: TextStyle(color: AppColors.blackColor, fontSize: 12.sp, fontWeight: FontWeight.w400),
                        ),

                        Text(
                          "\$208",
                          style: TextStyle(color: AppColors.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            /// Payment Button
            PrimaryButton(
              onPressed: () => Get.to(() => AddNewCard()),
              text: "Payment",
            ),
            SizedBox(height: 10.h),
          ],
        ),
      )
      ,
    );
  }
}
